from pathlib import Path
import json,re,copy,shutil
P=Path('revision/pack');F=P/'data/oa/function'
def w(n,s):
 p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n')
def add(n,s):
 p=F/(n+'.mcfunction');p.write_text(p.read_text()+'\n'+s+'\n')
def j(path,d):
 p=P/'data/oa'/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
profiles=json.loads(Path('release_1_9_1/profiles.json').read_text());assert all('properties' in d for d in profiles.values())
build=F/'lobby/build.mcfunction';src=build.read_text();a=src.index('fill ~-34 ~0 ~-20');b=src.index('\n',src.index('MCID未登録・後から更新可能',src.index('"oa:hotchikisu"')))
legacy=src[a:b];old={}
for line in legacy.splitlines():
 if line.startswith('summon minecraft:mannequin'):
  data=json.loads(line[line.index('{'):]);tag=next(t for t in data['Tags'] if t.startswith('oa.exhibit_'));old[tag.removeprefix('oa.exhibit_')]=data
# All pedestal coordinates are relative to the registered lobby origin.
items=[
 (1,'pichipichi','ぴちぴち：冷凍さかな','pichipichi_256',-32,-18,'oa:pichipichi','凍った魚を振り回す、俊足の武器。'),
 (2,'yuua','ゆうあ：ピンク帯の麦わら帽子','yuuaHP',-32,-6,'oa:yuua','ピンクの帯を巻いた、財閥の麦わら帽子。'),
 (3,'yuttari','ゆったり：瞬間奇襲アイテム','HitoriYuu',-32,6,'oa:yuttari','一瞬で背後へ飛び込む、奇襲用アイテム。'),
 (4,'killing','キリング：呪いの「き」マスク','F_KiRiSaN_1110',-32,18,'oa:killing','白い「き」の文字が刻まれた呪いのお面。'),
 (5,'raji','lazi：防音マイク付きマスク','lazi_3253',32,-18,'oa:raji','防音なのに大音量を放つマイク付きマスク。'),
 (6,'komame','こまめ：小豆バー','komame_azuki',32,-6,'oa:komame','硬くて冷たい、小豆のアイスバー。'),
 (7,'nero','ネロノワール：ペスト医師の杖','NeroNoir9696',32,6,'oa:nero','ペスト医師が所持している木の杖。'),
 (8,'yu','ゆー | オーバーワーク','Y_0402',-12,-32,'oa:yu','命の代わりに消費する、タバコのパッケージ。'),
 (9,'hotchikisu','ほちきす：ホッチキス','hochikisu_',12,-32,'oa:hotchikisu','相手を釘付けにするホッチキス。'),
 (10,'tayayuyu','たやゆゆ：変態ガチャ','tayayuyu2003',32,18,'oa:tayayuyu','緑色の県の形をした、気まぐれなガチャ武器。'),
 (11,'furoball','ふろボール','frosch_y',0,-32,'minecraft:fire_charge','爆風で敵を弾き、自分も跳ね上がる火の玉。')]
