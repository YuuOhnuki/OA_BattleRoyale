from pathlib import Path
import json,shutil
p=Path('revision/pack');f=p/'data/oa/function';b=f/'admin/control'
def w(x,s):x.parent.mkdir(parents=True,exist_ok=True);x.write_text(s)
def add(x,s):w(x,x.read_text()+'\n'+s+'\n')
# Height is non-linear in the levitation pulse level; 31 models ~2.41m rather than 9.84m.
x=f/'furoball/up.mcfunction';w(x,x.read_text().replace('~9.84m','~2.41m').replace('levitation 1 72','levitation 1 31'))
x=f/'furoball/stop_lift.mcfunction';s=x.read_text();w(x,'execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:31}] run effect clear @s minecraft:levitation\n'+s)
for x in (p/'data/oa/loot_table').rglob('*.json'):
 s=x.read_text();t=s.replace('約10m上昇','約2.5m上昇')
 if s!=t:w(x,t)
x=p/'data/oa/item_modifier/furo_lore181.json';s=x.read_text().replace('約10m','約2.5m').replace('furo_lore181','furo_lore182');w(p/'data/oa/item_modifier/furo_lore182.json',s)
x=f/'normal/visual_tick.mcfunction';w(x,x.read_text().replace('furo_lore181','furo_lore182'))
x=f/'lobby/guide/book.mcfunction';w(x,x.read_text().replace('約10m','約2.5m').replace('guide_v181','guide_v182'))
# Extend the existing online-player list without breaking old join/watch links.
x=f/'admin/players/row_prepare.mcfunction';s=x.read_text();idx=s.index('function oa:admin/players/row');pre='scoreboard players operation #control_code oa.tmp = @s oa.id\nscoreboard players set #control_ten oa.tmp 10\nscoreboard players operation #control_code oa.tmp *= #control_ten oa.tmp\n'
for index,name in enumerate(['survival','adventure','creative','spectator','revive']):
 if index:pre+='scoreboard players add #control_code oa.tmp 1\n'
 pre+=f'execute store result storage oa:roster {name} int 1 run scoreboard players get #control_code oa.tmp\n'
w(x,s[:idx]+pre+s[idx:])
x=f/'admin/players/row.mcfunction';s=x.read_text().rstrip();assert s.endswith(']');s=s[:-1]
for name,label,color in [('revive','復活','gold'),('survival','サバイバル','green'),('adventure','アドベンチャー','aqua'),('creative','クリエイティブ','light_purple'),('spectator','スペクテイター','gray')]:
 s+=',{"text":" ['+label+']","color":"'+color+'","click_event":{"action":"run_command","command":"/trigger oa.control set $('+name+')"}}'
