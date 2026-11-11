summon minecraft:item ~ ~0.5 ~ {Tags:["oa.overwork_spawn"],PickupDelay:20s,Item:{id:"minecraft:totem_of_undying",count:1}}
item replace entity @e[type=minecraft:item,tag=oa.overwork_spawn,limit=1] contents with minecraft:totem_of_undying[minecraft:custom_name={text:"ゆー | オーバーワーク",color:"gold",italic:false},minecraft:custom_data={oa_overwork:1b},minecraft:max_stack_size=1,minecraft:item_model="oa:yu",minecraft:lore=[{text:"手に持っていると致死ダメージ時に身代わりになる",color:"gray",italic:false},{text:"発動後に強化、その後は毒・吐き気・鈍足",color:"gray",italic:false}]] 1
execute if entity @s[tag=br.chest] run tag @e[tag=oa.overwork_spawn] add br.newunique
execute if score #state br.state matches 1 run tag @e[tag=oa.overwork_spawn] add br.matchloot
tag @e[tag=oa.overwork_spawn] remove oa.overwork_spawn
