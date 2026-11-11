summon minecraft:item ~ ~0.5 ~ {Tags:["oa.spawn"],PickupDelay:32767s,Item:{id:"minecraft:stone",count:1}}
$item replace entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:custom_name={"text":"キリング：呪いの「き」マスク","color":"dark_purple","italic":false},minecraft:custom_data={"oa":{"unique":true,"kind":5,"serial":$(serial)}},minecraft:max_stack_size=1,minecraft:item_model="oa:killing",minecraft:enchantment_glint_override=false,minecraft:max_damage=1200,minecraft:damage=0,minecraft:lore=[{"text":"OA試作版 / 固有装備は1人1個","color":"gray","italic":false}],minecraft:equippable={"slot":"head","swappable":false,"damage_on_hurt":false,"dispensable":false},minecraft:enchantments={"oa:curse":1}]
item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:lore/k5
item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:visual/k5
scoreboard players set @e[tag=oa.spawn] oa.wait 20
execute if entity @s[tag=br.chest] run tag @e[tag=oa.spawn] add br.newunique
execute if score #state br.state matches 1 run tag @e[tag=oa.spawn] add br.matchloot
execute unless items entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents *[minecraft:custom_data~{oa:{speed_v160:1b}}] run item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:unique_speed
tag @e[tag=oa.spawn] remove oa.spawn
