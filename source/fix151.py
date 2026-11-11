from pathlib import Path
import json,re,shutil,zipfile
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';F=P/'data/oa/function';O=R/'release_1_5_1'
def fn(n,s):p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n')
def add(n,s):
 with (F/(n+'.mcfunction')).open('a') as f:f.write('\n'+s.strip()+'\n')
add('load','scoreboard objectives add br.tp_ok dummy\nscoreboard objectives add oa.batcool dummy\nscoreboard objectives add oa.proj dummy\nscoreboard objectives add oa.powner dummy')
# Validate and cache every destination before inventory/game-state mutation.
fn('br/cache_spawn','''tag @e[tag=br.spawn] remove br.plan_source
$execute if score #mode br.mode matches 0 run tag @e[tag=br.spawn,scores={oa.id=$(id)},limit=1] add br.plan_source
'''+ '\n'.join(f'execute if score #mode br.mode matches 1 if score @s br.pick matches {i} run tag @e[tag=br.spawn,tag=br.team{i},limit=1] add br.plan_source' for i in range(1,11))+'''
execute unless entity @e[tag=br.plan_source] run scoreboard players set #spawn_ok br.flag 0
execute unless entity @e[tag=br.plan_source] run return 0
$data modify storage oa:spawn_plan p$(id) set value {}
$data modify storage oa:spawn_plan p$(id).x set from entity @e[tag=br.plan_source,limit=1] Pos[0]
$data modify storage oa:spawn_plan p$(id).y set from entity @e[tag=br.plan_source,limit=1] Pos[1]
$data modify storage oa:spawn_plan p$(id).z set from entity @e[tag=br.plan_source,limit=1] Pos[2]''')
fn('br/cache_player','execute store result storage oa:br_args id int 1 run scoreboard players get @s oa.id\nfunction oa:br/cache_spawn with storage oa:br_args')
fn('br/enter_tp','$function oa:br/tp_position with storage oa:spawn_plan p$(id)')
fn('br/tp_position','$execute in minecraft:overworld store success score @s br.tp_ok run tp @s $(x) $(y) $(z)')
p=F/'br/start.mcfunction';s=p.read_text();s=s.replace('# Preflight random safe locations','execute as @a[tag=br.lobby] unless score @s oa.id matches 1.. run function oa:internal/id\n# Preflight random safe locations');needle='execute if score #spawn_ok br.flag matches 0 run return run function oa:br/spawn_failed';s=s.replace(needle,'data modify storage oa:spawn_plan root set value {}\nexecute in minecraft:overworld as @a[tag=br.lobby] run function oa:br/cache_player\n'+needle);s=s.replace('execute as @a[tag=br.lobby] at @s run function oa:br/enter','execute as @a[tag=br.lobby] at @s run function oa:br/enter\nexecute if entity @a[tag=br.playing,scores={br.tp_ok=0}] run return run function oa:br/tp_abort');p.write_text(s)
fn('br/tp_abort','tellraw @a[tag=br.admin] {text:"配置TPに失敗したため開始を中止し、所持品を復元します。",color:"red"}\nfunction oa:br/finish\nexecute in minecraft:overworld run kill @e[tag=br.spawn]')
p=F/'br/enter.mcfunction';s=p.read_text();a=s.index('scoreboard players operation #pid oa.id');b=s.index('effect give @s minecraft:resistance 61',a);s=s[:a]+'''scoreboard players set @s br.tp_ok 0
execute store result storage oa:br_args id int 1 run scoreboard players get @s oa.id
function oa:br/enter_tp with storage oa:br_args
'''+s[b:];s+='''
tag @s remove br.login_pending
scoreboard players operation @s br.login_epoch = #epoch br.login_epoch
scoreboard players add @s br.login_leave 0
scoreboard players operation @s br.login_seen = @s br.login_leave
''';p.write_text(s)
p=F/'lobby/login_warp.mcfunction';s=p.read_text();s='execute if entity @s[tag=br.playing,tag=br.alive] run return run tag @s remove br.login_pending\n'+s;p.write_text(s)
# Charged knockback is conditional; post-hit cooldown persists through weapon swaps.
for p in (P/'data/oa/loot_table/br').rglob('*.json'):
 v=json.loads(p.read_text());changed=False
 for po in v.get('pools',[]):
  for e in po.get('entries',[]):
   for m in e.get('modifier',[]):
    c=m.get('components',{})
    if c.get('minecraft:custom_data',{}).get('oa_normal')=='bat':c.get('minecraft:enchantments',{}).pop('minecraft:knockback',None);changed=True
 if changed:p.write_text(json.dumps(v,ensure_ascii=False,indent=2))
