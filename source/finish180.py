from pathlib import Path
import json,shutil
p=Path('revision/pack');f=p/'data/oa/function'
def w(x,s):x.parent.mkdir(parents=True,exist_ok=True);x.write_text(s)
def add(x,s):w(x,x.read_text()+'\n'+s+'\n')
# Enlarged players need 1.6m horizontal and 4.6m vertical clearance at destinations.
x=f/'tayayuyu/move/check.mcfunction';s=x.read_text().replace('~-0.55','~-0.8').replace('~0.55','~0.8');extra=[]
for dx in [-.8,.8]:
 for dz in [-.8,.8]:
  for y in [3.8,4.6]:extra.append(f'execute unless block ~{dx} ~{y} ~{dz} #minecraft:air run return run scoreboard players set #g_loc_ok oa.tmp 0')
s=s.replace('execute store result score #g_dx oa.tmp','\n'.join(extra)+'\nexecute store result score #g_dx oa.tmp',1);w(x,s)
# Follow-up skills do not apply extra debuffs on an immune throw hit.
x=f/'throwable/observe/hit.mcfunction';s=x.read_text();s=s.replace('scoreboard players set #hit oa.tmp 1','scoreboard players set #hit oa.tmp 1\nscoreboard players set @s oa.blocked 0\nexecute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll\nexecute if score @s oa.blocked matches 1 run return 0',1);w(x,s)
# Native reload epochs can remove items' guard flags; no immunity survives unequipping.
add(f/'internal/cleanup.mcfunction','tag @s remove oa.curse_guard')
# Carry probability changes in descriptions without displaying damage numbers in weapon lore.
x=p/'data/oa/item_modifier/lore/k5.json';s=x.read_text().replace('敵の攻撃を時々無効化','参加者の攻撃を25%で無効化');w(x,s)
# New guide can be opened outside a lobby if explicitly requested; automatic copies stay scoped.
add(f/'lobby/guide/watch.mcfunction','tellraw @s {text:"[参加者へ戻る]",color:"green",click_event:{action:"run_command",command:"/trigger oa.lobby set 6"}}')
# Give a visible name to dropped special throwables.
w(f/'furoball/ground.mcfunction','''execute if data entity @s Item.components."minecraft:custom_name" run data modify entity @s CustomName set from entity @s Item.components."minecraft:custom_name"
data merge entity @s {CustomNameVisible:1b}
tag @s add oa.furo_named
''')
add(f/'world_tick.mcfunction','execute as @e[type=minecraft:item,tag=!oa.furo_named,nbt={Item:{components:{"minecraft:custom_data":{oa_furoball:1b}}}}] run function oa:furoball/ground')
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.7.2','1.8.0')
  if x.suffix=='.md':t=t.replace('1.75倍','2.5倍').replace('攻撃を10%で無効化','攻撃を25%で無効化')
  if t!=s:w(x,t)
x=p/'WEAPONS_JA.md';s=x.read_text();s+='''
## キリングの無効化判定
参加プレイヤー由来の攻撃を25%で無効化します。ゆうあの即死攻撃・即死反撃も対象です。エリア外など環境ダメージは対象外です。バニラが同一攻撃中に免疫条件を複数回評価するため、毎tick1回の25%抽選結果をそのtickの全判定で共有します。同じtickに複数回攻撃された場合は同じ結果になります。
専用スキル・ゆうあの反撃等の無効化時には紫の閃光・花火・ポータル粒子と盾・共鳴・花火の音を出します。通常の近接／矢などがバニラの免疫で完全に防がれたときは被弾イベント自体が発生せず、その瞬間だけの演出検知は未対応です。攻撃していないのに演出する推定処理は行いません。

## ふろボール
固有装備とは別枠の投てき消耗品です。右クリックで1個消費し、視線方向へ約45mまで飛びます。再使用は1秒。16個までスタック。壁・床・相手の当たり箱に触れると爆発し、半径3.5m内の敵へ3HP（防具等で軽減）と強い水平の押し出しを与えます。味方は対象外。使用者自身は爆風ダメージを受けず、近くで爆発したときに上向き加速を受けます。落下ダメージは通常どおりです。
飛翔・爆発は表示エンティティと細分化した衝突検査を使う専用処理で、バニラのfireball実体ではありません。炎上・地形破壊はありません。押し出しは壁を検査する短距離移動で、バニラ速度ノックバックではありません。自身の上昇は浮遊の短いパルスによる加速です。最大20個の飛翔体、寿命3秒で負荷を抑えます。実際の衝突・押し出し距離・上昇高さは実機未検証です。
入手：`/function oa:give/furoball`、管理ブック、または `/trigger oa.admin set 37`。開始保護・ガチャ保護・デコイ中など使用不可時は通常モードで消費した分を返します。
''';w(x,s)
x=p/'LOOT_JA.md';s=x.read_text();s+='\nふろボールは通常チェストの独立枠で前半10%、後半15%、当選時1個。固有装備のレア枠には入れず、ほかのアイテムの確率は維持します。\n';w(x,s)
x=p/'README_JA.md';s=x.read_text();s+='''
## ロビー案内ブック
ロビーにいる参加者へ「OA ロビー案内」を自動配布します。空きスロットがない場合は配布を待ち、持ち物は上書きしません。右クリックで開き、参加・観戦・参加へ戻る・自分の統計・チーム選択を操作できます。ルールと固有装備9種、医療品・通常装備・ふろボールの紹介も掲載しています。試合中の通常プレイヤーによる途中参加・チーム変更は不可（管理者へ依頼）。観戦中は本を通常操作できないため、チャットの「参加者へ戻る」か `/trigger oa.lobby set 6` を使います。ゲーム開始時は他の持ち物と一緒に退避し、終了時に戻ります。
本体1.8.0ではキリングとゆうあの既存エンチャント定義を更新します。旧本体を交換し、サーバーを停止・起動して反映してください。専用リソースパックは完全版1.7.0のまま使用し、マップ再生成は不要です。新しい管理ブックは `/trigger oa.admin set 16` で取得します。
キリングの25%はtickごとに共有する判定です。通常攻撃の完全免疫は被弾通知がなく、無効化した瞬間の演出検知は未対応。ゆうあ反撃や専用スキルの無効化には派手な演出があります。詳細とふろボールの代替実装・未検証事項はWEAPONS_JA.mdを確認してください。
''';w(x,s)
# Keep primary bytecode inspection evidence as developer source, not another README.
w(p/'source/native_immunity180.txt','Official cached 26.3 server jar bytecode inspected offline, without launching server.\nLivingEntity.isInvulnerableTo calls EnchantmentHelper.isImmuneToDamage.\nServerPlayer.hurtServer and LivingEntity.hurtServer query invulnerability before actuallyHurt, which queries again. Immunity returns before ENTITY_HURT_PLAYER.\nA per-tick guard avoids compounding independent random queries and cannot observe a native fully immune hit for exact FX.\n')
shutil.copy('/tmp/finish180.py',p/'source/finish180.py')
print('180 docs and integration finished')
