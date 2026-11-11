from pathlib import Path
import json,re,shutil
p=Path('revision/pack');f=p/'data/oa/function';b=f/'tayayuyu'
def w(p,s):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s)
def add(p,s):w(p,p.read_text()+'\n'+s+'\n')
# Nine added outcomes, preserving the original seven and shared CT.
new=[('tiny_all','全員ちび化'),('shuffle','席替えタイム'),('gather','強制集合'),('peace_all','平和な世界'),('mood_all','全員キリング気分'),('reveal_all','丸見え大会'),('hunger_all','空腹の時間'),('giant_all','全員巨大化'),('intro','大ハズレ：自己紹介')]
x=b/'use.mcfunction';s=x.read_text().replace('random value 1..7','random value 1..16')
for i,(func,label) in enumerate(new,8):s+=f'\nexecute if score #gacha_roll oa.tmp matches {i} run function oa:tayayuyu/{func}\n'
w(x,s)
for func,label,body in [
 ('tiny_all','全員ちび化（15秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/size {amount:-0.5,ticks:300}'),
 ('giant_all','全員巨大化（1.75倍・10秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/size {amount:0.75,ticks:200}'),
 ('peace_all','平和な世界（5秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/peace {seconds:5,ticks:100}'),
 ('mood_all','全員キリング気分（5秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/mood'),
 ('reveal_all','丸見え大会（10秒）','execute as @a[tag=br.alive] at @s run function oa:tayayuyu/reveal'),
 ('hunger_all','空腹の時間（10秒）','execute as @a[tag=br.alive] at @s run effect give @s minecraft:hunger 10 0 true')]:
 w(b/(func+'.mcfunction'),f'tellraw @a[tag=br.playing] {{text:"変態ガチャ：{label}",color:"green"}}\n'+body+'\n')
