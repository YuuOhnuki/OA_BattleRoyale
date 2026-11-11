from pathlib import Path
import json,re,shutil
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';F=P/'data/oa/function';O=R/'release_1_4';RP=O/'resourcepack';shutil.copytree(R/'release_1_3/resourcepack',RP,dirs_exist_ok=True)
def fn(name,text):
 p=F/(name+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(text.strip()+'\n')
def add(name,text):
 with (F/(name+'.mcfunction')).open('a') as f:f.write('\n'+text.strip()+'\n')
# Three precise bells at each impending new contraction, never every tick.
add('br/tick','\n'.join(f'execute if score #time br.time matches {start-delta} as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1' for start in [2400,4800,7200,10800,12000] for delta in [60,40,20]))
# Volume scaling applies only ability-related paths, keeping private decoy audio private.
roots=['nero','yuttari','komame','hotchikisu'];files=[p for d in roots for p in (F/d).glob('*.mcfunction')]+[F/'lazi/sonic.mcfunction']
for p in files:
 s=p.read_text();s=re.sub(r'(playsound \S+ \S+ \S+ ~ ~ ~ )([0-9.]+)',lambda m:m[1]+f'{float(m[2])*1.2:.6g}',s);p.write_text(s)
add('komame/use','''execute unless entity @s[nbt={active_effects:[{id:"minecraft:speed"}]}] run function oa:komame/speed
playsound minecraft:entity.firework_rocket.twinkle player @a[distance=..32] ~ ~ ~ 2.4 1.5
particle minecraft:firework ~ ~1 ~ 0.7 0.8 0.7 0.07 32 normal @a[distance=..32]''')
p=F/'komame/use.mcfunction';s=p.read_text().replace('~ ~ ~ 2.4 1.4','~ ~ ~ 3.6 1.4').replace('~ ~ ~ 1.44 1.6','~ ~ ~ 2.16 1.6');p.write_text(s)
fn('komame/speed','effect give @s minecraft:speed 10 0 true\ntag @s add oa.komame_speed')
add('komame/cleanup','execute if entity @s[tag=oa.komame_speed,nbt={active_effects:[{id:"minecraft:speed",amplifier:0}]}] run effect clear @s minecraft:speed\ntag @s remove oa.komame_speed')
for name in ['yuttari/use','hotchikisu/use','lazi/sonic']:
 add(name,'particle minecraft:firework ~ ~1 ~ 0.5 0.7 0.5 0.03 16 normal @a[distance=..24]')
# Normal weapons are copied directly from the authoritative loot entry.
for key,title in [('bat','木のバット'),('stick','木のノックバック棒')]:
 t=json.loads((P/'data/oa/loot_table/br/chest_basic.json').read_text());e=next(e for po in t['pools'] for e in po.get('entries',[]) if any(m.get('components',{}).get('minecraft:custom_name',{}).get('text')==title for m in e.get('modifier',[])));e['weight']=1
 p=P/f'data/oa/loot_table/br/test/{key}.json';p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps({'type':'minecraft:chest','pools':[{'rolls':1,'entries':[e]}]},ensure_ascii=False,indent=2));fn('give/'+key,f'loot give @s loot oa:br/test/{key}')
