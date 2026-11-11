from pathlib import Path
import json,shutil,re
p=Path('revision/pack');f=p/'data/oa/function';b=f/'tayayuyu';r=Path('release_1_7_0/resourcepack')
def w(p,s):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s)
def add(p,s):w(p,p.read_text()+'\n'+s+'\n')
for name,path in json.loads(Path('release_1_7_0/asset_paths.json').read_text()).items():shutil.copyfile(path,r/f'assets/oa/textures/item/{name}.png')
# Efficient effect ticking and exact 2 simulation-frame levitation impulse (~5 blocks, unverified).
for name in ['health','speed','fire','hit']:add(b/(name+'.mcfunction'),'tag @s add oa.gacha_affected')
x=b/'hit.mcfunction';w(x,x.read_text().replace('oa.glift 2','oa.glift 3'))
add(b/'clear.mcfunction','tag @s remove oa.gacha_affected')
add(b/'tick.mcfunction','''execute if score @s oa.ghp matches 1.. run return 0
execute if score @s oa.gspeed matches 1.. run return 0
execute if score @s oa.gfire matches 1.. run return 0
execute if score @s oa.glift matches 1.. run return 0
function oa:tayayuyu/clear''')
x=f/'tick.mcfunction';w(x,x.read_text().replace('as @a[tag=oa.player] at @s run function oa:tayayuyu/tick','as @a[tag=oa.gacha_affected] at @s run function oa:tayayuyu/tick'))
x=b/'bomb_spawn.mcfunction';s=x.read_text().replace('tag @e[tag=oa.gacha_bomb_new] remove','scoreboard players operation @e[tag=oa.gacha_bomb_new] br.round = #round br.round\ntag @e[tag=oa.gacha_bomb_new] remove');w(x,s)
x=b/'bomb_tick.mcfunction';w(x,'execute unless score @s br.round = #round br.round run return run kill @s\n'+x.read_text())
# Delayed chunk loads cannot bring back hats invalidated by a gacha replacement.
x=b/'hat_all.mcfunction';s=x.read_text();s=s.replace('clear @a *[','scoreboard players operation #hat_cut oa.serial = #serial oa.serial\nexecute as @a if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run function oa:internal/cleanup\nclear @a *[',1);w(x,s)
w(b/'prune_ground_hat.mcfunction','''execute store result score #hat_serial oa.tmp run data get entity @s Item.components."minecraft:custom_data".oa.serial
execute if score #hat_serial oa.tmp <= #hat_cut oa.serial run kill @s
''')
add(f/'world_tick.mcfunction','execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:1}}}}}] run function oa:tayayuyu/prune_ground_hat')
# Remove timed effects at match finish and remove pending visible explosives.
add(f/'br/finish.mcfunction','''execute as @a[tag=oa.gacha_affected] run function oa:tayayuyu/clear
execute in minecraft:overworld run kill @e[type=minecraft:block_display,tag=oa.gacha_bomb]
execute in minecraft:the_nether run kill @e[type=minecraft:block_display,tag=oa.gacha_bomb]
execute in minecraft:the_end run kill @e[type=minecraft:block_display,tag=oa.gacha_bomb]''')
# A retired hat in an offline player's inventory is removed on the normal inventory scan.
w(b/'prune_slot.mcfunction','''summon minecraft:item_display ~ ~ ~ {Tags:["oa.hat_reader"]}
$item replace entity @e[type=minecraft:item_display,tag=oa.hat_reader,limit=1] contents from entity @s $(slot)
execute store result score #hat_serial oa.tmp run data get entity @e[type=minecraft:item_display,tag=oa.hat_reader,limit=1] item.components."minecraft:custom_data".oa.serial
kill @e[type=minecraft:item_display,tag=oa.hat_reader]
$execute if score #hat_serial oa.tmp <= #hat_cut oa.serial run item replace entity @s $(slot) with minecraft:air
''')
x=f/'inventory/visual.mcfunction';add(x,'$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:1}}] if score #hat_cut oa.serial matches 1.. run function oa:tayayuyu/prune_slot {slot:"$(slot)"}')
# Existing held medical items upgrade; preserve counts. Generated assets are complete alpha textures.
for root in [p,r]:
 for x in root.rglob('*'):
  if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
   s=x.read_text();t=s.replace('1.6.5','1.7.0').replace('1.6.1','1.7.0');
   if t!=s:w(x,t)
