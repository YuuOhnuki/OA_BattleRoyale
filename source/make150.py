from pathlib import Path
from PIL import Image
import json,re,shutil,zipfile
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';F=P/'data/oa/function';O=R/'release_1_5';RP=O/'resourcepack';shutil.copytree(R/'release_1_4/resourcepack',RP,dirs_exist_ok=True)
def fn(n,s):p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n')
def add(n,s):
 with (F/(n+'.mcfunction')).open('a') as f:f.write('\n'+s.strip()+'\n')
def js(p,v):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
# Human-readable states.
fn('admin/state','\n'.join(f'execute if score #state br.state matches {k} run tellraw @s '+json.dumps({'text':'試合状態：'+v,'color':c},ensure_ascii=False) for k,v,c in [(0,'待機中','green'),(1,'試合中','yellow'),(2,'清掃・復元中','aqua'),(3,'勝者演出中','gold')]))
p=F/'admin/status.mcfunction';s=p.read_text();s=re.sub(r'tellraw @s \[\{text:"参加登録人数："[^\n]+','tellraw @s [{text:"参加登録人数：",color:"aqua"},{score:{name:"#ready_n",objective:"oa.tmp"}}]\nfunction oa:admin/state',s);p.write_text(s)
for base in [P/'data/oa_map2/function',R/'map300_project/pack/data/oa_map2/function']:
 p=base/'status.mcfunction';p.write_text('\n'.join(f'execute if score #state oa.map2 matches {k} run tellraw @s '+json.dumps({'text':'マップ：'+v,'color':c},ensure_ascii=False) for k,v,c in [(0,'未生成','gray'),(1,'処理中','yellow'),(2,'停止中','gold'),(3,'完成','green')])+'\ntellraw @s [{text:"処理区画：",color:"aqua"},{score:{name:"#tile",objective:"oa.map2"}},{text:"/100 ／ 登録チェスト："},{score:{name:"#chests",objective:"oa.map2"}},{text:" ／ 鉱石："},{score:{name:"#ores",objective:"oa.map2"}}]\n')
# Decoy ends have departure and arrival bursts; sustain remains invisible.
fn('nero/end_fx','particle minecraft:reverse_portal ~ ~1 ~ 0.7 0.8 0.7 0.15 50 normal @a[distance=..32]\nparticle minecraft:firework ~ ~1 ~ 0.5 0.7 0.5 0.08 28 normal @a[distance=..32]\nplaysound minecraft:entity.firework_rocket.twinkle player @s ~ ~ ~ 1.8 0.9')
p=F/'nero/decoy_return.mcfunction';s=p.read_text().replace('tag @s remove oa.self_decoy','function oa:nero/end_fx\ntag @s remove oa.self_decoy').replace('function oa:nero/clear_decoy','execute at @s run function oa:nero/end_fx\nfunction oa:nero/clear_decoy');p.write_text(s)
add('nero/pop','particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..32]\nparticle minecraft:crit ~ ~1 ~ 0.8 0.9 0.8 0.2 45 normal @a[distance=..32]')
add('nero/blind_attacker','particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..32]\nparticle minecraft:reverse_portal ~ ~1 ~ 0.6 0.8 0.6 0.1 36 normal @a[distance=..32]')
# Clock is controlled only during a match and restored afterward.
fn('br/day/start','execute in minecraft:overworld store result storage oa:day backup.time int 1 run time query time\nexecute store result storage oa:day backup.advance int 1 run gamerule minecraft:advance_time\ngamerule minecraft:advance_time false\nexecute in minecraft:overworld run time set 6000t')
fn('br/day/tick','scoreboard players operation #sun oa.tmp = #time br.time\nscoreboard players set #four oa.tmp 4\nscoreboard players operation #sun oa.tmp *= #four oa.tmp\nscoreboard players add #sun oa.tmp 6000\nexecute store result storage oa:day args.time int 1 run scoreboard players get #sun oa.tmp\nexecute in minecraft:overworld run function oa:br/day/set with storage oa:day args')
fn('br/day/set','$time set $(time)t')
fn('br/day/restore','execute unless data storage oa:day backup run return 0\nexecute in minecraft:overworld run function oa:br/day/set with storage oa:day backup\nexecute if data storage oa:day backup{advance:1} run gamerule minecraft:advance_time true\nexecute if data storage oa:day backup{advance:0} run gamerule minecraft:advance_time false\ndata remove storage oa:day backup')
p=F/'br/start.mcfunction';s=p.read_text().replace('scoreboard players set #state br.state 1','scoreboard players set #state br.state 1\nfunction oa:br/day/start');p.write_text(s)
p=F/'br/tick.mcfunction';s=p.read_text().replace('scoreboard players add #time br.time 1','scoreboard players add #time br.time 1\nfunction oa:br/day/tick');p.write_text(s);add('br/finish','function oa:br/day/restore')
# Axe-like attack interval (0.8 attacks/sec); add swing sound on a confirmed bat hit.
batmod={'type':'minecraft:set_attributes','replace':True,'modifiers':[{'id':'oa:bat_damage','attribute':'minecraft:attack_damage','amount':3.0,'operation':'add_value','slot':'mainhand'},{'id':'oa:bat_speed','attribute':'minecraft:attack_speed','amount':-3.2,'operation':'add_value','slot':'mainhand'}]}
for p in (P/'data/oa/loot_table/br').rglob('*.json'):
 v=json.loads(p.read_text());changed=False
 for pool in v.get('pools',[]):
  for e in pool.get('entries',[]):
   if any(m.get('components',{}).get('minecraft:custom_data',{}).get('oa_normal')=='bat' for m in e.get('modifier',[])):
    e['modifier']=[m for m in e['modifier'] if m.get('type')!='minecraft:set_attributes']+[batmod];changed=True
 if changed:js(p,v)