# Native statistics: raw monotonically increasing counters, round-only deltas.
criteria={'dd':'minecraft.custom:minecraft.damage_dealt','dt':'minecraft.custom:minecraft.damage_taken','walk':'minecraft.custom:minecraft.walk_one_cm','run':'minecraft.custom:minecraft.sprint_one_cm','jump':'minecraft.custom:minecraft.jump','kill':'playerKillCount','death':'deathCount'}
load=[]
for k,c in criteria.items():load += [f'scoreboard objectives add oa.r_{k} {c}',f'scoreboard objectives add oa.b_{k} dummy']
labels={'dd':'与ダメージ（0.1HP）','dt':'被ダメージ（0.1HP）','move':'地上移動距離（m）','jump':'ジャンプ数','kill':'撃破数','death':'死亡数','win':'勝利数'}
for k,n in labels.items():load.append(f'scoreboard objectives add oa.st_{k} dummy '+json.dumps({'text':'OAランキング｜'+n,'color':'gold'},ensure_ascii=False,separators=(',',':')))
load+=['scoreboard objectives add oa.cm dummy','scoreboard objectives add oa.stats trigger','scoreboard objectives add oa.admin trigger','scoreboard objectives add oa.return trigger','scoreboard objectives add oa.lfxw dummy','scoreboard objectives add oa.lfxd dummy','scoreboard objectives add oa.lfxt dummy','scoreboard players add #rank_clock oa.tmp 0']
fn('stats/load','\n'.join(load));add('load','function oa:stats/load')
base=[];collect=[]
for k in criteria:
 base += [f'scoreboard players add @s oa.r_{k} 0',f'scoreboard players operation @s oa.b_{k} = @s oa.r_{k}']
 collect += [f'scoreboard players add @s oa.r_{k} 0',f'execute unless score @s oa.b_{k} matches 0.. run scoreboard players operation @s oa.b_{k} = @s oa.r_{k}',f'scoreboard players operation #delta oa.tmp = @s oa.r_{k}',f'scoreboard players operation #delta oa.tmp -= @s oa.b_{k}']
 target='oa.cm' if k in ['walk','run'] else 'oa.st_'+k
 collect += [f'execute if score #state br.state matches 1 if entity @s[tag=br.playing] if score #delta oa.tmp matches 1.. run scoreboard players operation @s {target} += #delta oa.tmp',f'scoreboard players operation @s oa.b_{k} = @s oa.r_{k}']
collect+=['scoreboard players add @s oa.cm 0','scoreboard players operation @s oa.st_move = @s oa.cm','scoreboard players set #100 oa.tmp 100','scoreboard players operation @s oa.st_move /= #100 oa.tmp']
fn('stats/baseline','\n'.join(base));fn('stats/collect','\n'.join(collect));fn('stats/tick','execute as @a run function oa:stats/collect\nexecute unless score #state br.state matches 0 run return 0\nscoreboard players add #rank_clock oa.tmp 1\nexecute if score #rank_clock oa.tmp matches 200.. run function oa:stats/rotate')
# Initialize delta accumulation targets so scoreboard += succeeds for new players.
p=F/'stats/collect.mcfunction';s=p.read_text();s='\n'.join(f'scoreboard players add @s oa.st_{k} 0' for k in labels)+'\nscoreboard players add @s oa.cm 0\n'+s;p.write_text(s)
p=F/'tick.mcfunction';p.write_text('function oa:stats/tick\n'+p.read_text())
colors=['gray','light_purple','aqua','red','blue','green','yellow','dark_purple','gold','white','dark_gray']
rot=['scoreboard players set #rank_clock oa.tmp 0','scoreboard players add #rank_kind oa.tmp 1','execute if score #rank_kind oa.tmp matches 8.. run scoreboard players set #rank_kind oa.tmp 1']
for i,k in enumerate(labels,1):
 sub=[f'scoreboard objectives setdisplay sidebar oa.st_{k}']+[f'scoreboard objectives setdisplay sidebar.team.{c} oa.st_{k}' for c in colors]
 fn('stats/show_'+k,'\n'.join(sub));rot.append(f'execute if score #rank_kind oa.tmp matches {i} run function oa:stats/show_{k}')