w(b/'size.mcfunction','''attribute @s minecraft:scale modifier remove oa:komame_small
attribute @s minecraft:scale modifier remove oa:gacha_size
$attribute @s minecraft:scale modifier add oa:gacha_size $(amount) add_multiplied_total
$scoreboard players set @s oa.gsize $(ticks)
tag @s add oa.gacha_affected
tag @s add oa.gacha_size
particle minecraft:happy_villager ~ ~1 ~ 0.5 0.5 0.5 0 16 normal @a[distance=..32]
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 1.2 1.6
''')
w(b/'size_end.mcfunction','''attribute @s minecraft:scale modifier remove oa:gacha_size
tag @s remove oa.gacha_size
execute if score @s oa.kind matches 8 if score @s oa.small matches 1.. run attribute @s minecraft:scale modifier add oa:komame_small -0.5 add_multiplied_total
''')
x=f/'komame/use.mcfunction';s=x.read_text().replace('attribute @s minecraft:scale modifier add oa:komame_small -0.5 add_multiplied_total','execute unless entity @s[tag=oa.gacha_size] run attribute @s minecraft:scale modifier add oa:komame_small -0.5 add_multiplied_total');w(x,s)
w(b/'peace.mcfunction','''$execute unless score @s oa.gpeace matches $(ticks).. run scoreboard players set @s oa.gpeace $(ticks)
$effect give @s minecraft:resistance $(seconds) 4 true
tag @s add oa.gacha_affected
tag @s add oa.gacha_peace
tag @s add br.pvp_grace
tag @s add br.native_grace
team join oa_brgrace @s
particle minecraft:enchant ~ ~1 ~ 0.5 0.7 0.5 0.2 12 normal @a[distance=..24]
''')
w(b/'peace_end.mcfunction','''tag @s remove oa.gacha_peace
execute if score #time br.time matches 1200.. run tag @s remove br.pvp_grace
execute if score #state br.state matches 1 if entity @s[tag=br.playing] run function oa:br/grace/restore_team
''')
w(b/'mood.mcfunction','''attribute @s minecraft:movement_speed modifier remove oa:gacha_mood
attribute @s minecraft:movement_speed modifier add oa:gacha_mood 0.5 add_multiplied_total
scoreboard players set @s oa.gmood 100
effect give @s minecraft:blindness 5 0 true
tag @s add oa.gacha_mood
tag @s add oa.gacha_affected
playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 1.8 0.7
''')
w(b/'mood_end.mcfunction','''attribute @s minecraft:movement_speed modifier remove oa:gacha_mood
tag @s remove oa.gacha_mood
''')
w(b/'reveal.mcfunction','''effect give @s minecraft:glowing 10 0 true
scoreboard players set @s oa.gglow 200
tag @s add oa.gacha_glow
tag @s add oa.gacha_affected
function oa:tayayuyu/reveal_fx
''')
w(b/'reveal_fx.mcfunction','''particle minecraft:firework ~ ~1 ~ 0.6 1 0.6 0.1 32 normal @a[distance=..48]
particle minecraft:flash{color:[0.4,1.0,0.4,1.0]} ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..48]
playsound minecraft:entity.firework_rocket.blast player @a[distance=..48] ~ ~ ~ 1.8 1.1
''')
w(b/'intro.mcfunction','''tellraw @a[tag=br.playing] [{text:"変態ガチャ 大ハズレ：自己紹介！ 使用者は ",color:"gold"},{selector:"@s",color:"yellow"},{text:" です！",color:"gold"}]
effect give @s minecraft:glowing 15 0 true
scoreboard players set @s oa.gglow 300
tag @s add oa.gacha_glow
tag @s add oa.gacha_affected
function oa:tayayuyu/reveal_fx
''')
# Add timers before the original early returns; effects expire independently.
x=b/'tick.mcfunction';s=x.read_text();mark='execute if score @s oa.ghp matches 1.. run return 0';i=s.index(mark)
clock='''scoreboard players remove @s[scores={oa.gsize=1..}] oa.gsize 1
execute if score @s oa.gsize matches 0 if entity @s[tag=oa.gacha_size] run function oa:tayayuyu/size_end
scoreboard players remove @s[scores={oa.gpeace=1..}] oa.gpeace 1
execute if score @s oa.gpeace matches 0 if entity @s[tag=oa.gacha_peace] run function oa:tayayuyu/peace_end
scoreboard players remove @s[scores={oa.gmood=1..}] oa.gmood 1
execute if score @s oa.gmood matches 0 if entity @s[tag=oa.gacha_mood] run function oa:tayayuyu/mood_end
scoreboard players remove @s[scores={oa.gglow=1..}] oa.gglow 1
execute if score @s oa.gglow matches 0 run tag @s remove oa.gacha_glow
'''
for obj in ['oa.gsize','oa.gpeace','oa.gmood','oa.gglow']:clock+=f'execute if score @s {obj} matches 1.. run return 0\n'
s=s[:i]+clock+'\n'+s[i:];w(x,s)
x=b/'clear.mcfunction';s=x.read_text();s='''execute if entity @s[tag=oa.gacha_peace] if data entity @s active_effects[{id:"minecraft:resistance",amplifier:4}] run effect clear @s minecraft:resistance
execute if entity @s[tag=oa.gacha_peace] run function oa:tayayuyu/peace_end
execute if entity @s[tag=oa.gacha_mood] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run effect clear @s minecraft:blindness
execute if entity @s[tag=oa.gacha_glow] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run effect clear @s minecraft:glowing
attribute @s minecraft:scale modifier remove oa:gacha_size
attribute @s minecraft:movement_speed modifier remove oa:gacha_mood
tag @s remove oa.gacha_size
tag @s remove oa.gacha_mood
tag @s remove oa.gacha_glow
scoreboard players set @s oa.gsize 0
scoreboard players set @s oa.gpeace 0
scoreboard players set @s oa.gmood 0
scoreboard players set @s oa.gglow 0
'''+s;w(x,s)
x=b/'fire_hit.mcfunction';w(x,'execute if entity @s[tag=br.pvp_grace] run return 0\n'+x.read_text())
for obj in ['oa.gsize','oa.gpeace','oa.gmood','oa.gglow','oa.gslot']:add(f/'load.mcfunction',f'scoreboard objectives add {obj} dummy')
# Transaction-style placement: only markers move during planning, then participants move.
m=b/'move'
w(m/'prepare.mcfunction','''execute in minecraft:overworld run kill @e[type=minecraft:marker,tag=oa.g_move_plan]
scoreboard players set #g_move_ok oa.tmp 1
scoreboard players set #g_count oa.tmp 0
execute store result score #g_half oa.tmp in minecraft:overworld run worldborder get
scoreboard players set #g_two oa.tmp 2
scoreboard players operation #g_half oa.tmp /= #g_two oa.tmp
scoreboard players remove #g_half oa.tmp 3
execute if score #g_half oa.tmp matches ..0 run scoreboard players set #g_move_ok oa.tmp 0
data modify storage oa:g_move set from storage oa:br center
execute store result storage oa:g_move range int 1 run scoreboard players get #g_half oa.tmp
''')
w(m/'capture.mcfunction','''execute unless dimension minecraft:overworld run return run scoreboard players set #g_move_ok oa.tmp 0
scoreboard players operation @s oa.gslot = #g_count oa.tmp
summon minecraft:marker ~ ~ ~ {Tags:["oa.g_move_plan","oa.g_move_new"]}
scoreboard players operation @e[type=minecraft:marker,tag=oa.g_move_new] oa.gslot = #g_count oa.tmp
scoreboard players add #g_count oa.tmp 1
execute if score #g_move_mode oa.tmp matches 0 as @e[type=minecraft:marker,tag=oa.g_move_new] at @s run function oa:tayayuyu/move/check_or_scatter
tag @e[type=minecraft:marker,tag=oa.g_move_new] remove oa.g_move_new
''')
w(m/'check_or_scatter.mcfunction','''function oa:tayayuyu/move/check
execute if score #g_loc_ok oa.tmp matches 0 run function oa:tayayuyu/move/scatter_one with storage oa:g_move
function oa:tayayuyu/move/check
execute if score #g_loc_ok oa.tmp matches 0 run scoreboard players set #g_move_ok oa.tmp 0
''')
w(m/'scatter_one.mcfunction','$execute in minecraft:overworld run spreadplayers $(x) $(z) 0 $(range) false @s\n')
# Strict checks exclude fluid, solid ceilings, hazardous floors and border edges.
checks=['scoreboard players set #g_loc_ok oa.tmp 1','execute unless loaded ~ ~ ~ run return run scoreboard players set #g_loc_ok oa.tmp 0']
for dx in [-.55,.55]:
 for dz in [-.55,.55]:
  checks.append(f'execute if block ~{dx} ~-0.1 ~{dz} #oa:push_passable run return run scoreboard players set #g_loc_ok oa.tmp 0')
  checks.append(f'execute if block ~{dx} ~-0.1 ~{dz} #oa:gacha_unsafe_floor run return run scoreboard players set #g_loc_ok oa.tmp 0')
  for dy in [.1,.9,1.9,2.8,3.2]:checks.append(f'execute unless block ~{dx} ~{dy} ~{dz} #minecraft:air run return run scoreboard players set #g_loc_ok oa.tmp 0')
