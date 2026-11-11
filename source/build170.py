from pathlib import Path
import json,shutil,math
p=Path('revision/pack');f=p/'data/oa/function';o=Path('release_1_7_0');o.mkdir(exist_ok=True)
def w(path,s):path.parent.mkdir(parents=True,exist_ok=True);path.write_text(s)
def j(path,obj):w(path,json.dumps(obj,ensure_ascii=False,indent=2))
def add(path,s):w(path,path.read_text()+'\n'+s+'\n')
# A narrow temporary max-health cap makes instant health restore the requested amount,
# without writing player NBT or changing permanent base health/absorption.
w(f/'medical/heal.mcfunction','''execute if entity @s[nbt={Health:0.0f}] run return 0
execute store result score #med_hp oa.tmp run data get entity @s Health 1000
execute store result score #med_max oa.tmp run attribute @s minecraft:max_health get 1000
$scoreboard players add #med_hp oa.tmp $(milli)
execute if score #med_hp oa.tmp > #med_max oa.tmp run scoreboard players operation #med_hp oa.tmp = #med_max oa.tmp
scoreboard players operation #med_hp oa.tmp -= #med_max oa.tmp
execute store result storage oa:medical cap double 0.001 run scoreboard players get #med_hp oa.tmp
function oa:medical/cap with storage oa:medical
''')
w(f/'medical/cap.mcfunction','''attribute @s minecraft:max_health modifier remove oa:medical_cap
$attribute @s minecraft:max_health modifier add oa:medical_cap $(cap) add_value
effect give @s minecraft:instant_health 1 10 true
attribute @s minecraft:max_health modifier remove oa:medical_cap
''')
w(f/'medical/kit.mcfunction','''advancement revoke @s only oa:medical/kit
function oa:medical/heal {milli:10000}
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 0.8 1.2
particle minecraft:heart ~ ~1 ~ 0.3 0.4 0.3 0 6 normal @a[distance=..16]
''')
j(p/'data/oa/advancement/medical/kit.json',{'criteria':{'used':{'trigger':'minecraft:consume_item','conditions':{'item':{'predicates':{'minecraft:custom_data':{'br_heal_kind':2}}}}}},'rewards':{'function':'oa:medical/kit'}})
canonical={}
def medical_walk(obj):
 if isinstance(obj,dict):
  c=obj.get('components',{});d=c.get('minecraft:custom_data',{})
  if d.get('br_heal_kind') in [1,2]:
   kind=d['br_heal_kind'];c['minecraft:item_model']='oa:bandage' if kind==1 else 'oa:firstaid';d['medical_v170']=True
   if kind==2:
    c['minecraft:custom_name']['text']='応急キット';c['minecraft:consumable']['consume_seconds']=2.0;c['minecraft:consumable']['on_consume_effects']=[];c['minecraft:lore']=[{'text':'右クリックを2秒長押しして回復','color':'gray','italic':False}]
   canonical['heal'+str(kind)]=c
  if d.get('oa_buff'):
   typ=d['oa_buff'];d['medical_v170']=True
   for effect in c['minecraft:consumable']['on_consume_effects']:
    for eff in effect.get('effects',[]):
     if eff.get('duration')==100:eff['duration']=200
   if typ=='azuki':c['minecraft:consumable']['on_consume_effects'].append({'type':'minecraft:apply_effects','effects':[{'id':'minecraft:instant_health','duration':1,'amplifier':0,'show_particles':False,'show_icon':False}],'probability':1.0})
   for line in c.get('minecraft:lore',[]):line['text']=line.get('text','').replace('5秒','10秒')
   canonical[typ]=c
  for val in list(obj.values()):medical_walk(val)
 elif isinstance(obj,list):
  for val in obj:medical_walk(val)
for x in (p/'data/oa/loot_table').rglob('*.json'):
 data=json.loads(x.read_text());medical_walk(data);j(x,data)
