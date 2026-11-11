from pathlib import Path
import json,re,copy
P=Path('revision/pack');F=P/'data/oa/function'
def w(n,s):
 p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n')
def edit(n,old,new):
 p=F/(n+'.mcfunction');s=p.read_text();assert old in s,(n,old);p.write_text(s.replace(old,new))
def pre(n,s):
 p=F/(n+'.mcfunction');p.write_text(s+'\n'+p.read_text())
def add(n,s):
 p=F/(n+'.mcfunction');p.write_text(p.read_text()+'\n'+s+'\n')
def j(path,d):
 p=P/'data/oa'/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
# Permission and session gates. Flags are personal and only applied while idle.
opts=[('cd','CT制限','free_cd'),('unique','固有装備1個制限','multi'),('match','試合中・生存者限定','free_match'),('grace','保護期間の使用制限','free_grace'),('team','味方へのスキル無効','friendly'),('consume','OA消耗品の消費','infinite'),('wear','帽子・マスクの時間消耗','keepwear'),('bind','キリングの取り外し禁止','unbind'),('mobs','モブも標的にする','mobs'),('heal','ロビー自動回復','heal')]
w('debug/start','''execute unless entity @s[tag=br.admin] run return 0
execute unless score #state br.state matches 0 run return run tellraw @s {text:"デバッグは試合待機中のみ開始できます。",color:"red"}
execute if entity @s[tag=oa.debug] run return run function oa:debug/book
execute unless entity @s[tag=oa.player] run tag @s add oa.db_newplayer
function oa:test/join
tag @s add oa.debug
scoreboard players operation @s oa.db_seen = @s oa.left
'''+''.join(f'scoreboard players set @s oa.db_{key} {1 if key=="mobs" else 0}\n' for key,_,_ in opts)+'''function oa:debug/apply
function oa:debug/book
tellraw @s {text:"デバッグ開始：本人のみ制限解除。設定は専用ブックへ。",color:"aqua"}''')
w('debug/apply','\n'.join(f'tag @s remove oa.db_{tag}\nexecute if score @s oa.db_{key} matches {1 if key in ["mobs","heal"] else 0} run tag @s add oa.db_{tag}' for key,_,tag in opts))
w('debug/stop','''execute unless entity @s[tag=oa.debug] run return 0
function oa:furoball/clear_up
function oa:tayayuyu/clear
function oa:test/reset
function oa:debug/items_restore
'''+ '\n'.join(f'tag @s remove oa.db_{tag}' for _,_,tag in opts)+'''
tag @s remove oa.debug
execute if entity @s[tag=oa.db_newplayer] run tag @s remove oa.player
tag @s remove oa.db_newplayer
clear @s *[minecraft:custom_data~{oa_debug_book:1b}]
tellraw @s {text:"デバッグ終了。通常の制限へ戻しました。複数の固有装備は通常判定で余剰分を地面へ返します。",color:"green"}''')
w('debug/tick','''execute unless entity @s[tag=br.admin] run return run function oa:debug/stop
execute unless score #state br.state matches 0 run return run function oa:debug/stop
execute unless score @s oa.db_seen = @s oa.left run return run function oa:debug/stop
execute if entity @s[nbt={Health:0.0f}] run return run function oa:debug/stop
execute if entity @s[tag=oa.db_free_cd] run scoreboard players set @s oa.cd 0
execute if entity @s[tag=oa.db_mobs] at @s as @e[type=#oa:arena_mobs,tag=!oa.lobby_exhibit,tag=!oa.debug_mob,distance=..48,nbt=!{Invulnerable:1b},nbt=!{Health:0.0f}] run function oa:debug/mob/init
function oa:debug/items_tick''')
w('debug/mob/init','''execute unless data entity @s Health run return 0
execute unless score @s oa.id matches 1.. run function oa:internal/id
tag @s add oa.debug_mob
scoreboard players set @s oa.team 0
scoreboard players set @s oa.hop 0
scoreboard players set @s oa.hoparc 0
scoreboard players set @s oa.root 0
scoreboard players set @s oa.bleed 0''')
w('debug/world','''execute as @e[tag=oa.debug_mob] at @s run function oa:debug/mob/tick''')
w('debug/mob/tick','''execute if entity @s[nbt={Health:0.0f}] run return run function oa:debug/mob/cleanup
execute unless entity @a[tag=oa.debug,distance=..64] run return run function oa:debug/mob/cleanup
function oa:status/tick
function oa:hotchikisu/status_dispatch
execute if entity @s[tag=oa.gacha_affected] run function oa:tayayuyu/tick
execute if score @s oa.kpush matches 1.. run function oa:knockback/tick''')
w('debug/mob/cleanup','''function oa:status/reset
function oa:hotchikisu/status_cleanup
function oa:tayayuyu/clear
tag @s remove oa.debug_mob''')
w('debug/spawn_target','''execute unless entity @s[tag=oa.debug,tag=br.admin] run return 0
execute positioned ^ ^ ^4 summon minecraft:cow run function oa:debug/target_init''')
w('debug/target_init','''tag @s add oa.debug_spawned
data merge entity @s {NoAI:1b,PersistenceRequired:1b,Silent:1b,CustomName:{text:"デバッグ標的",color:"aqua"},CustomNameVisible:1b}
attribute @s minecraft:max_health base set 100
data merge entity @s {Health:100.0f}
function oa:debug/mob/init''')
w('debug/spawn_attacker','''execute unless entity @s[tag=oa.debug,tag=br.admin] run return 0
execute positioned ^ ^ ^4 summon minecraft:husk run function oa:debug/attacker_init''')
w('debug/attacker_init','''tag @s add oa.debug_spawned
data merge entity @s {PersistenceRequired:1b,CustomName:{text:"反撃テスト用ハスク",color:"red"},CustomNameVisible:1b}
function oa:debug/mob/init''')
w('debug/clear_targets','''execute unless entity @s[tag=oa.debug,tag=br.admin] run return 0
execute as @e[tag=oa.debug_spawned,distance=..64] at @s run function oa:br/world/remove_mob''')
w('debug/dispatch','''execute unless entity @s[tag=br.admin] run return 0
execute if score @s oa.debug_cmd matches 1 run return run function oa:debug/start
execute unless entity @s[tag=oa.debug] run return run tellraw @s {text:"先に管理ブックからデバッグを開始してください。",color:"yellow"}
execute if score @s oa.debug_cmd matches 2 run return run function oa:debug/stop
execute if score @s oa.debug_cmd matches 3 run return run function oa:debug/book
execute if score @s oa.debug_cmd matches 4 run function oa:test/reset
execute if score @s oa.debug_cmd matches 5 run function oa:debug/spawn_target
execute if score @s oa.debug_cmd matches 6 run function oa:debug/spawn_attacker
execute if score @s oa.debug_cmd matches 7 run function oa:debug/clear_targets
'''+ '\n'.join(f'execute if score @s oa.debug_cmd matches {100+i} run function oa:debug/toggle_{key}' for i,(key,_,_) in enumerate(opts))+'''
execute if score @s oa.debug_cmd matches 100..109 run function oa:debug/apply
execute if score @s oa.debug_cmd matches 100..109 run function oa:debug/items_restore
execute if score @s oa.debug_cmd matches 100..109 run function oa:debug/book''')
for key,_,_ in opts:w('debug/toggle_'+key,f'''scoreboard players add @s oa.db_{key} 1
execute if score @s oa.db_{key} matches 2.. run scoreboard players set @s oa.db_{key} 0''')
add('load','\n'.join(['scoreboard objectives add oa.debug_cmd trigger','scoreboard objectives add oa.db_seen dummy']+[f'scoreboard objectives add oa.db_{key} dummy' for key,_,_ in opts]))
pre('tick','execute as @a[tag=oa.debug] at @s run function oa:debug/tick')
add('public/tick','''execute as @a[scores={oa.debug_cmd=1..}] at @s run function oa:debug/dispatch
scoreboard players set @a oa.debug_cmd 0
scoreboard players enable @a[tag=br.admin] oa.debug_cmd''')
add('world_tick','function oa:debug/world')
# Stop before inventory backup, all online administrators; offline tags are cleared at login / load.
pre('br/start','execute as @a[tag=oa.debug] at @s run function oa:debug/stop')
pre('internal/rejoin','execute if entity @s[tag=oa.debug] run function oa:debug/stop')
add('load','execute as @a[tag=oa.debug] at @s run function oa:debug/stop')
# Personal restriction gates: only tagged debug administrator gets bypasses.
for name in ['skill','lazi/sonic','yuttari/use','hotchikisu/use','komame/use','tayayuyu/use','nero/mark_or_return','nero/return','nero/decoy','furoball/use']:
 p=F/(name+'.mcfunction');s=p.read_text()
 s=s.replace('execute if score @s oa.cd matches 1..','execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1..')
 s=s.replace('execute if entity @s[tag=br.pvp_grace]','execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace]')
 s=s.replace('execute unless score #state br.state matches 1','execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1')
 s=s.replace('execute unless entity @s[tag=br.alive','execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=br.alive')
 p.write_text(s)