checks+='''execute store result score #g_dx oa.tmp run data get entity @s Pos[0] 1000
execute store result score #g_dz oa.tmp run data get entity @s Pos[2] 1000
scoreboard players operation #g_dx oa.tmp -= #cx br.x
scoreboard players operation #g_dz oa.tmp -= #cz br.z
scoreboard players operation #g_limit oa.tmp = #g_half oa.tmp
scoreboard players set #g_thousand oa.tmp 1000
scoreboard players operation #g_limit oa.tmp *= #g_thousand oa.tmp
execute if score #g_dx oa.tmp < #g_limit oa.tmp run scoreboard players add #g_loc_ok oa.tmp 0
execute if score #g_dx oa.tmp > #g_limit oa.tmp run return run scoreboard players set #g_loc_ok oa.tmp 0
execute if score #g_dz oa.tmp > #g_limit oa.tmp run return run scoreboard players set #g_loc_ok oa.tmp 0
scoreboard players operation #g_limit oa.tmp *= #g_two oa.tmp
scoreboard players operation #g_limit oa.tmp -= #g_limit oa.tmp
scoreboard players operation #g_limit oa.tmp -= #g_half oa.tmp
scoreboard players operation #g_limit oa.tmp *= #g_thousand oa.tmp
execute if score #g_dx oa.tmp < #g_limit oa.tmp run return run scoreboard players set #g_loc_ok oa.tmp 0
execute if score #g_dz oa.tmp < #g_limit oa.tmp run return run scoreboard players set #g_loc_ok oa.tmp 0'''.splitlines()
w(m/'check.mcfunction','\n'.join(checks)+'\n')
w(p/'data/oa/tags/block/gacha_unsafe_floor.json',json.dumps({'values':['minecraft:magma_block','minecraft:cactus','minecraft:campfire','minecraft:soul_campfire','minecraft:lava','minecraft:fire','minecraft:soul_fire','minecraft:powder_snow']},indent=2))
w(b/'shuffle.mcfunction','''tellraw @a[tag=br.playing] {text:"変態ガチャ：席替えタイム！",color:"green"}
function oa:tayayuyu/move/prepare
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
scoreboard players set #g_move_mode oa.tmp 0
execute as @a[tag=br.alive,sort=random] at @s run function oa:tayayuyu/move/capture
execute unless score #g_count oa.tmp matches 2.. run return run function oa:tayayuyu/move/abort
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
scoreboard players operation #g_max oa.tmp = #g_count oa.tmp
scoreboard players remove #g_max oa.tmp 1
execute store result storage oa:g_move max int 1 run scoreboard players get #g_max oa.tmp
function oa:tayayuyu/move/offset with storage oa:g_move
function oa:tayayuyu/move/commit
''')
w(m/'offset.mcfunction','$execute store result score #g_offset oa.tmp run random value 1..$(max)\n')
w(b/'gather.mcfunction','''tellraw @a[tag=br.playing] {text:"変態ガチャ：強制集合！ 移動後3秒間保護",color:"green"}
function oa:tayayuyu/move/prepare
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
execute if score #g_half oa.tmp matches 9.. run scoreboard players set #g_half oa.tmp 8
execute store result storage oa:g_move range int 1 run scoreboard players get #g_half oa.tmp
scoreboard players set #g_move_mode oa.tmp 1
execute as @a[tag=br.alive,sort=random] at @s run function oa:tayayuyu/move/capture
scoreboard players set #g_tries oa.tmp 8
function oa:tayayuyu/move/gather_plan
execute if score #g_move_ok oa.tmp matches 0 run return run function oa:tayayuyu/move/abort
scoreboard players set #g_offset oa.tmp 0
function oa:tayayuyu/move/commit
execute as @a[tag=br.alive] at @s run function oa:tayayuyu/peace {seconds:3,ticks:60}
''')
w(m/'gather_plan.mcfunction','''scoreboard players set #g_move_ok oa.tmp 1
scoreboard players set #g_spread_ok oa.tmp 0
function oa:tayayuyu/move/gather_spread with storage oa:g_move
execute unless score #g_spread_ok oa.tmp matches 1 run scoreboard players set #g_move_ok oa.tmp 0
execute in minecraft:overworld as @e[type=minecraft:marker,tag=oa.g_move_plan] at @s run function oa:tayayuyu/move/check_gather
scoreboard players remove #g_tries oa.tmp 1
execute if score #g_move_ok oa.tmp matches 0 if score #g_tries oa.tmp matches 1.. run function oa:tayayuyu/move/gather_plan
''')
w(m/'gather_spread.mcfunction','$execute in minecraft:overworld store success score #g_spread_ok oa.tmp run spreadplayers $(x) $(z) 2 $(range) false @e[type=minecraft:marker,tag=oa.g_move_plan]\n')
w(m/'check_gather.mcfunction','''function oa:tayayuyu/move/check
execute if score #g_loc_ok oa.tmp matches 0 run scoreboard players set #g_move_ok oa.tmp 0
execute store result score #g_y oa.tmp run data get entity @s Pos[1] 1000
execute store result score #g_ymax oa.tmp run data get storage oa:br center.y 1000
scoreboard players add #g_ymax oa.tmp 2000
execute if score #g_y oa.tmp > #g_ymax oa.tmp run scoreboard players set #g_move_ok oa.tmp 0
''')
w(m/'commit.mcfunction','''scoreboard players set #g_found oa.tmp 0
execute in minecraft:overworld as @e[type=minecraft:marker,tag=oa.g_move_plan] run scoreboard players add #g_found oa.tmp 1
execute unless score #g_found oa.tmp = #g_count oa.tmp run return run function oa:tayayuyu/move/abort
execute as @a[tag=br.alive] at @s run function oa:tayayuyu/move/player
execute in minecraft:overworld run kill @e[type=minecraft:marker,tag=oa.g_move_plan]
''')
w(m/'player.mcfunction','''function oa:nero/decoy_release
execute if entity @s[tag=oa.ambush_active] run function oa:yuttari/return
function oa:hotchikisu/status_cleanup
function oa:status/end_hop
scoreboard players operation #g_dest oa.tmp = @s oa.gslot
scoreboard players operation #g_dest oa.tmp += #g_offset oa.tmp
scoreboard players operation #g_dest oa.tmp %= #g_count oa.tmp
execute store result storage oa:g_move slot int 1 run scoreboard players get #g_dest oa.tmp
particle minecraft:portal ~ ~1 ~ 0.5 0.8 0.5 0.1 24 normal @a[distance=..32]
function oa:tayayuyu/move/tp with storage oa:g_move
particle minecraft:reverse_portal ~ ~1 ~ 0.5 0.8 0.5 0.1 24 normal @a[distance=..32]
playsound minecraft:entity.enderman.teleport player @s ~ ~ ~ 1.4 1
''')
w(m/'tp.mcfunction','$execute in minecraft:overworld at @e[type=minecraft:marker,tag=oa.g_move_plan,scores={oa.gslot=$(slot)},limit=1] run tp @s ~ ~ ~\n')
w(m/'abort.mcfunction','''execute in minecraft:overworld run kill @e[type=minecraft:marker,tag=oa.g_move_plan]
tellraw @a[tag=br.playing] {text:"安全な移動先を確保できなかったため、今回の移動は中止しました。",color:"yellow"}
''')
# Uniform display names; preserve item serial, skills, durability, count, and cooldown.
names={1:'ゆうあ：ピンク帯の麦わら帽子',2:'ぴちぴち：冷凍さかな',3:'らじ：防音マイク付きマスク',4:'ネロノワール：ペスト医師の杖',5:'キリング：呪いの「き」マスク',6:'ゆったり：瞬間奇襲アイテム',7:'ほちきす：ホッチキス',8:'こまめ：小豆バー',9:'たやゆゆ：変態ガチャ'}
colors=['light_purple','blue','yellow','dark_gray','dark_purple','aqua','red','light_purple','green']
for kind,name in names.items():
 mod={'type':'minecraft:sequence','functions':[{'type':'minecraft:set_components','components':{'minecraft:custom_name':{'text':name,'color':colors[kind-1],'italic':False}}},{'type':'minecraft:set_custom_data','tag':'{oa:{name_v172:1b}}'}]}
 w(p/f'data/oa/item_modifier/name/k{kind}.json',json.dumps(mod,ensure_ascii=False,indent=2))