for typ,c in canonical.items():j(p/f'data/oa/item_modifier/medical/{typ}.json',{'type':'minecraft:set_components','components':c})
s=''
for slot in ['weapon.mainhand','weapon.offhand']:
 for typ in canonical:
  pred='{br_heal_kind:'+typ[-1]+'}' if typ.startswith('heal') else '{oa_buff:"'+typ+'"}'
  s+=f'execute if items entity @s {slot} *[minecraft:custom_data~{pred}] unless items entity @s {slot} *[minecraft:custom_data~{{medical_v170:1b}}] run item modify entity @s {slot} oa:medical/{typ}\n'
w(f/'medical/upgrade.mcfunction',s);add(f/'normal/visual_tick.mcfunction','function oa:medical/upgrade')
add(f/'komame/health.mcfunction','function oa:medical/heal {milli:4000}')
# Extend vertical reach by one block via three overlapping radius-3 spheres.
x=f/'hotchikisu/use.mcfunction';s=x.read_text();s=s.replace('execute as @a[tag=oa.target,distance=..3,nbt=!{Health:0.0f}] at @s run function oa:hotchikisu/root_target','''tag @a remove oa.staple_range
execute positioned ~ ~-1 ~ run tag @a[tag=oa.target,distance=..3] add oa.staple_range
execute positioned ~ ~1 ~ run tag @a[tag=oa.target,distance=..3] add oa.staple_range
tag @a[tag=oa.target,distance=..3] add oa.staple_range
execute as @a[tag=oa.staple_range,nbt=!{Health:0.0f}] at @s run function oa:hotchikisu/root_target
tag @a remove oa.staple_range''');w(x,s)
# Ore recovery is additional to existing drops and rare yu roll.
x=f/'br/mining/reward.mcfunction';add(x,'''execute store result score #mine_recover br.tmp run random value 1..100
$execute if score #mine_recover br.tmp matches 1..25 run function oa:medical/mine_$(table)''')
w(f/'medical/mine_food.mcfunction','effect give @s minecraft:saturation 1 0 true\nparticle minecraft:happy_villager ~ ~1 ~ 0.2 0.3 0.2 0 5 normal @s\n')
w(f/'medical/mine_ore_medical.mcfunction','function oa:medical/heal {milli:2000}\nparticle minecraft:heart ~ ~1 ~ 0.2 0.3 0.2 0 3 normal @s\n')
# Ninth unique integrates with existing serial and single-unique inventory checks.
s=(f/'give/komame.mcfunction').read_text().replace('komame','tayayuyu');w(f/'give/tayayuyu.mcfunction',s)
s=(f/'give/internal/komame.mcfunction').read_text().replace('こまめ | 小豆バー','たやゆゆ | 変態ガチャ').replace('kind":8','kind":9').replace('oa:komame','oa:tayayuyu').replace('oa:melee_komame','oa:melee_tayayuyu').replace('oa:lore/k8','oa:lore/k9').replace('oa:komame_upgrade','oa:tayayuyu_upgrade');w(f/'give/internal/tayayuyu.mcfunction',s)
s=json.loads((p/'data/oa/enchantment/komame.json').read_text());s['description']={'text':'変態ガチャ'};s=json.loads(json.dumps(s).replace('oa:komame/hit','oa:tayayuyu/hit'));j(p/'data/oa/enchantment/tayayuyu.json',s)
j(p/'data/oa/item_modifier/melee_tayayuyu.json',json.loads((p/'data/oa/item_modifier/melee_komame.json').read_text()))
j(p/'data/oa/item_modifier/tayayuyu_upgrade.json',{'type':'minecraft:set_enchantments','enchantments':{'oa:tayayuyu':1},'add':False})
j(p/'data/oa/item_modifier/lore/k9.json',{'type':'minecraft:sequence','functions':[{'type':'minecraft:set_components','components':{'minecraft:lore':[{'text':'右クリック：全員に影響する7種のガチャ／CT45秒','color':'gray','italic':False},{'text':'通常攻撃：まれに相手を打ち上げる','color':'gray','italic':False}]}},{'type':'minecraft:set_custom_data','tag':'{oa:{lore_release1:1b}}'}]})
x=f/'player_tick.mcfunction';s=x.read_text().replace('execute unless score @s oa.kind = @s oa.old','execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] run scoreboard players set @s oa.kind 9\nexecute unless score @s oa.kind = @s oa.old');w(x,s)
add(f/'skill.mcfunction','execute if score @s oa.kind matches 9 run function oa:tayayuyu/use')
add(f/'inventory/lore.mcfunction','$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:9}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_release1:1b}}] run item modify entity @s $(slot) oa:lore/k9')
x=f/'br/loot/unique.mcfunction';s=x.read_text().replace('1..130','1..145').replace('11..130','11..145');s+='\nexecute if score #kind br.tmp matches 131..145 run function oa:give/internal/tayayuyu with storage oa:args\n';w(x,s)
add(f/'ground/fx.mcfunction','execute if data entity @s Item.components."minecraft:custom_data".oa{kind:9} run particle minecraft:dust{color:[0.25,0.95,0.25],scale:1.7} ~ ~0.5 ~ 0.35 0.2 0.35 0 8 normal @a[tag=oa.player,distance=..32]')
b=f/'tayayuyu'
w(b/'use.mcfunction','''execute if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute unless score #state br.state matches 1 run return run tellraw @s {text:"試合中に使用してください。",color:"yellow"}
execute unless entity @s[tag=br.alive] run return 0
execute if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 900
scoreboard players operation #gacha_caster oa.tmp = @s oa.id
scoreboard players add #serial oa.serial 1
scoreboard players operation #gacha_event oa.tmp = #serial oa.serial
execute store result score #gacha_roll oa.tmp run random value 1..7
playsound minecraft:block.end_portal.spawn player @a[tag=br.playing] ~ ~ ~ 1.2 1.5
particle minecraft:totem_of_undying ~ ~1 ~ 0.7 1 0.7 0.2 60 normal @a[distance=..48]
execute if score #gacha_roll oa.tmp matches 1 run function oa:tayayuyu/health_all
execute if score #gacha_roll oa.tmp matches 2 run function oa:tayayuyu/fire_all
execute if score #gacha_roll oa.tmp matches 3 run function oa:tayayuyu/speed_all
execute if score #gacha_roll oa.tmp matches 4 run function oa:tayayuyu/revive_all
execute if score #gacha_roll oa.tmp matches 5 run function oa:tayayuyu/hop_all
execute if score #gacha_roll oa.tmp matches 6 run function oa:tayayuyu/hat_all
execute if score #gacha_roll oa.tmp matches 7 run function oa:tayayuyu/bomb_all
''')
for name,label,command in [
 ('health_all','全員の最大体力＋20（15秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/health'),
 ('fire_all','全員に炎の呪い（8秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/fire'),
 ('speed_all','全員の移動速度＋50%（12秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/speed'),
 ('revive_all','脱落した参加者が復活','execute as @a[tag=br.playing,tag=!br.alive,nbt=!{Health:0.0f}] if score @s br.round = #round br.round at @s run function oa:tayayuyu/revive'),
 ('hop_all','全員ぴょんぴょん（20秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/hop'),
 ('bomb_all','全員の足元にTNT（2秒後）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/bomb_spawn')]:
  w(b/f'{name}.mcfunction',f'tellraw @a[tag=br.playing] {{text:"変態ガチャ：{label}",color:"green"}}\n'+command+'\n')
