from pathlib import Path
import json,re,zipfile,shutil
p=Path('revision/pack');f=p/'data/oa/function';o=Path('release_1_6_3');o.mkdir(exist_ok=True)
def w(path,s):path.parent.mkdir(parents=True,exist_ok=True);path.write_text(s)
b=f/'admin/players'
w(b/'menu.mcfunction','''execute unless entity @s[tag=br.admin] run return 0
tag @a remove oa.roster_viewer
tag @s add oa.roster_viewer
tellraw @s {text:"参加者管理｜名前の右の操作をクリック",color:"gold"}
execute as @a run function oa:admin/players/row_prepare
tag @s remove oa.roster_viewer
''')
w(b/'row_prepare.mcfunction','''execute unless score @s oa.id matches 1.. run function oa:internal/id
execute store result storage oa:roster id int 1 run scoreboard players get @s oa.id
scoreboard players operation #join oa.tmp = @s oa.id
scoreboard players set #two oa.tmp 2
scoreboard players operation #join oa.tmp *= #two oa.tmp
scoreboard players operation #watch oa.tmp = #join oa.tmp
scoreboard players add #watch oa.tmp 1
execute store result storage oa:roster join int 1 run scoreboard players get #join oa.tmp
execute store result storage oa:roster watch int 1 run scoreboard players get #watch oa.tmp
function oa:admin/players/row with storage oa:roster
''')
w(b/'row.mcfunction','$tellraw @a[tag=oa.roster_viewer] [{selector:"@s"},{text:"  [参加]",color:"green",click_event:{action:"run_command",command:"/trigger oa.roster set $(join)"}},{text:"  [観戦]",color:"gray",click_event:{action:"run_command",command:"/trigger oa.roster set $(watch)"}}]\n')
w(b/'dispatch.mcfunction','''execute unless entity @s[tag=br.admin] run return 0
scoreboard players operation #roster_id oa.tmp = @s oa.roster
scoreboard players set #two oa.tmp 2
scoreboard players operation #roster_op oa.tmp = #roster_id oa.tmp
scoreboard players operation #roster_op oa.tmp %= #two oa.tmp
scoreboard players operation #roster_id oa.tmp /= #two oa.tmp
tag @a remove oa.roster_actor
tag @s add oa.roster_actor
scoreboard players set #roster_found oa.tmp 0
execute as @a if score @s oa.id = #roster_id oa.tmp at @s run function oa:admin/players/apply
execute if score #roster_found oa.tmp matches 0 run tellraw @s {text:"対象が退出しています。参加者一覧を開き直してください。",color:"yellow"}
tag @s remove oa.roster_actor
''')
w(b/'apply.mcfunction','''scoreboard players set #roster_found oa.tmp 1
execute if score #roster_op oa.tmp matches 0 run return run function oa:admin/players/join
function oa:admin/players/watch
''')
w(b/'watch.mcfunction','''execute if score #state br.state matches 2.. run return run tellraw @a[tag=oa.roster_actor] {text:"終了・演出処理の完了後に操作してください。",color:"yellow"}
execute if entity @s[tag=br.alive] run function oa:br/surrender
execute unless entity @s[tag=br.playing] run function oa:lobby/watch
execute if entity @s[tag=br.playing] run gamemode spectator @s
execute if score #state br.state matches 1 unless entity @s[tag=br.playing] run function oa:admin/players/live_watch
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を観戦へ変更しました。",color:"gray"}]
tellraw @s {text:"管理者により観戦へ変更されました。",color:"gray"}
''')
w(b/'live_watch.mcfunction','''tag @s add br.watch
tag @s remove br.lobby
gamemode spectator @s
function oa:internal/tp with storage oa:br center
''')
w(b/'join.mcfunction','''execute if score #state br.state matches 2.. run return run tellraw @a[tag=oa.roster_actor] {text:"終了・演出処理の完了後に操作してください。",color:"yellow"}
execute if entity @s[nbt={Health:0.0f}] run return run tellraw @a[tag=oa.roster_actor] {text:"対象のリスポーン完了後に再実行してください。",color:"yellow"}
execute if score #state br.state matches 0 run return run function oa:admin/players/wait_join
execute if entity @s[tag=br.alive] run return run tellraw @a[tag=oa.roster_actor] {text:"すでに生存参加中です。",color:"yellow"}
execute if score #mode br.mode matches 1 unless score @s br.pick matches 1..10 run return run tellraw @a[tag=oa.roster_actor] {text:"チーム未選択です。試合前にチームを選択してください。",color:"yellow"}
scoreboard players set #roster_count oa.tmp 0
execute as @a[tag=br.alive] run scoreboard players add #roster_count oa.tmp 1
execute if score #roster_count oa.tmp matches 10.. run return run tellraw @a[tag=oa.roster_actor] {text:"生存参加者は最大10人です。",color:"yellow"}
function oa:admin/players/live_join
''')
w(b/'wait_join.mcfunction','''execute if score @s br.saved matches 1 run return run tellraw @a[tag=oa.roster_actor] {text:"所持品の復元待ちです。復元完了後に操作してください。",color:"yellow"}
function oa:br/join
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を参加登録しました。",color:"green"}]
''')
w(b/'live_join.mcfunction','''# Find a safe current-border spawn before touching inventory or existing backup.
kill @e[type=minecraft:armor_stand,tag=oa.admin_spawn]
execute store result score #width oa.tmp in minecraft:overworld run worldborder get
scoreboard players set #two oa.tmp 2
scoreboard players operation #width oa.tmp /= #two oa.tmp
scoreboard players remove #width oa.tmp 2
execute if score #width oa.tmp matches ..0 run return run tellraw @a[tag=oa.roster_actor] {text:"安置が小さすぎるため途中参加できません。",color:"yellow"}
data modify storage oa:roster_spawn set from storage oa:br center
execute store result storage oa:roster_spawn range int 1 run scoreboard players get #width oa.tmp
function oa:admin/players/spawn with storage oa:roster_spawn
execute unless score #roster_spawn oa.tmp matches 1 run return run function oa:admin/players/spawn_failed
execute unless score @s br.saved matches 1 run function oa:br/save_player
execute unless score @s br.saved matches 1 run return run function oa:admin/players/spawn_failed
scoreboard players operation @s br.flag = @s br.pick
tag @s remove br.watch
tag @s add br.lobby
execute in minecraft:overworld at @e[type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] run tp @s ~ ~ ~
kill @e[type=minecraft:armor_stand,tag=oa.admin_spawn]
function oa:br/enter
execute if score #time br.time matches 1200.. run effect clear @s minecraft:resistance
execute if score #time br.time matches 1200.. run tag @s remove br.pvp_grace
execute if score #time br.time matches 1200.. run tag @s remove br.spawn_protection
execute if score #time br.time matches ..1199 run team join oa_brgrace @s
execute if score #time br.time matches ..1199 run tag @s add br.native_grace
scoreboard players set @s br.tp_ok 1
tellraw @s {text:"管理者により試合へ参加しました。",color:"green"}
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を試合へ参加させました。",color:"green"}]
''')
w(b/'spawn.mcfunction','''$execute in minecraft:overworld positioned $(x) $(y) $(z) run summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.admin_spawn"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b}
scoreboard players set #roster_spawn oa.tmp 0
$execute in minecraft:overworld store success score #roster_spawn oa.tmp run spreadplayers $(x) $(z) 0 $(range) false @e[type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
''')
w(b/'spawn_failed.mcfunction','''execute in minecraft:overworld run kill @e[type=minecraft:armor_stand,tag=oa.admin_spawn]
tellraw @a[tag=oa.roster_actor] {text:"安全な配置または所持品保存に失敗したため参加処理を中止しました。",color:"red"}
''')
with (f/'load.mcfunction').open('a') as x:x.write('\nscoreboard objectives add oa.roster trigger\n')
with (f/'public/tick.mcfunction').open('a') as x:x.write('\nexecute as @a[scores={oa.roster=1..}] at @s run function oa:admin/players/dispatch\nscoreboard players set @a oa.roster 0\nscoreboard players enable @a[tag=br.admin] oa.roster\n')
with (f/'admin/dispatch.mcfunction').open('a') as x:x.write('\nexecute if score @s oa.admin matches 35 run function oa:admin/players/menu\n')
with (f/'admin/menu.mcfunction').open('a') as x:x.write('\ntellraw @s {text:"[参加者管理] 参加・観戦を変更",color:"green",click_event:{action:"run_command",command:"/trigger oa.admin set 35"}}\n')
x=f/'admin/book.mcfunction';s=x.read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',a);j=json.loads(s[a:e]);j['pages'][0]['raw']['extra'].insert(1,{'text':'参加者管理\n\n','color':'dark_blue','underlined':True,'click_event':{'action':'run_command','command':'/trigger oa.admin set 35'}});s=s[:a]+json.dumps(j,ensure_ascii=False,separators=(',',':'))+s[e:];s=s.replace('book_v160','book_v163');w(x,s)
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.6.2','1.6.3');
  if t!=s:w(x,t)
x=p/'README_JA.md';s=x.read_text();s+='\n## 管理者による参加・観戦の変更\n管理ブックの「参加者管理」または `/trigger oa.admin set 35` からオンラインのプレイヤー一覧を開き、名前の右の「参加」「観戦」をクリックします。管理者登録済みの人のみ操作可能。古い本は `/trigger oa.admin set 16` で新しい本を取得してください。\n待機中は参加登録／観戦者へ切り替えます。試合中の「参加」は初期装備で現在の安置内に再配置し、事前の所持品バックアップを保持します（再参加でも上書きしません）。チーム戦は事前選択チームを使用します。開始保護の終了後に新しい保護期間は付与しません。生存者への「観戦」は所持品を落として脱落し、生存者数・勝敗判定に反映します。終了演出中の変更は不可。最後の生存者を観戦にすると試合が終了する場合があります。最大10人生存、安置が極小の場合・安全地点を確保できない場合は途中参加不可。途中参加・復帰は管理者による例外操作で、通常プレイヤーの復活機能ではありません。\n';w(x,s)
shutil.copy('/tmp/admin163.py',p/'source/build163_admin.py')
print('implemented')
