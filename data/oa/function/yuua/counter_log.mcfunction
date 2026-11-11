advancement revoke @s only oa:yuua/counter_kill
tag @a remove oa.yuua_dead
tag @a remove oa.yuua_funder
tag @s add oa.yuua_dead
execute on attacker if entity @s[type=minecraft:player] run tag @s add oa.yuua_funder
execute if entity @a[tag=oa.yuua_funder] run tellraw @a [{selector:"@a[tag=oa.yuua_dead,limit=1]"},{text:"はゆうあ財閥（資金提供者"},{selector:"@a[tag=oa.yuua_funder,limit=1]"},{text:"）に歯向かったため社会的制裁を受けた",color:"light_purple"}]
tag @a remove oa.yuua_dead
tag @a remove oa.yuua_funder
