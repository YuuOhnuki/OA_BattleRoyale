tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：瀕死の時間",color:"red"}
tellraw @a[tag=br.playing] {"text": " → 使用者だけ：体力が残り1ハートに", "color": "gray"}
function oa:tayayuyu/self_glow
execute store result score #critical_hp oa.tmp run data get entity @s Health 1000
scoreboard players remove #critical_hp oa.tmp 2000
execute if score #critical_hp oa.tmp matches ..0 run return 0
effect clear @s minecraft:absorption
execute store result storage oa:gacha_penalty amount double 0.001 run scoreboard players get #critical_hp oa.tmp
tag @s add oa.gacha_internal
function oa:tayayuyu/critical_damage with storage oa:gacha_penalty
tag @s remove oa.gacha_internal
execute if entity @s[tag=oa.gacha_exposed] run scoreboard players operation @s oa.ex_prev = @s oa.ex_taken
execute if entity @s[tag=oa.gacha_exposed] run scoreboard players operation @s oa.ex_aprev = @s oa.ex_absorb