# Debug own timers must continue outside a match.
for name in ['furoball/up_tick','tayayuyu/tick']:
 p=F/(name+'.mcfunction');s=p.read_text().replace('execute unless entity @s[tag=br.alive','execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=oa.debug_mob] unless entity @s[tag=br.alive').replace('execute unless score #state br.state matches 1','execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1');p.write_text(s)
# Lobby comfort and pads do not override debug damage tests or accidentally start a match.
pre('lobby/comfort','execute if entity @s[tag=oa.debug,tag=!oa.db_heal] run return 0')
pre('lobby/host_tick','execute if entity @s[tag=oa.debug] run return 0')
# Unlimited inventory: scan every slot for models/lore without owning or dropping extras.
scan=[]
slots=[f'hotbar.{i}' for i in range(9)]+[f'inventory.{i}' for i in range(27)]+['weapon.offhand','armor.head','armor.chest','armor.legs','armor.feet']
for slot in slots:
 scan.append(f'execute if items entity @s {slot} *[minecraft:custom_data~{{oa:{{unique:1b}}}}] run function oa:debug/scan_slot {{slot:"{slot}"}}')
w('debug/inventory','scoreboard players set @s oa.have 0\n'+'\n'.join(scan)+'\n# Head items are equipped manually while multi-carry is enabled.\n')
w('debug/scan_slot','''$function oa:inventory/lore {slot:"$(slot)"}
$function oa:inventory/visual {slot:"$(slot)"}
scoreboard players add @s oa.have 1''')
pre('inventory/check','execute if entity @s[tag=oa.db_multi] run return run function oa:debug/inventory')
edit('player_tick','execute if score @s oa.have matches 0 run function oa:ground/pick','execute if entity @s[tag=oa.db_multi] run function oa:ground/pick\nexecute unless entity @s[tag=oa.db_multi] if score @s oa.have matches 0 run function oa:ground/pick')
# Head-item right click uses existing consumable equipment action, multi-carry leaves it manual.
# Target context: regular sessions keep existing player lists; debug targets use mobs + consenting debug players.
add('combat/select_targets','execute if entity @s[tag=oa.debug] run function oa:debug/select_targets')
w('debug/select_targets','''tag @e[tag=oa.target] remove oa.target
execute if entity @s[tag=oa.db_mobs] run tag @e[tag=oa.debug_mob,distance=..48,nbt=!{Health:0.0f}] add oa.target
execute as @a[tag=oa.debug,tag=!oa.caster,gamemode=!spectator,distance=..48] run tag @s add oa.target
execute unless entity @s[tag=oa.db_friendly] as @e[tag=oa.target] if score #team oa.team matches 1.. if score @s oa.team = #team oa.team run tag @s remove oa.target''')
# Generalize ONLY explicitly temporary target tags, never broad @a.
for p in F.rglob('*.mcfunction'):
 if p.parts[-2]=='source':continue
 s=p.read_text();t=s
 for tag in ['oa.target','oa.damage_target','oa.chosen','oa.staple_range','oa.hat_victim','oa.bleed_target']:
  t=t.replace('@a[tag='+tag,'@e[tag='+tag)
 if s!=t:p.write_text(t)
