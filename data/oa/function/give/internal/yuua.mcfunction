execute unless entity @s[tag=oa.debug] if score #yuua_issued br.tmp matches 1 run return 0
execute unless entity @s[tag=oa.debug] run scoreboard players set #yuua_issued br.tmp 1
summon minecraft:item ~ ~0.5 ~ {Tags:["oa.spawn"],PickupDelay:32767s,Item:{id:"minecraft:stone",count:1}}
$item replace entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:custom_name={"text":"ゆうあ：ピンク帯の麦わら帽子","color":"light_purple","italic":false},minecraft:custom_data={"oa":{"unique":true,"kind":1,"serial":$(serial)}},minecraft:max_stack_size=1,minecraft:item_model="oa:yuua",minecraft:enchantment_glint_override=false,minecraft:lore=[{"text":"OA試作版 / 固有装備は1人1個","color":"gray","italic":false}],minecraft:equippable={"slot":"head","swappable":true,"damage_on_hurt":false,"dispensable":false},minecraft:max_damage=600,minecraft:damage=0,minecraft:enchantments={"oa:hat":1}]
item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:lore/k1
item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:visual/k1
scoreboard players set @e[tag=oa.spawn] oa.wait 20
execute if entity @s[tag=br.chest] run tag @e[tag=oa.spawn] add br.newunique
execute if score #state br.state matches 1 if dimension oa:br unless entity @s[tag=oa.debug] run tag @e[tag=oa.spawn] add br.matchloot
execute if score #state br.state matches 1 if dimension oa:br_nether unless entity @s[tag=oa.debug] run tag @e[tag=oa.spawn] add br.matchloot
execute unless items entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents *[minecraft:custom_data~{oa:{speed_v160:1b}}] run item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:unique_speed
execute if entity @s[tag=br.chest] run item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:br_hat
execute if entity @s[tag=br.ground_new] run item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:br_hat
execute if entity @s[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round if score #state br.state matches 1 run item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:br_hat
tag @e[tag=oa.spawn] remove oa.spawn