def rel(v):return '~'+(str(v) if v else '')
def compact(d):return json.dumps(d,ensure_ascii=False,separators=(',',':'))
lines=['# Registered lobby gallery. Replaces only owned exhibits, labels, and pedestal buttons.','kill @e[tag=oa.gallery]']
for id,key,title,mcid,x,z,model,desc in items:
 # Clean up old seven mannequins and old two item displays at their exact owned positions.
 lines += [f'kill @e[tag=oa.exhibit_{key}]',f'execute positioned {rel(x)} ~4 {rel(z)} run kill @e[type=minecraft:text_display,tag=oa.lobby_label,distance=..0.2]']
 if key in ['yu','hotchikisu']:lines += [f'execute positioned {rel(x)} ~2 {rel(z)} run kill @e[type=minecraft:item_display,tag=oa.lobby_exhibit,distance=..0.2]']
 lines += [f'fill {rel(x-2)} ~0 {rel(z-2)} {rel(x+2)} ~0 {rel(z+2)} minecraft:chiseled_quartz_block',f'setblock {rel(x)} ~0 {rel(z)} minecraft:sea_lantern']
 if key in old:data=copy.deepcopy(old[key])
 else:
  data={'profile':{'properties':profiles[mcid]['properties']},'pose':'crouching' if key=='tayayuyu' else 'standing','immovable':True,'hide_description':True,'Invulnerable':True,'NoGravity':True,'Silent':True,'PersistenceRequired':True,'Rotation':[0.0 if z==-32 else 90.0,0.0]}
 data['Tags']=['oa.lobby_exhibit','oa.gallery','oa.exhibit_'+key]
 lines += [f'summon minecraft:mannequin {rel(x+.5)} ~1 {rel(z+.5)} '+compact(data)]
 base='minecraft:totem_of_undying' if key=='yu' else 'minecraft:fire_charge' if key=='furoball' else 'minecraft:carrot_on_a_stick'
 lines += [f'item replace entity @e[type=minecraft:mannequin,tag=oa.exhibit_{key},limit=1] weapon.mainhand with {base}[minecraft:item_model="{model}"]']
 label={'Tags':['oa.lobby_label','oa.gallery'],'text':{'text':title+'\n'+mcid,'color':'gold'},'billboard':'center','background':1073741824,'shadow':True,'line_width':260,'view_range':1.5}
 lines += [f'summon minecraft:text_display {rel(x)} ~4 {rel(z)} '+compact(label)]
 if z==-32:bx,bz,ix,iz,facing=x,z+3,x+.5,z+3.12,'south'
 elif x<0:bx,bz,ix,iz,facing=x+3,z,x+3.12,z+.5,'east'
 else:bx,bz,ix,iz,facing=x-3,z,x-2.12,z+.5,'west'
 lines += [f'setblock {rel(bx)} ~0 {rel(bz)} minecraft:stone_button[face=wall,facing={facing},powered=false]',
 f'summon minecraft:interaction {rel(ix)} ~0.15 {rel(iz)} '+compact({'Tags':['oa.gallery','oa.gallery_button',f'oa.gallery_{id}','oa.gallery_new'],'width':0.9,'height':0.75,'response':True}),
 f'scoreboard players set @e[type=minecraft:interaction,tag=oa.gallery_new] oa.gallery_id {id}',
 'scoreboard players set @e[type=minecraft:interaction,tag=oa.gallery_new] oa.exbtn 0',
 'tag @e[tag=oa.gallery_new] remove oa.gallery_new']
 hint={'Tags':['oa.lobby_label','oa.gallery'],'text':{'text':'詳細ボタン［右クリック］','color':'aqua'},'billboard':'center','background':0,'shadow':True,'line_width':160,'view_range':0.7}
 lines += [f'summon minecraft:text_display {rel(ix)} ~1.3 {rel(iz)} '+compact(hint)]