# Assign stable ids to mobs once; shared root/knockback/bleed already use these ids.
# Native melee requirements are broadened only when attacker is a debugger with mob targeting enabled.
def entity_cond(entity,tag):return {'type':'minecraft:entity_properties','entity':entity,'predicate':{'minecraft:nbt':'{Tags:["'+tag+'"]}'}}
for n,fn in [('fish','fish/hit'),('komame','komame/hit'),('staple','hotchikisu/melee_hit')]:
 p=P/'data/oa/enchantment'/f'{n}.json';d=json.loads(p.read_text())
 for e in d['effects']['minecraft:post_attack']:
  branch={'type':'minecraft:all_of','terms':[entity_cond('attacker','oa.db_mobs'),entity_cond('this','oa.debug_mob')]}
  e['requirements']={'type':'minecraft:any_of','terms':[e['requirements'],branch]}
 j('enchantment/'+n+'.json',d)
# Fish hop and stapler status work on living entities; the native callback is unchanged.
# Return private root effects from mobs when tests finish.
# Yuua outgoing melee on mobs and counter from mobs: debug-only native hooks.
p=P/'data/oa/enchantment/hat.json';d=json.loads(p.read_text())
d['effects']['minecraft:post_attack'].append({'enchanted':'attacker','affected':'victim','effect':{'type':'minecraft:run_function','function':'oa:debug/hat_hit'},'requirements':{'type':'minecraft:all_of','terms':[entity_cond('attacker','oa.db_mobs'),entity_cond('this','oa.debug_mob')]}})
# Counter effect local source must be the debug holder, not any other player.
for e in d['effects']['minecraft:post_attack'][:2]:
 e['requirements']={'type':'minecraft:any_of','terms':[e['requirements'],{'type':'minecraft:all_of','terms':[entity_cond('attacker','oa.debug_mob'),entity_cond('this','oa.db_mobs')]}]}