p=P/'data/oa/enchantment/bat.json';v=json.loads(p.read_text());v['effects']['minecraft:knockback']=[{'effect':{'type':'minecraft:add','value':4},'requirements':{'type':'minecraft:entity_properties','entity':'attacker','predicate':{'minecraft:nbt':'{Tags:["oa.bat_ready"]}'}}}];v['effects']['minecraft:post_attack'].append({'enchanted':'attacker','affected':'attacker','effect':{'type':'minecraft:run_function','function':'oa:normal/bat_cooldown'}});p.write_text(json.dumps(v,ensure_ascii=False,indent=2))
fn('normal/bat_cooldown','scoreboard players set @s oa.batcool 25\ntag @s remove oa.bat_ready')
p=P/'data/oa/item_modifier/bat_visual.json';v=json.loads(p.read_text());v['functions'] += [{'type':'minecraft:set_enchantments','enchantments':{'minecraft:knockback':0},'add':False},{'type':'minecraft:set_custom_data','tag':'{oa_bat_v151:1b}'}];p.write_text(json.dumps(v,indent=2))
p=F/'normal/visual_tick.mcfunction';p.write_text(p.read_text().replace('oa_bat_v150','oa_bat_v151'))
fn('normal/bat_clock','scoreboard players add @a oa.batcool 0\nscoreboard players remove @a[scores={oa.batcool=1..}] oa.batcool 1\ntag @a[scores={oa.batcool=0}] add oa.bat_ready\ntag @a[scores={oa.batcool=1..}] remove oa.bat_ready')
p=F/'tick.mcfunction';p.write_text('function oa:normal/bat_clock\n'+p.read_text())
# Observe unmodified vanilla projectiles, and only infer optional hit extras AFTER disappearance.
add('world_tick','function oa:throwable/observe/world')
fn('throwable/observe/world','''execute unless score #state br.state matches 1 run return run kill @e[tag=oa.throw_observer]
execute as @e[type=minecraft:snowball,tag=!oa.throw_observed] at @s run function oa:throwable/observe/init
execute as @e[type=minecraft:egg,tag=!oa.throw_observed] at @s run function oa:throwable/observe/init
execute as @e[type=minecraft:marker,tag=oa.throw_observer] at @s run function oa:throwable/observe/tick''')
fn('throwable/observe/init','''scoreboard players add #proj_seq oa.proj 1
scoreboard players operation @s oa.proj = #proj_seq oa.proj
tag @s add oa.throw_observed
scoreboard players set #throw_owner oa.tmp 0
execute on origin if entity @s[type=minecraft:player,tag=br.alive] run scoreboard players operation #throw_owner oa.tmp = @s oa.id
execute if score #throw_owner oa.tmp matches 0 run return 0
summon minecraft:marker ~ ~ ~ {Tags:["oa.throw_observer","oa.throw_new"]}
scoreboard players operation @e[tag=oa.throw_new,limit=1] oa.proj = @s oa.proj
scoreboard players operation @e[tag=oa.throw_new,limit=1] oa.powner = #throw_owner oa.tmp
execute if entity @s[type=minecraft:snowball] run tag @e[tag=oa.throw_new] add oa.observe_snow
tag @e[tag=oa.throw_new] remove oa.throw_new''')
fn('throwable/observe/tick','execute store result storage oa:observe args.id int 1 run scoreboard players get @s oa.proj\nfunction oa:throwable/observe/find with storage oa:observe args')
fn('throwable/observe/find','''$execute if entity @e[tag=oa.throw_observed,scores={oa.proj=$(id)},limit=1] run return run function oa:throwable/observe/update {id:$(id)}
function oa:throwable/observe/impact
kill @s''')
fn('throwable/observe/update','''$execute at @e[tag=oa.throw_observed,scores={oa.proj=$(id)},limit=1] run tp @s ~ ~ ~
$data modify entity @s data.velocity set from entity @e[tag=oa.throw_observed,scores={oa.proj=$(id)},limit=1] Motion''')
fn('throwable/observe/impact','''execute unless data entity @s data.velocity run return 0
tag @a remove oa.observe_owner
scoreboard players operation #obs_owner oa.tmp = @s oa.powner
execute as @a[tag=br.alive,tag=!br.pvp_grace] if score @s oa.id = #obs_owner oa.tmp run tag @s add oa.observe_owner
execute unless entity @a[tag=oa.observe_owner] run return 0
scoreboard players operation #obs_team oa.team = @a[tag=oa.observe_owner,limit=1] oa.team
scoreboard players set #obs_snow oa.tmp 0
execute if entity @s[tag=oa.observe_snow] run scoreboard players set #obs_snow oa.tmp 1
scoreboard players set #hit oa.tmp 0
scoreboard players set #ray oa.tmp 20
scoreboard players set #twenty oa.tmp 20
execute store result score #mx oa.tmp run data get entity @s data.velocity[0] 10000
execute store result score #my oa.tmp run data get entity @s data.velocity[1] 10000
execute store result score #mz oa.tmp run data get entity @s data.velocity[2] 10000
scoreboard players operation #mx oa.tmp /= #twenty oa.tmp
scoreboard players operation #my oa.tmp /= #twenty oa.tmp
scoreboard players operation #mz oa.tmp /= #twenty oa.tmp
execute store result storage oa:throw_step x double 0.0001 run scoreboard players get #mx oa.tmp
execute store result storage oa:throw_step y double 0.0001 run scoreboard players get #my oa.tmp
execute store result storage oa:throw_step z double 0.0001 run scoreboard players get #mz oa.tmp
function oa:throwable/observe/ray
tag @a remove oa.observe_owner''')
ray=(F/'throwable/ray.mcfunction').read_text().replace('@a[tag=oa.target,tag=br.alive,','@a[tag=br.alive,tag=!oa.observe_owner,tag=!br.pvp_grace,tag=!oa.self_decoy,tag=!oa.decoy_grace,').replace('oa:throwable/body','oa:throwable/observe/body').replace('oa:throwable/ray','oa:throwable/observe/ray');fn('throwable/observe/ray',ray)
body=(F/'throwable/body.mcfunction').read_text().replace('oa:throwable/hit','oa:throwable/observe/hit');fn('throwable/observe/body','execute if score #obs_team oa.team matches 1.. if score @s oa.team = #obs_team oa.team run return 0\n'+body)
fn('throwable/observe/hit','''scoreboard players set #hit oa.tmp 1
execute if score #obs_snow oa.tmp matches 1 run function oa:throwable/chill
execute if score #obs_snow oa.tmp matches 0 run particle minecraft:crit ~ ~1 ~ 0.25 0.4 0.25 0.01 6 normal @a[distance=..24]''')
# Disable duplicate unreliable zero-damage advancement rewards.
for n in ['snowball','egg']:fn('throwable/native_'+n,f'advancement revoke @s only oa:throwable/{n}')
p=P/'README_JA.md';s=p.read_text().replace('約1.25秒間隔','約1.25秒間隔');s+='\n開始配置は変更前に全員分の座標を保存・検査し、TP失敗時は試合を中止して所持品を復元します。開始時の古いログイン待機フラグを消し、配置直後にロビーへ戻されないようにしています。\n木のバットの強い追加ノックバックは、前の命中から25tick（約1.25秒）以上待ったときだけ適用。連打中も通常の近接ヒットによる押し返しは残ります。\n雪玉・卵そのものの移動・衝突・消滅はバニラです。プレイヤーへの追加ダメージ・TP・飛び道具の手動消去は行いません。雪玉の鈍足／卵の追加粒子は、ネイティブ消滅を観測した後の直前軌道と当たり箱による補助推定です。完全なネイティブ命中イベントではなく、同時移動・壁際等は未検証。バニラの雪玉・卵はプレイヤーに通常ダメージ・ノックバックを与えません。\n';p.write_text(s)
for p in P.rglob('*'):
 if p.is_file() and p.suffix in ['.json','.mcmeta','.mcfunction','.md']:
  try:s=p.read_text()
  except UnicodeError:continue
  if '1.5.0' in s:p.write_text(s.replace('1.5.0','1.5.1'))
shutil.copyfile(__file__,P/'source/fix151.py')
for p in P.rglob('*.json'):json.loads(p.read_text())
for p in F.rglob('*.mcfunction'):
 for l in p.read_text().splitlines():
  if '$(' in l:assert l.startswith('$'),(p,l)
  m=re.search(r'(?:^\$?|\brun )function (oa(?:_map2|_map)?:[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,k=m[1].split(':',1);assert (P/f'data/{ns}/function/{k}.mcfunction').exists(),(p,m[1])
with zipfile.ZipFile(O/'OA_BattleRoyale_v1.5.1.zip','w',zipfile.ZIP_DEFLATED) as z:
 for p in P.rglob('*'):
  if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(P))
print('Packaged1.5.1; JSON/functions/macros static checks pass')