# Existing bats also migrate while held/inventory visual upgrade is invoked.
p=P/'data/oa/item_modifier/bat_visual.json';v=json.load(p.open());js(p,{'type':'minecraft:sequence','functions':[v,batmod]})
add('normal/bat_hit','playsound minecraft:entity.player.attack.sweep player @a[distance=..24] ~ ~ ~ 1.2 0.65')
# Map is corrected by UV orientation; the frame is a symmetric square around the 8x8 image.
p=RP/'assets/oa/textures/item/br_map.png';Image.open(p).transpose(Image.Transpose.FLIP_LEFT_RIGHT).save(p)
p=F/'lobby/build.mcfunction';s=p.read_text().replace('fill ~-5 ~0 ~36 ~5 ~11 ~36','fill ~-5 ~0 ~36 ~5 ~10 ~36').replace('fill ~-4 ~1 ~35 ~4 ~10 ~35','fill ~-4 ~1 ~35 ~4 ~9 ~35');s='\n'.join(l for l in s.splitlines() if 'OA累計ランキング' not in l)+'\n';s+='function oa:stats/holo_ensure with storage oa:lobby origin\n';# At creation storage may still old/notregistered, don't call until saved.
s=s.replace('function oa:stats/holo_ensure with storage oa:lobby origin\n','');p.write_text(s)
# Position picture geometric center on the frame center: frame block-centers .5..10.5 ->5.5.
# Restore map direction labels only if horizontal render really changed; OA orientation is the target.
# Durable player-name cache via vanilla profile loot, allowing offline score holders in holograms.
js(P/'data/oa/loot_table/stats/name.json',{'type':'minecraft:chest','pools':[{'rolls':1,'entries':[{'type':'minecraft:item','name':'minecraft:player_head','modifier':[{'type':'minecraft:fill_player_head','entity':'this'}]}]}]})
add('stats/load','scoreboard objectives add oa.rank_used dummy\nexecute unless data storage oa:ranking users run data modify storage oa:ranking users set value []\nexecute if score #state br.state matches 0 run function oa:stats/hide_sidebar')
fn('stats/register','''summon minecraft:item_display ~ ~ ~ {Tags:["oa.rank_reader"]}
loot replace entity @e[type=minecraft:item_display,tag=oa.rank_reader,limit=1] contents loot oa:stats/name
data modify storage oa:rank_register row set value {}
data modify storage oa:rank_register row.name set from entity @e[type=minecraft:item_display,tag=oa.rank_reader,limit=1] item.components."minecraft:profile".name
kill @e[tag=oa.rank_reader]
execute unless data storage oa:rank_register row.name run return 0
execute store result storage oa:rank_register row.id int 1 run scoreboard players get @s oa.id
data modify storage oa:ranking users append from storage oa:rank_register row
tag @s add oa.rank_recorded''')
p=F/'stats/collect.mcfunction';s=p.read_text()+'\nexecute if entity @s[tag=br.playing,tag=!oa.rank_recorded] at @s run function oa:stats/register\n';p.write_text(s)
colors=['gray','light_purple','aqua','red','blue','green','yellow','dark_purple','gold','white','dark_gray']
fn('stats/hide_sidebar','execute unless score #state br.state matches 0 run return 0\nscoreboard objectives setdisplay sidebar\n'+'\n'.join('scoreboard objectives setdisplay sidebar.team.'+c for c in colors))
# Keep old show_* entry points safe; only holograms now display idle rankings.
labels={'dd':'与ダメージ(0.1HP)','dt':'被ダメージ(0.1HP)','move':'地上移動(m)','jump':'ジャンプ数','kill':'撃破数','death':'死亡数','win':'勝利数'}
rot=['scoreboard players set #rank_clock oa.tmp 0','function oa:stats/hide_sidebar','scoreboard players add #rank_kind oa.tmp 1','execute if score #rank_kind oa.tmp matches 8.. run scoreboard players set #rank_kind oa.tmp 1']
for i,(k,title) in enumerate(labels.items(),1):
 fn('stats/show_'+k,'data modify storage oa:rank_args objective set value "oa.st_'+k+'"\ndata modify storage oa:rank_render text set value '+json.dumps({'text':'OAランキング｜'+title+'\n','color':'gold','extra':[]},ensure_ascii=False)+'\nfunction oa:stats/rank_begin')
 rot.append(f'execute if score #rank_kind oa.tmp matches {i} run function oa:stats/show_{k}')
