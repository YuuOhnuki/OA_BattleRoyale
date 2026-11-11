summon minecraft:item ~ ~0.5 ~ {Tags:["oa.spawn"],PickupDelay:32767s,Item:{id:"minecraft:stone",count:1}}
$item replace entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents with minecraft:carrot_on_a_stick[minecraft:custom_name={"text":"らじ：防音マイク付きマスク","color":"yellow","italic":false},minecraft:custom_data={"oa":{"unique":true,"kind":3,"serial":$(serial)}},minecraft:max_stack_size=1,minecraft:item_model="oa:raji",minecraft:enchantment_glint_override=false,minecraft:unbreakable={},minecraft:lore=[{"text":"OA試作版 / 固有装備は1人1個","color":"gray","italic":false}],minecraft:equippable={"slot":"head","swappable":true,"damage_on_hurt":false,"dispensable":false}]
scoreboard players set @e[tag=oa.spawn] oa.wait 20
tag @e[tag=oa.spawn] remove oa.spawn