w(b/'health.mcfunction','''attribute @s minecraft:max_health modifier remove oa:gacha_hp
attribute @s minecraft:max_health modifier add oa:gacha_hp 20 add_value
scoreboard players set @s oa.ghp 300
function oa:medical/heal {milli:20000}
''')
w(b/'speed.mcfunction','''attribute @s minecraft:movement_speed modifier remove oa:gacha_speed
attribute @s minecraft:movement_speed modifier add oa:gacha_speed 0.5 add_multiplied_total
scoreboard players set @s oa.gspeed 240
''')
w(b/'fire.mcfunction','''scoreboard players set @s oa.gfire 160
scoreboard players operation @s oa.gby = #gacha_caster oa.tmp
''')
w(b/'fire_hit.mcfunction','''tag @a remove oa.g_source
scoreboard players operation #g_owner oa.tmp = @s oa.gby
execute as @a if score @s oa.id = #g_owner oa.tmp run tag @s add oa.g_source
execute if entity @a[tag=oa.g_source] run damage @s 1 minecraft:in_fire by @a[tag=oa.g_source,limit=1]
execute unless entity @a[tag=oa.g_source] run damage @s 1 minecraft:in_fire
tag @a remove oa.g_source
''')
w(b/'hop.mcfunction','function oa:fish/hit\nscoreboard players set @s oa.hop 400\n')
w(b/'hit.mcfunction','''execute if entity @s[tag=br.pvp_grace] run return 0
execute store result score #launch_roll oa.tmp run random value 1..10
execute unless score #launch_roll oa.tmp matches 1 run return 0
effect give @s minecraft:levitation 1 49 true
scoreboard players set @s oa.glift 2
particle minecraft:firework ~ ~0.2 ~ 0.4 0.1 0.4 0.1 24 normal @a[distance=..24]
playsound minecraft:entity.firework_rocket.launch player @a[distance=..24] ~ ~ ~ 1.2 1.4
''')
# Revival reuses safe inventory backup, entering and cleanup. Deliberate rule exception for gacha.
w(b/'revive.mcfunction','''execute unless score @s br.saved matches 1 run return 0
function oa:br/enter
execute if score #time br.time matches 1200.. run effect clear @s minecraft:resistance
execute if score #time br.time matches 1200.. run tag @s remove br.pvp_grace
execute if score #time br.time matches 1200.. run tag @s remove br.spawn_protection
execute if score #time br.time matches ..1199 run team join oa_brgrace @s
execute if score #time br.time matches ..1199 run tag @s add br.native_grace
give @s minecraft:stone_sword
function oa:internal/tp with storage oa:br center
scoreboard players add #serial oa.serial 1
execute store result storage oa:args serial int 1 run scoreboard players get #serial oa.serial
function oa:give/internal/killing with storage oa:args
function oa:tayayuyu/equip_mask with storage oa:args
particle minecraft:totem_of_undying ~ ~1 ~ 0.6 1 0.6 0.15 60 normal @a[distance=..40]
playsound minecraft:item.totem.use player @a[distance=..40] ~ ~ ~ 1.4 1
''')
w(b/'equip_mask.mcfunction','''$item replace entity @s armor.head from entity @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:5,serial:$(serial)}}}}},limit=1] contents
$kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:5,serial:$(serial)}}}}}]
''')
# Replace all loaded hats, returning any different unique and helmet intact to the ground.
slots=[f'hotbar.{i}' for i in range(9)]+[f'inventory.{i}' for i in range(27)]+['weapon.offhand','armor.head','armor.chest','armor.legs','armor.feet']
w(b/'hat_all.mcfunction','''tellraw @a[tag=br.playing] {text:"変態ガチャ：誰かにゆうあの帽子！",color:"light_purple"}
clear @a *[minecraft:custom_data~{oa:{kind:1}}]
execute in minecraft:overworld run kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:1}}}}}]
execute in minecraft:the_nether run kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:1}}}}}]
execute in minecraft:the_end run kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:1}}}}}]
execute as @a[tag=br.alive,sort=random,limit=1] at @s run function oa:tayayuyu/hat
''')
s='function oa:internal/cleanup\n'
for slot in slots:s+=f'execute if items entity @s {slot} *[minecraft:custom_data~{{oa:{{unique:1b}}}}] run function oa:inventory/drop {{slot:"{slot}"}}\n'
s+='''scoreboard players set #yuua_issued br.tmp 0
scoreboard players add #serial oa.serial 1
execute store result storage oa:args serial int 1 run scoreboard players get #serial oa.serial
function oa:give/internal/yuua with storage oa:args
function oa:tayayuyu/equip_hat with storage oa:args
''';w(b/'hat.mcfunction',s)
w(b/'equip_hat.mcfunction','''$tag @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:1,serial:$(serial)}}}}},limit=1] add oa.pick
function oa:ground/force_yuua
''')
w(b/'bomb_spawn.mcfunction','''summon minecraft:block_display ~-0.5 ~ ~-0.5 {Tags:["oa.gacha_bomb","oa.gacha_bomb_new"],block_state:{Name:"minecraft:tnt"},view_range:1.0}
scoreboard players set @e[tag=oa.gacha_bomb_new] oa.gbomb 40
scoreboard players operation @e[tag=oa.gacha_bomb_new] oa.gby = #gacha_caster oa.tmp
scoreboard players operation @e[tag=oa.gacha_bomb_new] oa.gevent = #gacha_event oa.tmp
tag @e[tag=oa.gacha_bomb_new] remove oa.gacha_bomb_new
playsound minecraft:entity.tnt.primed player @a[distance=..32] ~ ~ ~ 1 1
''')
w(b/'bomb_tick.mcfunction','''execute unless score #state br.state matches 1 run return run kill @s
scoreboard players remove @s oa.gbomb 1
particle minecraft:smoke ~0.5 ~1 ~0.5 0.1 0.1 0.1 0 1 normal @a[distance=..24]
execute if score @s oa.gbomb matches 0 run function oa:tayayuyu/bomb_explode
''')
w(b/'bomb_explode.mcfunction','''particle minecraft:explosion_emitter ~0.5 ~0.5 ~0.5 0 0 0 0 1 normal @a[distance=..48]
playsound minecraft:entity.generic.explode player @a[distance=..48] ~ ~ ~ 1.2 1
scoreboard players operation #g_owner oa.tmp = @s oa.gby
execute store result storage oa:gacha event int 1 run scoreboard players get @s oa.gevent
tag @a remove oa.g_source
execute as @a if score @s oa.id = #g_owner oa.tmp run tag @s add oa.g_source
execute positioned ~0.5 ~0.5 ~0.5 as @a[tag=br.alive,tag=!br.pvp_grace,distance=..4] at @s run function oa:tayayuyu/bomb_prepare
tag @a remove oa.g_source
kill @s
''')
w(b/'bomb_prepare.mcfunction','''execute store result storage oa:gacha victim int 1 run scoreboard players get @s oa.id
function oa:tayayuyu/bomb_damage with storage oa:gacha
''')
w(b/'bomb_damage.mcfunction','''$execute if data storage oa:gacha_hits e$(event).p$(victim) run return 0
$data modify storage oa:gacha_hits e$(event).p$(victim) set value 1b
execute if entity @a[tag=oa.g_source] run damage @s 6 minecraft:explosion by @a[tag=oa.g_source,limit=1]
execute unless entity @a[tag=oa.g_source] run damage @s 6 minecraft:explosion
''')
# Online status ticks do not depend on still holding the weapon; attacks already cast persist.
w(b/'tick.mcfunction','''execute unless entity @s[tag=br.alive,gamemode=!spectator] run return run function oa:tayayuyu/clear
scoreboard players remove @s[scores={oa.ghp=1..}] oa.ghp 1
execute if score @s oa.ghp matches 0 run attribute @s minecraft:max_health modifier remove oa:gacha_hp
scoreboard players remove @s[scores={oa.gspeed=1..}] oa.gspeed 1
execute if score @s oa.gspeed matches 0 run attribute @s minecraft:movement_speed modifier remove oa:gacha_speed
execute if score @s oa.gfire matches 160 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 140 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 120 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 100 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 80 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 60 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 40 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 20 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 1.. if score #vclock br.tmp matches 0 run particle minecraft:flame ~ ~0.7 ~ 0.3 0.6 0.3 0.01 8 normal @a[distance=..24]
scoreboard players remove @s[scores={oa.gfire=1..}] oa.gfire 1
scoreboard players remove @s[scores={oa.glift=1..}] oa.glift 1
execute if score @s oa.glift matches 0 if entity @s[tag=oa.gacha_lift] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:49}] run effect clear @s minecraft:levitation
execute if score @s oa.glift matches 0 run tag @s remove oa.gacha_lift
''')
add(b/'hit.mcfunction','tag @s add oa.gacha_lift')
w(b/'clear.mcfunction','''attribute @s minecraft:max_health modifier remove oa:gacha_hp
attribute @s minecraft:movement_speed modifier remove oa:gacha_speed
execute if entity @s[tag=oa.gacha_lift] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:49}] run effect clear @s minecraft:levitation
tag @s remove oa.gacha_lift
scoreboard players set @s oa.ghp 0
scoreboard players set @s oa.gspeed 0
scoreboard players set @s oa.gfire 0
scoreboard players set @s oa.glift 0
''')
add(f/'tick.mcfunction','execute as @a[tag=oa.player] at @s run function oa:tayayuyu/tick')
add(f/'world_tick.mcfunction','execute as @e[type=minecraft:block_display,tag=oa.gacha_bomb] at @s run function oa:tayayuyu/bomb_tick')
for name in ['br/enter','br/eliminate','br/restore']:add(f/(name+'.mcfunction'),'function oa:tayayuyu/clear')
for obj in ['oa.ghp','oa.gspeed','oa.gfire','oa.gby','oa.gbomb','oa.gevent','oa.glift']:add(f/'load.mcfunction',f'scoreboard objectives add {obj} dummy')
# Unloaded bombs are rejected after the round changes.
# Admin acquisition command and book entry.
add(f/'admin/dispatch.mcfunction','execute if score @s oa.admin matches 36 run function oa:give/tayayuyu')
x=f/'admin/book.mcfunction';s=x.read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',a);data=json.loads(s[a:e]);data['pages'].append({'raw':{'text':'新しい固有装備\n\n','extra':[{'text':'たやゆゆ | 変態ガチャ\n\n','color':'dark_green','underlined':True,'click_event':{'action':'run_command','command':'/trigger oa.admin set 36'}},{'text':'右クリックで7種のガチャ。\nCT45秒。試合中専用。','color':'black'}]}});s=s[:a]+json.dumps(data,ensure_ascii=False,separators=(',',':'))+s[e:];w(x,s.replace('book_v163','book_v170'))
# Copy the full RP source, not a patch pack.
r=o/'resourcepack';shutil.copytree('release_1_6_1/resourcepack',r,dirs_exist_ok=True)
for name in ['bandage','firstaid','tayayuyu']:
 j(r/f'assets/oa/items/{name}.json',{'model':{'type':'minecraft:model','model':f'oa:item/{name}'}})
 j(r/f'assets/oa/models/item/{name}.json',{'parent':'minecraft:item/handheld' if name=='tayayuyu' else 'minecraft:item/generated','textures':{'layer0':f'oa:item/{name}'}})
x=r/'assets/minecraft/atlases/items.json';a=json.loads(x.read_text());a['sources'] += [{'type':'minecraft:single','resource':f'oa:item/{name}','sprite':f'oa:item/{name}'} for name in ['bandage','firstaid','tayayuyu']];j(x,a)
shutil.copy('/tmp/build170.py',p/'source/build170.py')
print('Base implementation written')