s=''
for kind in names:s+=f'$execute if items entity @s $(slot) *[minecraft:custom_data~{{oa:{{kind:{kind}}}}}] run item modify entity @s $(slot) oa:name/k{kind}\n'
w(f/'inventory/name.mcfunction',s)
add(f/'inventory/visual.mcfunction','$execute unless items entity @s $(slot) *[minecraft:custom_data~{oa:{name_v172:1b}}] run function oa:inventory/name {slot:"$(slot)"}')
s=''
for kind in names:s+=f'execute if items entity @s contents *[minecraft:custom_data~{{oa:{{kind:{kind}}}}}] run item modify entity @s contents oa:name/k{kind}\n'
s+='function oa:ground/label\n';w(f/'ground/rename.mcfunction',s)
add(f/'world_tick.mcfunction','execute as @e[type=minecraft:item,tag=oa.ground] unless items entity @s contents *[minecraft:custom_data~{oa:{name_v172:1b}}] run function oa:ground/rename')
for root in [p]:
 for x in root.rglob('*'):
  if x.is_file() and x.suffix in ['.mcfunction','.md','.mcmeta','.json']:
   s=x.read_text();t=s.replace('ほちきす | ホッチキス','ほちきす：ホッチキス').replace('こまめ | 小豆バー','こまめ：小豆バー').replace('たやゆゆ | 変態ガチャ','たやゆゆ：変態ガチャ').replace('7種のガチャ','16種のガチャ').replace('7種から','16種から').replace('7種の全体','16種の全体').replace('1.7.1','1.7.2')
   if t!=s:w(x,t)
x=p/'data/oa/item_modifier/lore/k9.json';s=x.read_text().replace('7種のガチャ','16種のガチャ').replace('7種','16種');w(x,s)
x=f/'admin/book.mcfunction';w(x,x.read_text().replace('book_v170','book_v172').replace('7種','16種'))
shutil.copy('release_1_7_2/build172.py',p/'source/build172.py')
print('172 implementation written')