fn('stats/rotate','\n'.join(rot))
fn('stats/rank_begin','''execute unless data storage oa:lobby origin{ready:1b} run return 0
function oa:stats/holo_ensure with storage oa:lobby origin
scoreboard players add #rank_epoch oa.tmp 1
scoreboard players set #place oa.tmp 1
execute store result score #users oa.tmp run data get storage oa:ranking users
function oa:stats/rank_place
execute if score #users oa.tmp matches 0 run data modify storage oa:rank_render text.extra append value {text:"まだ記録がありません。",color:"white"}
execute as @e[tag=oa.rank_holo] run data modify entity @s text set from storage oa:rank_render text''')
fn('stats/rank_place','''scoreboard players set #best oa.tmp -1
data remove storage oa:rank_args best
scoreboard players set #index oa.tmp 0
execute if score #users oa.tmp matches 1.. run function oa:stats/rank_scan
execute unless data storage oa:rank_args best.name run return 0
execute store result storage oa:rank_args best.value int 1 run scoreboard players get #best oa.tmp
execute store result storage oa:rank_args best.place int 1 run scoreboard players get #place oa.tmp
function oa:stats/rank_append with storage oa:rank_args best
scoreboard players add #place oa.tmp 1
execute if score #place oa.tmp matches ..5 run function oa:stats/rank_place''')
fn('stats/rank_scan','''execute store result storage oa:rank_args i int 1 run scoreboard players get #index oa.tmp
function oa:stats/rank_fetch with storage oa:rank_args
scoreboard players add #index oa.tmp 1
execute if score #index oa.tmp < #users oa.tmp if score #index oa.tmp matches ..999 run function oa:stats/rank_scan''')
fn('stats/rank_fetch','''$data modify storage oa:rank_args current set from storage oa:ranking users[$(i)]
$data modify storage oa:rank_args current.objective set value "$(objective)"
function oa:stats/rank_candidate with storage oa:rank_args current''')
fn('stats/rank_candidate','''scoreboard players set #cand oa.tmp -1
$execute unless score $(name) oa.rank_used = #rank_epoch oa.tmp store result score #cand oa.tmp run scoreboard players get $(name) $(objective)
execute if score #cand oa.tmp > #best oa.tmp run data modify storage oa:rank_args best set from storage oa:rank_args current
execute if score #cand oa.tmp > #best oa.tmp run scoreboard players operation #best oa.tmp = #cand oa.tmp''')
fn('stats/rank_append','''$data modify storage oa:rank_render text.extra append value {text:"$(place). $(name) — $(value)\\n",color:"white"}
$scoreboard players operation $(name) oa.rank_used = #rank_epoch oa.tmp''')
fn('stats/holo_ensure','''$execute in minecraft:overworld positioned $(x) $(y) $(z) unless entity @e[tag=oa.rank_holo,distance=..60] run summon minecraft:text_display ~0.5 ~4 ~-36 {Tags:["oa.lobby_label","oa.rank_holo"],text:{text:"OAランキング\\n集計待機中",color:"gold"},billboard:"center",line_width:300,background:1073741824,shadow:1b,view_range:1.5}''')
# Cleanup previous static ranking instructions when their complete previous string matches.
add('lobby/tick','execute if score #clock oa.beat matches 0 as @e[type=minecraft:text_display,tag=oa.rank_holo] run data merge entity @s {Invulnerable:1b}')
# Expand actual existing book by editing the structured component in its give command.
p=F/'admin/book.mcfunction';s=p.read_text();prefix='minecraft:written_book_content=';a=s.index(prefix)+len(prefix);b=s.index(',minecraft:custom_name=',a);book=json.loads(s[a:b]);
unique=[('ゆうあ',20,'yuua'),('ぴちぴち',21,'pichipichi'),('lazi',22,'lazi'),('ネロ',23,'nero'),('キリング',24,'killing'),('ゆったり',25,'yuttari'),('ほちきす',26,'hotchikisu'),('こまめ',27,'komame'),('ゆー',28,'overwork')]
for subset in [unique[:5],unique[5:]]:
 xs=[{'text':'固有装備を入手\n\n','color':'dark_purple','bold':True}]
 for title,num,key in subset:
  xs.append({'text':title+'\n\n','color':'dark_blue','underlined':True,'click_event':{'action':'run_command','command':f'/trigger oa.admin set {num}'}})
 book['pages'].append({'raw':{'text':'','extra':xs}})