w(x,s+']\n')
w(b/'self_menu.mcfunction','''execute unless entity @s[tag=br.admin] run return 0
tag @a remove oa.roster_viewer
tag @s add oa.roster_viewer
function oa:admin/players/row_prepare
tag @s remove oa.roster_viewer
''')
w(b/'actor.mcfunction','''execute unless score @s oa.id matches 1.. run function oa:internal/id
scoreboard players operation #control_actor oa.tmp = @s oa.id
''')
w(b/'dispatch.mcfunction','''execute unless entity @s[tag=br.admin] run return 0
function oa:admin/control/actor
scoreboard players operation #control_target oa.tmp = @s oa.control
scoreboard players set #control_ten oa.tmp 10
scoreboard players operation #control_action oa.tmp = #control_target oa.tmp
scoreboard players operation #control_action oa.tmp %= #control_ten oa.tmp
scoreboard players add #control_action oa.tmp 1
scoreboard players operation #control_target oa.tmp /= #control_ten oa.tmp
execute unless score #control_action oa.tmp matches 1..5 run return 0
scoreboard players set #control_found oa.tmp 0
execute as @a if score @s oa.id = #control_target oa.tmp at @s run function oa:admin/control/queue
execute if score #control_found oa.tmp matches 0 run tellraw @s {text:"対象が退出しています。一覧を開き直してください。",color:"yellow"}
''')
w(b/'self_revive.mcfunction','''execute unless entity @s[tag=br.admin] run return 0
function oa:admin/control/actor
scoreboard players set #control_action oa.tmp 5
function oa:admin/control/queue
''')
w(b/'queue.mcfunction','''scoreboard players set #control_found oa.tmp 1
execute unless score @s oa.id matches 1.. run function oa:internal/id
scoreboard players add @s oa.left 0
scoreboard players operation @s oa.pending = #control_action oa.tmp
scoreboard players operation @s oa.qby = #control_actor oa.tmp
scoreboard players operation @s oa.qleft = @s oa.left
execute if entity @s[nbt={Health:0.0f}] run tellraw @s {text:"管理操作を予約しました。リスポーン後に自動実行します。",color:"gold"}
function oa:admin/control/process
''')
w(b/'process.mcfunction','''execute unless score @s oa.pending matches 1..5 run return 0
execute unless score @s oa.left = @s oa.qleft run return run scoreboard players set @s oa.pending 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute if score #state br.state matches 2 run return 0
execute if score #state br.state matches 0 if score @s br.saved matches 1 run return 0
scoreboard players operation #control_do oa.tmp = @s oa.pending
scoreboard players set @s oa.pending 0
tag @a remove oa.roster_actor
scoreboard players operation #control_by oa.tmp = @s oa.qby
execute as @a if score @s oa.id = #control_by oa.tmp run tag @s add oa.roster_actor
execute if score #control_do oa.tmp matches 1 run function oa:admin/control/survival
execute if score #control_do oa.tmp matches 2 run function oa:admin/control/adventure
execute if score #control_do oa.tmp matches 3 run function oa:admin/control/creative
execute if score #control_do oa.tmp matches 4 run function oa:admin/control/spectator
execute if score #control_do oa.tmp matches 5 run function oa:admin/control/revive
tag @a remove oa.roster_actor
''')
for name in ['survival','adventure','creative','spectator']:
 s=''
 if name in ['creative','spectator']:s+='execute if score #state br.state matches 1 if entity @s[tag=br.alive] run function oa:br/surrender\n'
 s+='tag @s add br.gm_override\n'
 if name=='spectator':s+='execute if score #state br.state matches 0 run tag @s remove br.lobby\nexecute unless entity @s[tag=br.playing] run tag @s add br.watch\n'
 else:s+='execute if entity @s[tag=br.watch] run team leave @s\ntag @s remove br.watch\n'
 s+=f'gamemode {name} @s\n'
 s+='tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:"：'+name+' に変更しました。",color:"green"}]\n'
 w(b/(name+'.mcfunction'),s)