lines += ['# Move the old central item sign clear of the new fireball stand.','execute positioned ~0 ~3 ~-28 as @e[type=minecraft:text_display,tag=oa.lobby_label,distance=..0.2] run tp @s ~ ~ ~3','function oa:lobby/protect_exhibits']
w('lobby/gallery/build','\n'.join(lines))
build.write_text(src[:a]+'function oa:lobby/gallery/build'+src[b:])
# Automatic, versioned refresh waits for all eleven exhibit chunks. Never rebuild the lobby or BR map.
ensure=['execute unless score #state br.state matches 0 run return 0']
for _,_,_,_,x,z,_,_ in items:ensure += [f'$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded {rel(x)} ~0 {rel(z)} run return 0']
ensure += ['$execute in minecraft:overworld positioned $(x) $(y) $(z) run function oa:lobby/gallery/build','data modify storage oa:lobby origin.gallery set value 191']
w('lobby/gallery/ensure','\n'.join(ensure))
w('lobby/gallery/update','''execute unless entity @s[tag=br.admin] run return 0
execute unless score #state br.state matches 0 run return run tellraw @s {text:"展示更新は試合待機中に行ってください。",color:"yellow"}
execute unless data storage oa:lobby origin{ready:1b} run return run tellraw @s {text:"先にロビーを登録してください。",color:"yellow"}
data remove storage oa:lobby origin.gallery
function oa:lobby/gallery/ensure with storage oa:lobby origin
tellraw @s {text:"展示更新を受け付けました。ロビーが読み込まれると反映します。",color:"aqua"}''')
add('lobby/tick','''execute if score #clock oa.beat matches 0 unless data storage oa:lobby origin{gallery:191} run function oa:lobby/gallery/ensure with storage oa:lobby origin
execute as @e[type=minecraft:interaction,tag=oa.gallery_button] at @s run function oa:lobby/gallery/button_tick
scoreboard players remove @a[scores={oa.exread=1..}] oa.exread 1''')
add('load','scoreboard objectives add oa.gallery_id dummy\nscoreboard objectives add oa.exbtn dummy\nscoreboard objectives add oa.exread dummy')
p=F/'lobby/save_origin.mcfunction';p.write_text(p.read_text().replace('{ready:1b}','{ready:1b,gallery:191}'))
# Interaction entities make empty-hand and Adventure-mode right clicks work. Vanilla advancements identify the exact clicking player.
for id,key,*_ in items:
 j(f'advancement/lobby/gallery/{id}.json',{'criteria':{'read':{'trigger':'minecraft:player_interacted_with_entity','conditions':{'entity':{'type':'minecraft:entity_properties','entity':'this','predicate':{'minecraft:nbt':'{Tags:["oa.gallery_button","oa.gallery_'+str(id)+'"]}'}}}}},'rewards':{'function':f'oa:lobby/gallery/click/{id}'}})
 w(f'lobby/gallery/click/{id}',f'''advancement revoke @s only oa:lobby/gallery/{id}
execute unless entity @s[type=minecraft:player] run return 0
execute if score @s oa.exread matches 1.. run return 0
scoreboard players set @s oa.exread 4
function oa:lobby/gallery/info/{id}
playsound minecraft:block.note_block.chime player @s ~ ~ ~ 0.65 1.4''')
# Visible button depression is cosmetic and never decides which player receives information.
w('lobby/gallery/button_tick','''execute if data entity @s interaction run function oa:lobby/gallery/button_press
scoreboard players remove @s[scores={oa.exbtn=1..}] oa.exbtn 1
execute if score @s oa.exbtn matches 0 run function oa:lobby/gallery/button_release''')
for state,name in [('true','button_press'),('false','button_release')]:
 ls=[]
 if state=='true':ls=['data remove entity @s interaction','scoreboard players set @s oa.exbtn 12']
 else:ls=['scoreboard players set @s oa.exbtn -1']
 for id,key,title,mcid,x,z,model,desc in items:
  face='south' if z==-32 else 'east' if x<0 else 'west'
  ls += [f'execute if score @s oa.gallery_id matches {id} run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing={face},powered={state}]']
 w('lobby/gallery/'+name,'\n'.join(ls))