# Wear is a native per-tick enchantment effect, so a score reset alone is insufficient.
for n,doc in [('hat',d),('curse',json.loads((P/'data/oa/enchantment/curse.json').read_text()))]:
 for e in doc.get('effects',{}).get('minecraft:tick',[]):
  e['requirements']={'type':'minecraft:all_of','terms':[e['requirements'],{'type':'minecraft:inverted','term':entity_cond('this','oa.db_keepwear')}]}
 j('enchantment/'+n+'.json',doc)
 if n=='curse':
  freed=copy.deepcopy(doc);freed['effects'].pop('minecraft:prevent_armor_change',None);j('enchantment/debug_curse.json',freed)
w('debug/hat_hit','''execute if entity @s[tag=oa.debug_mob] run damage @s 10000 oa:execution by @a[tag=oa.debug,tag=oa.db_mobs,sort=nearest,limit=1]''')
# Debug hat source is resolved using on attacker, preserving exact attribution.
w('debug/hat_hit','''tag @s add oa.db_hat_victim
execute on attacker run function oa:debug/hat_strike
tag @s remove oa.db_hat_victim''')
w('debug/hat_strike','damage @e[tag=oa.db_hat_victim,limit=1] 10000 oa:execution by @s')
edit('yuua/counter_prepare','tag @a remove oa.yuua_counter_source','tag @e remove oa.yuua_counter_source')
# Nero pop can already identify the responsible attacker; include debug mobs.
edit('nero/decoy_hit','execute on attacker if entity @s[type=minecraft:player]','execute on attacker if entity @s[type=minecraft:player]')
add('nero/decoy_hit','execute on attacker if entity @s[tag=oa.debug_mob] at @s run function oa:nero/blind_attacker')
# Debug victim attacking mob routes generic statuses via native enchantments.
# Native curse guard accepts a debug mob attacking the holder.
p=P/'data/oa/enchantment/curse.json';d=json.loads(p.read_text())
for e in d['effects'].get('minecraft:damage_immunity',[]):
 terms=e['requirements']['terms']
 for idx,t in enumerate(terms):
  if t.get('entity')=='attacker' and t.get('predicate',{}).get('minecraft:nbt')=='{Tags:["oa.player"]}':
   terms[idx]={'type':'minecraft:any_of','terms':[t,{'type':'minecraft:all_of','terms':[entity_cond('attacker','oa.debug_mob'),entity_cond('this','oa.db_mobs')]}]}