w(b/'revive.mcfunction','''execute if entity @s[tag=br.alive] run return run tellraw @a[tag=oa.roster_actor] {text:"対象はすでに生存参加中です。",color:"yellow"}
execute if score #state br.state matches 1 run return run function oa:admin/players/join
# Once victory is decided, return the physical player to the lobby without reopening the result.
tag @s add br.gm_override
tag @s remove br.watch
gamemode adventure @s
effect give @s minecraft:instant_health 1 10 true
execute if score #state br.state matches 0 run function oa:lobby/return
execute if score #state br.state matches 3 if data storage oa:lobby origin{ready:1b} run function oa:lobby/center with storage oa:lobby origin
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を待機状態へ戻しました。",color:"green"}]
''')
# OP function command with named target and a fixed action allowlist.
w(f/'manage.mcfunction','''execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"先にOPで /function oa:admin を実行してください。",color:"red"}
function oa:admin/control/actor
$data modify storage oa:manage request set value {action:"$(action)"}
scoreboard players set #control_action oa.tmp 0
execute if data storage oa:manage request{action:"survival"} run scoreboard players set #control_action oa.tmp 1
execute if data storage oa:manage request{action:"adventure"} run scoreboard players set #control_action oa.tmp 2
execute if data storage oa:manage request{action:"creative"} run scoreboard players set #control_action oa.tmp 3
execute if data storage oa:manage request{action:"spectator"} run scoreboard players set #control_action oa.tmp 4
execute if data storage oa:manage request{action:"revive"} run scoreboard players set #control_action oa.tmp 5
execute if score #control_action oa.tmp matches 0 run return run tellraw @s {text:"action は survival / adventure / creative / spectator / revive を指定してください。",color:"yellow"}
scoreboard players set #control_found oa.tmp 0
$execute as @a[name="$(player)"] at @s run function oa:admin/control/queue
execute if score #control_found oa.tmp matches 0 run tellraw @s {text:"対象のオンラインプレイヤーが見つかりません。",color:"yellow"}
''')
for obj,typ in [('oa.control','trigger'),('oa.pending','dummy'),('oa.qby','dummy'),('oa.qleft','dummy')]:add(f/'load.mcfunction',f'scoreboard objectives add {obj} {typ}')
add(f/'public/tick.mcfunction','''execute as @a[scores={oa.control=1..}] at @s run function oa:admin/control/dispatch
scoreboard players set @a oa.control 0
scoreboard players enable @a[tag=br.admin] oa.control
execute as @a[scores={oa.pending=1..5}] at @s run function oa:admin/control/process''')
add(f/'admin/dispatch.mcfunction','execute if score @s oa.admin matches 38 run function oa:admin/control/self_menu\nexecute if score @s oa.admin matches 39 run function oa:admin/control/self_revive')
# Do not immediately undo the administrator's intentional mode choice for eliminated players.
x=f/'br/tick.mcfunction';s=x.read_text().replace('@a[tag=br.playing,tag=!br.alive,gamemode=!spectator]','@a[tag=br.playing,tag=!br.alive,tag=!br.gm_override,gamemode=!spectator]');w(x,s)
for name in ['br/enter','br/eliminate','br/restore']:x=f/(name+'.mcfunction');w(x,'tag @s remove br.gm_override\n'+x.read_text())
x=f/'tayayuyu/revive_all.mcfunction';w(x,x.read_text().replace('tag=!br.alive,','tag=!br.alive,tag=!br.gm_override,'))
# A new administrative guide page; old books can be reissued.
x=f/'admin/book.mcfunction';s=x.read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',a);d=json.loads(s[a:e]);d['pages'].insert(1,{'raw':{'text':'GM・復活\n\n','color':'black','extra':[{'text':'参加者を選ぶ\n\n','color':'dark_blue','underlined':True,'click_event':{'action':'run_command','command':'/trigger oa.admin set 35'}},{'text':'自分のGMを変更\n\n','color':'dark_blue','underlined':True,'click_event':{'action':'run_command','command':'/trigger oa.admin set 38'}},{'text':'自分を復活\n\n','color':'dark_green','underlined':True,'click_event':{'action':'run_command','command':'/trigger oa.admin set 39'}},{'text':'C・観戦は生存枠から外れます。生存復帰は「復活」。','color':'dark_gray'}]}});s=s[:a]+json.dumps(d,ensure_ascii=False,separators=(',',':'))+s[e:];w(x,s.replace('book_v180','book_v182'))
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.8.1','1.8.2')
  if x.suffix=='.md':t=t.replace('約10m','約2.5m').replace('約10ブロック','約2.5ブロック').replace('約10m','約2.5m')
  if t!=s:w(x,t)
x=p/'README_JA.md';add(x,'''## 管理ブックでGM変更・復活
管理ブックの「GM・復活」から自分、または参加者一覧から対象を選びます。4種類のゲームモードと「復活」をクリックで操作できます。自分の操作一覧は `/trigger oa.admin set 38`、自分の復活は `/trigger oa.admin set 39`、全員の一覧は `/trigger oa.admin set 35`。登録済み管理者のみ操作できます。新しい本は `/trigger oa.admin set 16`。
ゲーム内の管理コマンドは `/function oa:manage {player:"MCID",action:"creative"}`。action は survival / adventure / creative / spectator / revive の5種類。復活の例は `/function oa:manage {player:"HitoriYuu",action:"revive"}`。バニラでは新しい独自スラッシュコマンド名を追加できないため、functionコマンド1行にまとめています。
試合中の「復活」は現在の安置内へ初期装備で復帰します。事前の所持品バックアップは上書きしません。人数・チーム・安全位置の既存条件に従います。モード切替だけでは脱落者を生存者数へ戻しません。試合中の生存者をcreative/spectatorへ変えると、所持品を落として脱落扱いになります。管理者のGM選択は自動観戦処理で戻されず、復活・次の試合・所持品復元時に解除します。
死亡画面でHealthが0の間は操作を予約し、実際のリスポーン後に自動実行します（試合中は既存の即時リスポーン設定を使用）。バニラの管理コマンドだけでクライアントの死亡画面を直接操作することはできません。対象が退出した場合は予約を取り消します。終了演出中の「復活」はロビーへ戻すだけで、確定した勝敗は再開しません。
''')
shutil.copy('release_1_8_2/build182.py',p/'source/build182.py')
print('182 ascent and admin controls written')