# Detailed text describes CURRENT implemented behavior, not superseded requests. HP values are pre-mitigation.
info={
 1:[('分類','固有武器／メインハンド'),('通常攻撃','4HP。命中した相手を5秒間、自動で跳ねさせる。'),('常時効果','移動速度＋170%（標準の2.7倍）、跳躍属性＋0.6、落下ダメージ無効。ノックバック強化。'),('スキル・CT','右クリックで発動するスキルなし。ジャンプは自分で操作。'),('攻撃速度','1.8回／秒。')],
 2:[('分類','固有の頭装備／拾うと強制装着'),('攻撃・反撃','装着者が攻撃した敵、装着者を攻撃した敵へ即死攻撃。専用ダメージは10000HP。'),('持続・CT','累計30秒で壊れる使い捨て。発動スキル・CTなし。'),('演出','装着中は発光し、壁越しでも見える。ピンクの粒子が出る。'),('注意','キリングの無効化などの防御判定を受ける。実際のBANは行わない。')],
 3:[('分類','固有武器／メインハンド'),('通常攻撃','6HP。攻撃速度1.8回／秒。'),('右クリック','ランダムな敵の背後へ転移。相手に0.5HPと強い押し出し。1秒後、元いた場所へ戻る。'),('追加効果','両者に発光3秒。片方に速度I、もう片方に鈍足Iを5秒。'),('CT','10秒。対象がいない・安全に転移できない場合は不発。')],
 4:[('分類','固有の頭装備／強制装着'),('通常攻撃','持っている通常武器に依存。お面からの追加攻撃なし。'),('常時効果','移動速度＋200%（標準の3倍）。盲目・本人だけに大音量。最寄りプレイヤーの距離と方向を表示。'),('防御','参加プレイヤー由来の攻撃を25%で無効化。ゆうあの即死も対象。エリア外ダメージは対象外。'),('持続・CT','累計60秒で壊れる。通常は取り外し不可。発動スキル・CTなし。')],
 5:[('分類','固有の頭装備／右クリックで装着'),('通常攻撃','持っている通常武器に依存。'),('音波スキル','周囲4mの敵に6HP。2秒ごとに自動発射を判定。右クリックでも発動可能。共有CT4秒。'),('常時効果','最大HP＋6。周囲32mへ大音量サウンド。'),('息切れ','通常時は2秒ごとに20%で発生。5秒間鈍足IIIになり、音波攻撃できない。息切れ中は再抽選なし。')],
 6:[('分類','固有武器／メインハンド'),('通常攻撃','5HP。鈍足Iを2秒付与。攻撃速度1.8回／秒。'),('右クリック','10秒間、体の大きさが半分に。耐性I・体力増強I・速度Iを付与。'),('追加効果','増えた最大HP分を即時回復。大きめの音と冷気・花火の粒子。'),('CT','20秒。')],
 7:[('分類','固有武器／メインハンド'),('通常攻撃','6HP。攻撃速度1.8回／秒。'),('右クリック','印を視線方向へ飛ばし、再使用で印へ帰還。毎tick0.3m、最大48m。上向きは水平に補正。印は20秒、安置外への帰還不可。'),('しゃがみ右クリック','本人デコイを8秒。自分は攻撃できず、被弾を防ぐ。被弾時または終了時に発動地点へ戻る。'),('デコイ反撃','攻撃者に盲目・弱体化3秒、発光5秒。'),('夜間強化','移動速度・攻撃力・防御力＋20%。'),('CT','印帰還とデコイで共有10秒。')],
 8:[('分類','消耗品／固有装備の1個制限に含まない'),('発動','メインハンドかオフハンドに持っていると、致死ダメージ時にトーテムとして1個消費。'),('初期効果','バニラのトーテム効果に加え、吸収II・体力増強IIを5秒。毒I・吐き気Iを10秒。'),('演出と反動','10秒間の派手な演出。その後、吐き気III・鈍足IIを15秒。'),('CT・所持','固有CTなし。スタック不可。別スロットで複数所持可。'),('現在の制約','インベントリに入れているだけの自動発動は未対応。')],
 9:[('分類','固有武器／メインハンド'),('通常攻撃','4HP＋2秒間の出血。出血は毎秒0.5HP、合計1HP。攻撃速度1.8回／秒。'),('右クリック','水平約3m・上下最大約4mの敵を2.5秒、その場に拘束。範囲と拘束対象に立体的な粒子。'),('探知','他人のぴちぴちジャンプ／lazi息切れに反応し、5秒発光。チャット通知は25%の確率。'),('CT','15秒。拘束しても視点変更・攻撃は可能。')],
 10:[('分類','固有武器／メインハンド'),('通常攻撃','5HP。10%で相手を約5m打ち上げる。攻撃速度1.8回／秒。'),('右クリック','16種類から等確率でガチャ。全体効果は原則、生存参加者全員（本人・味方も含む）が対象。'),('CT','45秒。各結果の確率は6.25%。'),('全結果','下のリンクで、16種類の結果・数値・時間を確認。')],
 11:[('分類','投てき消耗品／固有装備の1個制限に含まない'),('右クリック','火の玉を投げる。壁・床・敵に当たると爆発。射程目安45m。'),('爆発','半径3.5mの敵に3HP＋強い水平押し出し。味方は対象外。地形破壊・炎上なし。'),('自分への爆風','自分にはダメージなし。一度の初速で約10m跳ね上がり、次の着地まで落下ダメージ無効。'),('CT・消費','再使用1秒。1回1個消費。16個までスタック。'),('注意','上昇量は計算上の目安。天井等で変化し、Shiftで途中降車可能。')]
}
for id,key,title,mcid,x,z,model,desc in items:
 comps=[{'text':'\n━━ '+title+' ━━\n','color':'gold','bold':True},{'text':'モチーフ：'+mcid+'\n','color':'aqua'},{'text':desc+'\n','color':'white'}]
 for label,body in info[id]:comps += [{'text':label+'：','color':'yellow'},{'text':body+'\n','color':'white'}]
 comps += [{'text':'※ 1ハート＝2HP。ダメージは防具・耐性等による軽減前の基準値。\n','color':'gray'}]
 if id==10:comps += [{'text':'［ガチャ全16結果を見る］','color':'green','underlined':True,'click_event':{'action':'run_command','command':'/trigger oa.gallery set 10'}}]
 w(f'lobby/gallery/info/{id}','tellraw @s '+compact(comps))