j('enchantment/curse.json',d);free=copy.deepcopy(d);free['effects'].pop('minecraft:prevent_armor_change',None);j('enchantment/debug_curse.json',free)
# All pending debug items are fixed on exit even in unselected inventory slots.
j('item_modifier/debug/unbind.json',{'type':'minecraft:set_enchantments','enchantments':{'oa:curse':0,'oa:debug_curse':1},'add':False})
j('item_modifier/debug/bind.json',{'type':'minecraft:set_enchantments','enchantments':{'oa:debug_curse':0,'oa:curse':1},'add':False})
edit('curse/tick','item modify entity @s armor.head oa:killing_wear','execute unless entity @s[tag=oa.db_keepwear] run item modify entity @s armor.head oa:killing_wear')
edit('curse/tick','function oa:curse/age with storage oa:args','execute unless entity @s[tag=oa.db_keepwear] run function oa:curse/age with storage oa:args')
# Refunding consumes through native use_remainder preserves the exact item and stack size.
w('debug/items_tick','''execute if entity @s[tag=oa.db_unbind] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run item modify entity @s armor.head oa:debug/unbind
execute unless entity @s[tag=oa.db_unbind] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run item modify entity @s armor.head oa:debug/bind
function oa:debug/hand {slot:"weapon.mainhand"}
function oa:debug/hand {slot:"weapon.offhand"}''')
w('debug/hand','''$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run function oa:debug/patch_hand {slot:"$(slot)"}
$execute if items entity @s $(slot) *[minecraft:custom_data~{br_heal:1b}] run function oa:debug/patch_hand {slot:"$(slot)"}
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:$(unused)}] run return 0'''.replace('\n$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:$(unused)}] run return 0',''))
# Buff selection is explicit, avoiding broad data-component matching with unrelated items.
add('debug/hand','\n'.join('$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:"'+n+'"}] run function oa:debug/patch_hand {slot:"$(slot)"}' for n in ['beer','doria','salmon','paimon','yuzupon','azuki']))
w('debug/patch_hand','''# Read exact components through a transient item display; never write Player NBT.
summon minecraft:item_display ~ ~ ~ {Tags:["oa.db_reader"]}
$item replace entity @e[type=minecraft:item_display,tag=oa.db_reader,limit=1] contents from entity @s $(slot)
data modify storage oa:debug_item item set from entity @e[type=minecraft:item_display,tag=oa.db_reader,limit=1] item
kill @e[type=minecraft:item_display,tag=oa.db_reader]
data modify storage oa:debug_item item.count set value 1
data remove storage oa:debug_item item.components."minecraft:use_remainder"
$data modify storage oa:debug_item slot set value "$(slot)"
execute if entity @s[tag=oa.db_infinite] run function oa:debug/remainder with storage oa:debug_item
$execute unless entity @s[tag=oa.db_infinite] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if entity @s[tag=oa.db_free_cd] if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s $(slot) oa:debug/remove_cooldown''')
w('debug/remainder','$item modify entity @s $(slot) {type:"minecraft:set_components",components:{"minecraft:use_remainder":$(item)}}')
j('item_modifier/debug/remove_remainder.json',{'type':'minecraft:set_components','components':{'!minecraft:use_remainder':{}}})
j('item_modifier/debug/remove_cooldown.json',{'type':'minecraft:set_components','components':{'!minecraft:use_cooldown':{}}})
j('item_modifier/debug/restore_furo_cooldown.json',{'type':'minecraft:set_components','components':{'minecraft:use_cooldown':{'seconds':1.0,'cooldown_group':'oa:furoball'}}})
w('debug/items_restore','\n'.join(f'function oa:debug/restore_slot {{slot:"{s}"}}' for s in slots))
w('debug/restore_slot','''$execute if items entity @s $(slot) *[minecraft:enchantments~[{enchantments:"oa:debug_curse"}]] run item modify entity @s $(slot) oa:debug/bind
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s $(slot) oa:debug/restore_furo_cooldown
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if items entity @s $(slot) *[minecraft:custom_data~{br_heal:1b}] run item modify entity @s $(slot) oa:debug/remove_remainder
'''+ '\n'.join('$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:"'+n+'"}] run item modify entity @s $(slot) oa:debug/remove_remainder' for n in ['beer','doria','salmon','paimon','yuzupon','azuki']))
add('overwork/used','execute if entity @s[tag=oa.db_infinite,gamemode=!creative] run function oa:give/overwork')
# Mark debug projectile origin so its owner settings, not global match state, govern lifetime.
add('furoball/spawn','') # inserted before transient tag cleanup below
p=F/'furoball/spawn.mcfunction';s=p.read_text().replace('tag @e[tag=oa.furo_new] remove oa.furo_new','execute if entity @s[tag=oa.debug] run tag @e[tag=oa.furo_new] add oa.db_projectile\ntag @e[tag=oa.furo_new] remove oa.furo_new');p.write_text(s)
for name in ['furoball/tick','furoball/carrier/tick']:
 p=F/(name+'.mcfunction');s=p.read_text().replace('execute unless score #state br.state matches 1','execute unless entity @s[tag=oa.db_projectile] unless score #state br.state matches 1');p.write_text(s)
