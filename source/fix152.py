from pathlib import Path
import json,re,zipfile,shutil
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';F=P/'data/oa/function';O=R/'release_1_5_2'
def fn(n,s):p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n')
def add(n,s):
 with (F/(n+'.mcfunction')).open('a') as f:f.write('\n'+s.strip()+'\n')
# Fix the two parse errors explicitly reported by latest(4).log using the existing valid RGBA schema.
for n in ['nero/pop','nero/blind_attacker']:
 p=F/(n+'.mcfunction');p.write_text(p.read_text().replace('minecraft:flash ~','minecraft:flash{color:[0.7,0.3,1.0,1.0]} ~'))
# Pad activation is edge-triggered: leave BOTH start blocks to re-arm after any attempt.
p=F/'lobby/host_tick.mcfunction';s=p.read_text();s=s.replace('execute if score @s br.lmode matches 0 run return run scoreboard players set @s br.lcnt 0','execute if score @s br.lmode matches 0 run tag @s remove br.pad_latched\nexecute if score @s br.lmode matches 0 run return run scoreboard players set @s br.lcnt 0\nexecute if entity @s[tag=br.pad_latched] run return 0');s=s.replace('scoreboard players set @s br.lcnt 0\nexecute if score @s br.lmode matches 1','scoreboard players set @s br.lcnt 0\ntag @a[tag=br.host,tag=br.lobby_now] add br.pad_latched\nexecute if score @s br.lmode matches 1');p.write_text(s)
add('lobby/tick','tag @a[tag=br.pad_latched,tag=!br.lobby_now] remove br.pad_latched\nexecute as @a[tag=br.pad_latched] at @s unless block ~ ~-0.1 ~ minecraft:emerald_block unless block ~ ~-0.1 ~ minecraft:diamond_block run tag @s remove br.pad_latched')
# Player spread performs native teleport/chunk-ticket operations directly. Failed spread is rolled back.
p=F/'br/start.mcfunction';s=p.read_text();a=s.index('# Preflight random safe locations');b=s.index('execute as @a[tag=br.lobby] at @s run function oa:br/save_player',a);s=s[:a]+'''function oa:br/check_center
execute if score #center_ok br.flag matches 0 run return run tellraw @s {text:"BR中心がロビーと近すぎます。管理ブックでマップ中央を登録してください。",color:"red"}
'''+s[b:];s=s.replace('execute if entity @a[tag=br.playing,scores={br.tp_ok=0}] run return run function oa:br/tp_abort','''execute if data storage oa:br center run function oa:br/live_spread with storage oa:br center
execute unless score #spawn_live br.flag matches 1 run return run function oa:br/tp_abort''');p.write_text(s)
p=F/'br/enter.mcfunction';s=p.read_text().replace('function oa:br/enter_tp with storage oa:br_args','');p.write_text(s)
fn('br/live_spread','''scoreboard players set #spawn_live br.flag 0
$execute if score #mode br.mode matches 0 in minecraft:overworld store success score #spawn_live br.flag run spreadplayers $(x) $(z) 24 130 false @a[tag=br.playing,tag=br.alive]
$execute if score #mode br.mode matches 1 in minecraft:overworld store success score #spawn_live br.flag run spreadplayers $(x) $(z) 24 130 true @a[tag=br.playing,tag=br.alive]
execute if score #spawn_live br.flag matches 1 run scoreboard players set @a[tag=br.playing] br.tp_ok 1''')
fn('br/check_center','''scoreboard players set #center_ok br.flag 1
execute unless data storage oa:lobby origin{ready:1b} run return 0
execute store result score #dx oa.tmp run data get storage oa:br center.x 1000
execute store result score #dz oa.tmp run data get storage oa:br center.z 1000
execute store result score #lx oa.tmp run data get storage oa:lobby origin.x 1000
execute store result score #lz oa.tmp run data get storage oa:lobby origin.z 1000
scoreboard players operation #dx oa.tmp -= #lx oa.tmp
scoreboard players operation #dz oa.tmp -= #lz oa.tmp
scoreboard players set #minus oa.tmp -1
execute if score #dx oa.tmp matches ..-1 run scoreboard players operation #dx oa.tmp *= #minus oa.tmp
execute if score #dz oa.tmp matches ..-1 run scoreboard players operation #dz oa.tmp *= #minus oa.tmp
execute if score #dx oa.tmp matches ..190000 if score #dz oa.tmp matches ..190000 run scoreboard players set #center_ok br.flag 0''')
# Book setting actions use public safe entry points, never the kill-self marker helper.
fn('admin/generated_center','execute unless score #state br.state matches 0 run return 0\nexecute unless data storage oa_map2:args center_y run return run tellraw @s {text:"自動生成マップの基準地点が未登録です。現在地の中心登録かマップ生成を行ってください。",color:"red"}\nfunction oa_map2:center with storage oa_map2:args\nfunction oa:admin/status')
fn('admin/go_center','execute unless data storage oa:br center run return run tellraw @s {text:"BR中心が未登録です。",color:"red"}\nfunction oa:lobby/center with storage oa:br center')
# center has the same x/y/z fields accepted by lobby/center; only teleport, no registration mutation.
for n,ref in [(29,'br/center'),(30,'admin/generated_center'),(31,'admin/go_center'),(32,'lobby/return'),(33,'admin/defaults')]:add('admin/dispatch',f'execute if score @s oa.admin matches {n} run function oa:{ref}')
add('admin/status','''execute if data storage oa:br center run tellraw @s [{text:"BR中心 X/Y/Z：",color:"aqua"},{nbt:"center.x",storage:"oa:br"},{text:" / "},{nbt:"center.y",storage:"oa:br"},{text:" / "},{nbt:"center.z",storage:"oa:br"}]
execute if data storage oa:br center run function oa:br/check_center
execute if data storage oa:br center if score #center_ok br.flag matches 0 run tellraw @s {text:"注意：BR中心とロビーの範囲が重なります。中心登録を見直してください。",color:"red"}
execute if score #state br.state matches 4 run tellraw @s {text:"試合状態：開始前の清掃中",color:"yellow"}''')
p=F/'admin/book.mcfunction';s=p.read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');b=s.index(',minecraft:custom_name=',a);book=json.loads(s[a:b]);xs=[{'text':'中心・初期設定\n\n','color':'dark_purple','bold':True}]
for name,n in [('現在地をBR中心に登録',29),('生成マップの中心を使う',30),('登録したBR中心へ移動',31),('ロビーへ戻る',32),('準備・座標を確認',2)]:xs.append({'text':name+'\n\n','color':'dark_blue','underlined':True,'click_event':{'action':'run_command','command':f'/trigger oa.admin set {n}'}})
book['pages'].append({'raw':{'text':'','extra':xs}});s=s[:a]+json.dumps(book,ensure_ascii=False,separators=(',',':'))+s[b:];s=s.replace('book_v150','book_v152');p.write_text(s)
# Put a short note in the guide instead of an accumulating change history.
p=P/'README_JA.md';s=p.read_text();s=s.replace('試合・生成・再建と統計・通常アイテム・固有装備の入手・案内','試合・生成・中心設定・再建と統計・通常アイテム・固有装備の入手・案内');s=s.replace('開始配置は変更前に全員分の座標を保存・検査し、TP失敗時は試合を中止して所持品を復元します。','開始配置はバニラのspreadplayersで参加プレイヤーへ直接行い、配置失敗時は試合を中止して所持品を復元します。');s+='\n管理ブックの「中心・初期設定」ページで現在地のBR中心登録、自動生成マップ中心の再設定、中心への移動、ロビー帰還、準備・座標確認を行えます。現在地を登録する場合はマップ中央の地面に立って実行してください。BR中心とロビーの範囲が近すぎる場合は開始を拒否します。開始パッドは開始を1回試すとロックし、両開始パッドから降りるまで再カウントしません。失敗理由はチャットで確認し、設定を直してから乗り直してください。\n';p.write_text(s)
for p in P.rglob('*'):
 if p.is_file() and p.suffix in ['.json','.mcmeta','.mcfunction','.md']:
  try:s=p.read_text()
  except UnicodeError:continue
  if '1.5.1' in s:p.write_text(s.replace('1.5.1','1.5.2'))