# The optional detail link is public/read-only, never a management command.
add('load','scoreboard objectives add oa.gallery trigger')
add('public/tick','''execute as @a[scores={oa.gallery=10}] run function oa:lobby/gallery/gacha_results
scoreboard players set @a oa.gallery 0
scoreboard players enable @a oa.gallery''')
results=[]
for line in (P/'WEAPONS_JA.md').read_text().splitlines():
 if line.startswith('| ') and not line.startswith('| 結果') and '##' not in line:
  cells=[s.strip() for s in line.strip('|').split('|')]
  if len(cells)==2 and cells[0] in ['体力','炎','速度','復活','跳ね','帽子','TNT','全員ちび化','席替えタイム','強制集合','平和な世界','全員キリング気分','丸見え大会','空腹の時間','全員巨大化','大ハズレ：自己紹介']:results.append(cells)
assert len(results)==16
w('lobby/gallery/gacha_results','tellraw @s '+compact([{'text':'━━ 変態ガチャ：全16結果（各6.25%／CT45秒） ━━\n','color':'gold','bold':True}]+sum(([{'text':n+'：','color':'yellow'},{'text':d+'\n','color':'white'}] for n,d in results),[])))
# Add a small maintenance action to the existing admin book, not another book.
add('admin/dispatch','execute if score @s oa.admin matches 46 run function oa:lobby/gallery/update')
p=F/'admin/book.mcfunction';s=p.read_text();i=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',i);d=json.loads(s[i:e]);parts=d['pages'][1]['raw']['extra'];parts.insert(-1,{'text':'ロビー展示だけ更新\n','color':'dark_blue','underlined':True,'click_event':{'action':'run_command','command':'/trigger oa.admin set 46'}});p.write_text(s[:i]+compact(d)+s[e:])
for p in P.rglob('*'):
 if p.suffix in ['.mcfunction','.mcmeta','.md']:
  s=p.read_text();t=s.replace('1.9.0','1.9.1')
  if s!=t:p.write_text(t)
p=P/'README_JA.md';s=p.read_text();s+='''

## ロビーの台座と詳細ボタン
全11展示（固有装備9種＋ゆー＋ふろボール）の台座正面にあるボタンを右クリックすると、その本人だけのチャットに、モチーフMCID・見た目の説明・通常攻撃・スキル・ダメージ・CTを表示します。たやゆゆはチャットのリンクから全16結果も確認できます。空手・アドベンチャーモードでも操作できるよう、ボタン位置に透明な操作判定を重ねています。表示先は右クリックしたプレイヤー本人で、近くに立っている別の人を選ぶ方式ではありません。

ゆーはY_0402、ほちきすはhochikisu_、たやゆゆはtayayuyu2003、ふろボールはfrosch_yのスキンを展示に使用しています。新規ロビーには自動配置。既存ロビーは試合待機中に展示のチャンクが読み込まれると、所有する展示物・台座・ボタンだけを自動更新します。ロビー全体・BRマップは再生成しません。手動で再更新したい場合は管理ブック「準備・中心座標」の「ロビー展示だけ更新」、または `/function oa:lobby/gallery/update` を実行してください。

チャット内のダメージ値は軽減前の基準です。ゆーの説明は現在の実装に合わせ、手持ち時の発動とインベントリ自動発動未対応を明記しています。武器の能力・出現率そのものはこの展示更新で変更しません。リソパ更新不要。表示・クリック動作の実機検証は未実施です。
''';p.write_text(s)
shutil.copyfile('release_1_9_1/build191.py',P/'source/build191.py')
shutil.copyfile('release_1_9_1/profiles.json',P/'source/gallery_profiles191.json')
