summon minecraft:item ~ ~0.5 ~ {Tags:["oa.spawn"],PickupDelay:32767s,Item:{id:"minecraft:stone",count:1}}
$item replace entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:custom_name={text:"いとり：昭心",color:"light_purple",italic:false},minecraft:custom_data={oa:{unique:1b,kind:10,serial:$(serial)}},minecraft:max_stack_size=1,minecraft:item_model="oa:itori",minecraft:enchantment_glint_override=false,minecraft:unbreakable={}]
item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:melee_itori
item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:lore/k10
scoreboard players set @e[tag=oa.spawn] oa.wait 20
execute if entity @s[tag=br.chest] run tag @e[tag=oa.spawn] add br.newunique
execute if score #state br.state matches 1 run tag @e[tag=oa.spawn] add br.matchloot
tag @e[tag=oa.spawn] remove oa.spawn