fn('stats/rotate','\n'.join(rot))
fn('stats/reset','\n'.join(f'scoreboard players reset * oa.st_{k}' for k in labels)+'\nscoreboard players reset * oa.cm\nexecute as @a run function oa:stats/baseline\ntellraw @s {text:"OA累計ランキングをリセットしました。",color:"green"}')
fn('stats/personal','tellraw @s [{text:"OA累計｜与ダメージ(0.1HP)：",color:"gold"},{score:{name:"@s",objective:"oa.st_dd"}},{text:"／被ダメージ(0.1HP)："},{score:{name:"@s",objective:"oa.st_dt"}},{text:"／地上移動(m)："},{score:{name:"@s",objective:"oa.st_move"}},{text:"／撃破："},{score:{name:"@s",objective:"oa.st_kill"}},{text:"／勝利："},{score:{name:"@s",objective:"oa.st_win"}}]')
add('br/enter','function oa:stats/baseline')
p=F/'br/celebration/start.mcfunction';p.write_text('scoreboard players add @a[tag=br.winner] oa.st_win 1\n'+p.read_text())
# Public spectator return works without OP and never rejoins an ongoing match.
fn('lobby/return','execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中は参加へ戻れません。",color:"yellow"}\nfunction oa:br/join\nexecute if data storage oa:lobby origin{ready:1b} run function oa:lobby/center with storage oa:lobby origin')
p=F/'lobby/watch.mcfunction';s=p.read_text();s=s[:s.index('tellraw @s')]+'''tellraw @s [{text:"観戦者になりました。",color:"gray"},{text:"[参加へ戻る]",color:"green",underlined:true,click_event:{action:"run_command",command:"/trigger oa.return"}}]
''';p.write_text(s)
add('public/tick','''execute as @a[scores={oa.return=1..}] at @s run function oa:lobby/return
execute as @a[scores={oa.stats=1..}] run function oa:stats/personal
execute as @a[scores={oa.admin=1..}] at @s run function oa:admin/dispatch
scoreboard players set @a oa.return 0
scoreboard players set @a oa.stats 0
scoreboard players set @a oa.admin 0
scoreboard players enable @a oa.return
scoreboard players enable @a oa.stats
scoreboard players enable @a oa.admin''')
# Single OP bootstrap; all subsequent controls are clickable /trigger entries.
fn('admin','''execute unless entity @s[type=minecraft:player] run return 0
tag @s add br.admin
tag @s add br.host
function oa:admin/defaults
scoreboard players enable @s oa.admin
function oa:admin/menu''')
fn('admin/defaults','execute unless data storage oa:br border_restore run data modify storage oa:br border_restore set value {x:0,z:0,damage:0.2}')
entries=[(2,'準備状況'),(3,'現在地を基準にマップ生成（観戦へ変更）'),(4,'現在地にロビー作成'),(5,'ソロ開始'),(6,'チーム開始'),(7,'試合中止'),(8,'累計ランキング全消去'),(9,'木のバットを入手'),(10,'ノックバック棒を入手'),(11,'生成停止'),(12,'生成再開'),(13,'マップ全面再生成'),(14,'ロビー再建'),(15,'自分の統計')]
menu=['tellraw @s {text:"OA管理メニュー｜生成・再建は範囲を上書きします",color:"gold"}']
for i,t in entries:menu.append('tellraw @s '+json.dumps([{'text':f'[{i}] {t}','color':'red' if i in [3,4,8,13,14] else 'aqua','click_event':{'action':'run_command','command':f'/trigger oa.admin set {i}'}}],ensure_ascii=False,separators=(',',':')))
fn('admin/menu','\n'.join(menu))
dispatch=['execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"管理者未登録です。OPが初回だけ /function oa:admin を実行してください。",color:"red"}','execute if score @s oa.admin matches 1 run function oa:admin/menu','execute if score @s oa.admin matches 2 run function oa:admin/status']
actions={3:'admin/generate',4:'lobby/create',5:'br/start_solo',6:'br/start_team',7:'br/finish',8:'stats/reset',9:'give/bat',10:'give/stick',11:'oa_map:pause',12:'oa_map:resume',13:'oa_map:rebuild',14:'lobby/upgrade',15:'stats/personal'}
for n,f in actions.items():
 ref=f if ':' in f else 'oa:'+f
 dispatch.append(f'execute if score @s oa.admin matches {n} run function {ref}')
fn('admin/dispatch','\n'.join(dispatch));fn('admin/generate','execute unless score #state br.state matches 0 run return 0\ngamemode spectator @s\nfunction oa_map:start')
status=['tellraw @s {text:"OA準備チェック",color:"gold"}']
for path,label in [('center','BR中心'),('border_restore','基本設定')]:
 for exists,col,msg in [(True,'green','登録済み'),(False,'red','未登録')]:status.append(f'execute {"if" if exists else "unless"} data storage oa:br {path} run tellraw @s '+json.dumps({'text':label+'：'+msg,'color':col},ensure_ascii=False,separators=(',',':')))