shutil.copyfile(__file__,P/'source/fix152.py')
for p in P.rglob('*.json'):json.loads(p.read_text())
for p in F.rglob('*.mcfunction'):
 for l in p.read_text().splitlines():
  if '$(' in l:assert l.startswith('$'),(p,l)
  assert 'particle minecraft:flash ~' not in l,(p,l)
  m=re.search(r'(?:^\$?|\brun )function (oa(?:_map2|_map)?:[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,k=m[1].split(':',1);assert (P/f'data/{ns}/function/{k}.mcfunction').exists(),(p,m[1])
s=(F/'br/start.mcfunction').read_text();assert 'oa:br/preflight' not in s and 'oa:br/cache_player' not in s;assert s.index('oa:br/enter')<s.index('oa:br/live_spread')
# Pad-state simulation: continuous standing makes exactly one attempt; leaving re-arms.
latched=False;count=0;attempts=0
for on_pad in [True]*400+[False]+[True]*100:
 if not on_pad:latched=False;count=0;continue
 if latched:continue
 count+=1
 if count>=100:latched=True;count=0;attempts+=1
assert attempts==2
with zipfile.ZipFile(O/'OA_BattleRoyale_v1.5.2.zip','w',zipfile.ZIP_DEFLATED) as z:
 for p in P.rglob('*'):
  if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(P))
with zipfile.ZipFile(O/'OA_BattleRoyale_v1.5.2.zip') as z:assert z.testzip() is None
print('PASS JSON/refs/macros, logged flash parsing regression, direct player spread order, pad latch simulation, ZIP CRC; runtime untested')