edit('furoball/up','tag @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new] remove oa.furo_carrier_new','execute if entity @s[tag=oa.debug] run tag @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new] add oa.db_projectile\ntag @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new] remove oa.furo_carrier_new')
# Explosions/collision get the same debug target pool and source ownership.
w('debug/furo_targets','''tag @e[tag=oa.db_f_target] remove oa.db_f_target
execute as @a[tag=oa.debug] if score @s oa.id = #f_owner oa.tmp at @s run function oa:debug/furo_pool''')
w('debug/furo_pool','''execute if entity @s[tag=oa.db_mobs] run tag @e[tag=oa.debug_mob,distance=..64,nbt=!{Health:0.0f}] add oa.db_f_target
tag @a[tag=oa.debug,gamemode=!spectator,distance=..64] add oa.db_f_target''')
edit('furoball/step','execute as @a[tag=br.alive,tag=!br.pvp_grace,gamemode=!spectator,distance=..6]','execute unless entity @s[tag=oa.db_projectile] as @a[tag=br.alive,tag=!br.pvp_grace,gamemode=!spectator,distance=..6]')
edit('furoball/step','execute if score #f_hit oa.tmp matches 1','execute if entity @s[tag=oa.db_projectile] run function oa:debug/furo_targets\nexecute if entity @s[tag=oa.db_projectile] as @e[tag=oa.db_f_target,distance=..6] unless score @s oa.id = #f_owner oa.tmp run function oa:furoball/body\nexecute if score #f_hit oa.tmp matches 1')
edit('furoball/explode','execute as @a[tag=br.alive,tag=!br.pvp_grace,gamemode=!spectator,distance=..9]','execute unless entity @s[tag=oa.db_projectile] as @a[tag=br.alive,tag=!br.pvp_grace,gamemode=!spectator,distance=..9]')
edit('furoball/explode','tag @a remove oa.f_source\nkill @s','execute if entity @s[tag=oa.db_projectile] run function oa:debug/furo_targets\nexecute if entity @s[tag=oa.db_projectile] as @e[tag=oa.db_f_target,distance=..9] at @s run function oa:furoball/blast\ntag @e[tag=oa.db_f_target] remove oa.db_f_target\ntag @a remove oa.f_source\nkill @s')
# Bound tags for furoball victim and Yuttari queued movement must also allow a mob.
for name in ['furoball/push','furoball/save_push','knockback/start_yuttari','yuttari/save_origin','yuttari/use']:
 p=F/(name+'.mcfunction')
 if p.exists():p.write_text(p.read_text().replace('@a[tag=oa.f_victim','@e[tag=oa.f_victim').replace('@a[tag=oa.k_victim','@e[tag=oa.k_victim'))