for exists,col,msg in [(True,'green','登録済み'),(False,'red','未登録')]:status.append(f'execute {"if" if exists else "unless"} data storage oa:lobby origin{{ready:1b}} run tellraw @s '+json.dumps({'text':'ロビー：'+msg,'color':col},ensure_ascii=False,separators=(',',':')))
status+=['function oa_map:status','scoreboard players set #ready_n oa.tmp 0','execute as @a[tag=br.lobby] run scoreboard players add #ready_n oa.tmp 1','tellraw @s [{text:"参加登録人数：",color:"aqua"},{score:{name:"#ready_n",objective:"oa.tmp"}},{text:"／試合状態："},{score:{name:"#state",objective:"br.state"}},{text:" (0待機/1試合/2清掃/3演出)"}]','execute if entity @a[tag=br.lobby,scores={br.pick=0}] run tellraw @s {text:"チーム未選択の参加者がいます（ソロは選択不要）。",color:"yellow"}','tellraw @s {text:"クライアントのリソースパック適用はサーバーから自動確認できません。表示を確認してください。",color:"gray"}']
fn('admin/status','\n'.join(status))
# Lobby-only movement and combat feedback, separate from match statistics.
fn('lobby/social_fx','''execute if score @s oa.r_walk > @s oa.lfxw run particle minecraft:end_rod ~ ~0.15 ~ 0.2 0.05 0.2 0.005 2 normal @a[distance=..20]
execute if score @s oa.r_dd > @s oa.lfxd run particle minecraft:enchanted_hit ~ ~1 ~ 0.5 0.5 0.5 0.03 12 normal @a[distance=..20]
execute if score @s oa.r_dt > @s oa.lfxt run particle minecraft:happy_villager ~ ~1 ~ 0.4 0.5 0.4 0 8 normal @a[distance=..20]
scoreboard players operation @s oa.lfxw = @s oa.r_walk
scoreboard players operation @s oa.lfxd = @s oa.r_dd
scoreboard players operation @s oa.lfxt = @s oa.r_dt''')
add('lobby/tick','execute if score #clock oa.beat matches 0 as @a[tag=br.lobby_now] at @s run function oa:lobby/social_fx\nexecute if score #clock oa.beat matches 0 run function oa:lobby/protect_exhibits')
fn('lobby/protect_exhibits','''execute as @e[tag=oa.lobby_exhibit] run data merge entity @s {Invulnerable:1b,invulnerable:1b}
execute as @e[type=minecraft:mannequin,tag=oa.lobby_exhibit] run effect give @s minecraft:resistance 2 4 true
execute as @e[type=minecraft:mannequin,tag=oa.lobby_exhibit] run effect give @s minecraft:fire_resistance 2 0 true
execute as @e[type=minecraft:mannequin,tag=oa.lobby_exhibit] run effect give @s minecraft:instant_health 1 10 true''')
# More team/start visuals, still only on an actual selection/countdown event.
for n in range(1,11):add(f'br/team/{n}','particle minecraft:firework ~ ~1 ~ 0.7 0.8 0.7 0.04 20 normal @a[distance=..24]\nplaysound minecraft:entity.firework_rocket.twinkle player @s ~ ~ ~ 0.8 1.4')
for n in [1,2,3]:add(f'lobby/countdown_{n}','execute as @a[tag=br.lobby] at @s run particle minecraft:firework ~ ~1 ~ 0.8 1 0.8 0.03 20 normal @a[distance=..24]')
# Move display center down three, set eight block plane, repaint frame.
p=F/'lobby/build.mcfunction';s=p.read_text().replace('~0.5 ~8.5 ~34.8','~0.5 ~5.5 ~34.8').replace('"scale":[6.0,6.0,1.0]','"scale":[8.0,8.0,1.0]').replace('fill ~-4 ~4 ~36 ~4 ~12 ~36','fill ~-5 ~0 ~36 ~5 ~11 ~36').replace('fill ~-3 ~5 ~35 ~3 ~11 ~35','fill ~-4 ~1 ~35 ~4 ~10 ~35').replace('~0.5 ~13.2 ~34','~0.5 ~12.2 ~34').replace('~0.5 ~3 ~33','~0.5 ~0.4 ~33').replace('BR MAP｜上：南・海／下：北・山岳\\n左：東・森／右：西・市街地','BR MAP｜北：山岳・雪／東：森\\n西：市街地／南：海・港')
# Once-only blank guard stops native exhibitions taking damage before the first tick.
s += '\nfunction oa:lobby/protect_exhibits\n'
for x in [-36,-24,24,36]:
 for z in range(-32,33,8):s+=f'setblock ~{x} ~-1 ~{z} minecraft:sea_lantern\n'
s+='summon minecraft:text_display ~0 ~3 ~-37 {Tags:["oa.lobby_label"],text:{text:"OA累計ランキング\\n待機中はサイドバーで7項目を順番に表示\\n自分の統計：/trigger oa.stats\\n観戦から戻る：/trigger oa.return",color:"aqua"},billboard:"center",background:0}\n';p.write_text(s)
# Current docs are rewritten later by package stage.
print('Runtime changes written')
