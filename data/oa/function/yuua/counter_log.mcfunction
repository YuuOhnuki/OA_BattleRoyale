advancement revoke @s only oa:yuua/counter_kill
tag @a remove oa.yuua_dead
tag @a remove oa.yuua_funder
tag @s add oa.yuua_dead
execute on attacker if entity @s[type=minecraft:player] run tag @s add oa.yuua_funder
execute as @a[tag=oa.yuua_funder,limit=1] run function oa:ach/give {id:"yuua_counter",name:"今何かしたか？"}
execute if entity @a[tag=oa.yuua_funder] run tellraw @a [{selector:"@a[tag=oa.yuua_dead,limit=1]"},{text:" はゆうあ財閥に歯向かい、",color:"light_purple"},{selector:"@a[tag=oa.yuua_funder,limit=1]"},{text:" に社会的制裁を受けた",color:"light_purple"}]
tag @a remove oa.yuua_dead
tag @a remove oa.yuua_funder