# For mobs use native Motion for the immediate horizontal explosion, no per-tick TP loop.
pre('furoball/push','execute if entity @s[tag=oa.debug_mob] run return run function oa:debug/mob/blast_push')
w('debug/mob/blast_push','''execute store result storage oa:dbpush x double 1 run data get entity @s Pos[0]
# Native one-shot upward impulse for mobs; horizontal direction uses the existing safe push geometry.
data modify entity @s Motion[1] set value 0.45d''')
# Target protection can be ignored by an opted-in debug caster, not by a normal combatant.
edit('combat/gated_damage','execute if entity @s[tag=br.pvp_grace]','execute unless entity @a[tag=oa.caster,tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace]')
# Shared gacha debug path avoids touching normal lobby inventories and globals.
pre('tayayuyu/use','execute if entity @s[tag=oa.db_free_match] run return run function oa:debug/gacha/use')
w('debug/gacha/use','''execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 900
scoreboard players operation #gacha_caster oa.tmp = @s oa.id
scoreboard players add #serial oa.serial 1
scoreboard players operation #gacha_event oa.tmp = #serial oa.serial
execute store result score #gacha_roll oa.tmp run random value 1..16
function oa:combat/select_targets
tag @s add oa.target
tellraw @a[tag=oa.debug] [{text:"[ガチャテスト] 結果 ",color:"light_purple"},{score:{name:"#gacha_roll",objective:"oa.tmp"}}]
playsound minecraft:block.end_portal.spawn player @a[tag=oa.debug,distance=..32] ~ ~ ~ 1.2 1.5
particle minecraft:totem_of_undying ~ ~1 ~ 0.7 1 0.7 0.2 60 normal @a[distance=..48]
'''+ '\n'.join(f'execute if score #gacha_roll oa.tmp matches {i} run function oa:debug/gacha/{i}' for i in range(1,17))+'''
function oa:combat/finish''')
for i,fn in [(1,'health'),(2,'fire'),(3,'speed'),(5,'hop'),(12,'mood'),(13,'reveal')]:w(f'debug/gacha/{i}',f'execute as @e[tag=oa.target] at @s run function oa:tayayuyu/{fn}')
w('debug/gacha/4','tellraw @s {text:"復活：待機中には脱落者がいません。実際の復活は試合テストで確認してください。",color:"yellow"}')
w('debug/gacha/6','''execute as @a[tag=oa.target,sort=random,limit=1] at @s run function oa:tayayuyu/hat''')
w('debug/gacha/7','''execute as @e[tag=oa.target] at @s run function oa:debug/gacha/bomb''')
w('debug/gacha/bomb','''function oa:tayayuyu/bomb_spawn
tag @e[type=minecraft:block_display,tag=oa.gacha_bomb,distance=..1] add oa.db_projectile''')
for i,scale in [(8,-.5),(15,1.5)]:
 w(f'debug/gacha/{i}',f'execute as @e[tag=oa.target] at @s run function oa:debug/gacha/size_{i}')
 w(f'debug/gacha/size_{i}',f'''attribute @s minecraft:scale modifier remove oa:gacha_size
attribute @s minecraft:scale modifier add oa:gacha_size {scale} add_multiplied_total
scoreboard players set @s oa.gsize {300 if i==8 else 200}
tag @s add oa.gacha_size
tag @s add oa.gacha_affected''')
w('debug/gacha/9','''# Snapshot everyone first, then cycle through the fixed positions.
data modify storage oa:db_shuffle positions set value []
execute as @e[tag=oa.target] run data modify storage oa:db_shuffle positions append from entity @s Pos
execute as @e[tag=oa.target] at @s run function oa:debug/gacha/shuffle_one''')
w('debug/gacha/shuffle_one','''data modify storage oa:db_shuffle dest set from storage oa:db_shuffle positions[-1]
function oa:debug/gacha/tp_list with storage oa:db_shuffle
data remove storage oa:db_shuffle positions[-1]''')
w('debug/gacha/tp_list','$tp @s $(dest)') # replaced below with coordinate macro extraction
w('debug/gacha/shuffle_one','''data modify storage oa:db_shuffle args.x set from storage oa:db_shuffle positions[-1][0]
data modify storage oa:db_shuffle args.y set from storage oa:db_shuffle positions[-1][1]
data modify storage oa:db_shuffle args.z set from storage oa:db_shuffle positions[-1][2]
function oa:debug/gacha/tp_list with storage oa:db_shuffle args
data remove storage oa:db_shuffle positions[-1]''')
w('debug/gacha/tp_list','$tp @s $(x) $(y) $(z)')
w('debug/gacha/10','''execute as @e[tag=oa.target,tag=!oa.caster] run tp @s ~ ~ ~
execute as @e[tag=oa.target] run effect give @s minecraft:resistance 3 4 true''')
w('debug/gacha/11','execute as @e[tag=oa.target] run effect give @s minecraft:resistance 5 4 true')
w('debug/gacha/14','execute as @a[tag=oa.target] run effect give @s minecraft:hunger 10 0 true')
w('debug/gacha/16','function oa:tayayuyu/intro')
edit('tayayuyu/bomb_tick','execute unless score #state br.state matches 1','execute unless entity @s[tag=oa.db_projectile] unless score #state br.state matches 1')
edit('tayayuyu/bomb_explode','execute positioned ~0.5 ~0.5 ~0.5 as @a[tag=br.alive','execute unless entity @s[tag=oa.db_projectile] positioned ~0.5 ~0.5 ~0.5 as @a[tag=br.alive')
edit('tayayuyu/bomb_explode','tag @a remove oa.g_source\nkill @s','execute if entity @s[tag=oa.db_projectile] positioned ~0.5 ~0.5 ~0.5 as @e[tag=oa.debug_mob,distance=..4] run damage @s 6 minecraft:explosion\nexecute if entity @s[tag=oa.db_projectile] positioned ~0.5 ~0.5 ~0.5 as @a[tag=oa.debug,distance=..4] at @s run function oa:tayayuyu/bomb_prepare\ntag @a remove oa.g_source\nkill @s')
# The main branch still selects players only; no mob tag is ever added to a player or exhibit.
# New book entry.
add('admin/dispatch','execute if score @s oa.admin matches 40 run function oa:debug/start\nexecute if score @s oa.admin matches 41 run function oa:debug/book')
# Bump only live metadata and documentation; historical build scripts stay historical.
for p in P.rglob('*'):
 if p.suffix in ['.mcfunction','.mcmeta','.md']:
  s=p.read_text();t=s.replace('1.8.7','1.9.0')
  if s!=t:p.write_text(t)