x=p/'WEAPONS_JA.md';s=x.read_text().replace('3m内の敵を2.5秒拘束','水平約3m・上下最大約4mの敵を2.5秒拘束');s=s.replace('| こまめ：小豆バー', '| たやゆゆ | 右クリックで7種から等確率の全体ガチャ。通常攻撃は石の剣相当（5HP）、10%で約5m打ち上げ | CT45秒 |\n| こまめ：小豆バー',1)
s=s.replace('救急キット：2.5秒使って6HP相当を回復。通常の再生効果を使うため他の回復と相互作用します。','応急キット：2秒使って10HP回復（最大HPまで）。応急キットは通常の再生効果に依存しない回復処理です。')
s+='''
## たやゆゆ | 変態ガチャ
固有装備の1個制限に含みます。石の剣相当の攻撃力、攻撃速度1.8。スキルは試合中・保護終了後のみ。生存中の全参加者（本人・味方を含む）が対象で、各結果は1/7。対象不在でもCT45秒を消費します。

| 結果 | 効果 |
|---|---|
| 体力 | 最大HP＋20を15秒。付与時20HP回復、終了時は通常の最大HPへ戻る |
| 炎 | 8秒間、毎秒1HPの炎ダメージと炎の粒子。通常の耐性・火炎耐性等を適用 |
| 速度 | 移動速度属性＋50%を12秒。他の属性補正との組み合わせで実速度は変化 |
| 復活 | この試合で脱落したオンライン参加者全員を中央で復活。石の剣・採掘ツルハシ・キリングのお面。元の所持品バックアップを維持。観戦専用者・退出者・リスポーン未完了者は対象外 |
| 跳ね | ぴちぴち被弾時と同じ自動跳ねを20秒 |
| 帽子 | 既存のゆうあ帽子を削除し、生存者1人に新しい帽子を強制装着。別の固有装備や通常ヘルメットは足元へ返す。未読み込みの古い地面帽子は読み込み時、オフライン所持品は再参加後の検査時に削除 |
| TNT | 足元にTNTの表示を置き、2秒後に爆発演出。半径4m内へ最大6HP。同じガチャの複数爆発が重なっても1回分まで。地形破壊なし |

TNTは上限と地形保護を保証する専用処理で、バニラの着火TNT実体ではありません。火炎も実際のFire NBT変更ではなく、毎秒の炎ダメージで代替します。爆風の遮蔽・ノックバックは再現していません。防具・耐性等でダメージは軽減されます。ゆうあ等の既存特殊反撃は通常どおり適用され、追加反撃ダメージはTNT本体の上限とは別です。通常攻撃の打ち上げは短い浮遊パルスによる上向き加速で、約5mは目標値（天井・被弾状態で変化、実機未検証）。
入手：`/function oa:give/tayayuyu` または管理ブック／`/trigger oa.admin set 36`。スキル単体試験は保護が終わった試合内で実施してください。
''';w(x,s)
x=p/'LOOT_JA.md';s=x.read_text().replace('救急キット','応急キット').replace('・5秒','・10秒').replace('体力増強Iは最大体力を増やす効果で、増えた分を即時回復するものではありません。','体力増強Iは最大HP＋4と同時に4HP回復します（最大HPまで）。').replace('| 応急キット | 2% | 従来の回復 |','| 応急キット | 2% | 2秒使用で10HP回復 |')
s=s.replace('7.6923%','6.8966%').replace('0.4615%','0.4138%').replace('0.6923% |\n| ぴち','0.6207% |\n| ぴち').replace('11.5385%','10.3448%').replace('0.6923%','0.6207%').replace('1.0385%','0.9310%').replace('ほかの8種類','ほかの9種類')
s=s.replace('| こまめ | 10.3448% | 0.6207% | 0.9310% |','| こまめ | 10.3448% | 0.6207% | 0.9310% |\n| たやゆゆ | 10.3448% | 0.6207% | 0.9310% |')
s+='\n通常の鉱石報酬に加え、25%で石炭／深層石炭は満腹度2（肉アイコン1個分）と少量の隠し満腹度、レッドストーン／深層レッドストーンは2HPをその場で回復します。抽選はゆー2%と独立です。\n';w(x,s)
x=p/'README_JA.md';s=x.read_text();s+='''
## 医療品とガチャ
包帯と応急キットには専用の見た目があります。応急キットは2秒使用で10HP回復。鉱石のバフ医療品6種はすべて10秒で、小豆は体力増加と同時に4HP回復します。医療品は従来どおり消費・スタック可。既存品は手に持つと定義を更新します。採掘時の25%追加回復、ガチャ7種の詳細・仮設定はWEAPONS_JA.md／LOOT_JA.mdに記載しています。
たやゆゆは他の固有装備と同じ出現枠に追加しています。ガチャの復活はこの装備だけの例外で、通常の死亡は観戦へ移行します。管理ブックは `/trigger oa.admin set 16` で更新してください。
今回の変更はマップ再生成不要。データパックと完全版リソースパックの両方を交換してください。ゲーム内での表示・回復・7種のガチャ・復活と勝敗の組み合わせは実サーバー未検証です。
''';w(x,s)
x=r/'README_JA.md';w(x,'# OA BattleRoyale Resources 1.7.0\n\nresourcepacksへZIPのまま入れて有効にしてください。旧OAリソースパックは外し、この完全版のみを使用します。包帯・応急キット・たやゆゆの専用モデルを含みます。データパック1.7.0と組み合わせて使用してください。\n')
# Keep generation prompts with source assets, no extra readme.
prompts={'bandage':'Transparent pixel-art gauze roll, beige layers and red tab','firstaid':'Transparent pixel-art red first-aid case with ivory cross','tayayuyu':'Attached geographical silhouette, emerald-green faceted pixel-art talisman; no labels'}
w(p/'source/image_prompts170.json',json.dumps({'method':'built-in image_gen','prompts':prompts},ensure_ascii=False,indent=2))
shutil.copy('/tmp/finish170.py',p/'source/finish170.py')
print('Assets and docs updated')