s=s[:a]+json.dumps(book,ensure_ascii=False,separators=(',',':'))+s[b:];# Upgrade previously owned admin books once.
s=s.replace('{oa_admin_book:1b}]','{oa_admin_book:1b,book_v150:1b}]').replace('"oa_admin_book":true','"oa_admin_book":true,"book_v150":true');p.write_text(s)
for _,n,key in unique:add('admin/dispatch',f'execute if score @s oa.admin matches {n} run function oa:give/{key}')
# Docs change current sections rather than append changelog.
p=P/'README_JA.md';s=p.read_text().replace('本のページは試合・生成・再建と統計・テスト・案内に分かれています。','本のページは試合・生成・再建と統計・通常アイテム・固有装備の入手・案内に分かれています。旧ブック所持者も /trigger oa.admin set 16 で新版を受け取れます。').replace('待機中は10秒ごとにサイドバーの項目を切り替え、上位15人まで表示します。','待機中はロビーのホログラムで10秒ごとに項目を切り替え、上位5人まで表示します。プレイヤー名をキャッシュし、退出後も登録済みスコアを参照します（候補上限1000人）。').replace('サイドバー表示はワールド共通で、ロビー外の待機プレイヤーにも表示されます。','待機中のランキングはサイドバーに表示しません。名前キャッシュは本版で試合に参加した人から登録するため、初回は過去の記録が全員分そろわない場合があります。').replace('上位15人','上位5人').replace('北が上の固定画像','OAが正向きに読めるよう左右表示を補正した固定画像')
s=s.replace('試合終了後は所持品','昼夜は昼スタートで、昼→夜→昼の1周期5分（昼夜が約2分30秒ずつ）の4倍速です。試合中だけadvance_timeを停止し、時刻を毎tick制御。終了後は開始前の時刻と設定に復元します。同じオーバーワールド全体へ影響します。\n試合終了後は所持品')
s=s.replace('バットは `/function oa:give/bat`','木のバットは攻撃速度0.8回/秒（約1.25秒間隔）。命中時に振り音を再生します。バニラのデータパックだけでは任意の空振り左クリックを確実に検知できないため、空振りの専用音は未対応です。既存バットも持ち物検査時に攻撃速度を更新します。\nバットは `/function oa:give/bat`')
s=s.replace('8×8ブロック。','8×8ブロック、背面は正方形。').replace('記録開始は本版導入後です。','統計の記録は従来版から継続し、ホログラムへの名前登録は本版で試合に参加してからです。');p.write_text(s)
for base in [P,RP]:
 for p in base.rglob('*'):
  if p.is_file() and p.suffix in ['.json','.mcmeta','.mcfunction','.md']:
   try:s=p.read_text()
   except UnicodeError:continue
   s=s.replace('1.4.1','1.5.0').replace('1.4.0','1.5.0');p.write_text(s)
shutil.copyfile(__file__,P/'source/make150.py')
print('Written1.5.0')
