# 予定（#pN=1）を知らせて、5秒後に始める（disaster/warn）
scoreboard players set #dc_announce br.tmp 0
function oa:disaster/announce
execute if score #plan_n br.tmp matches 0 run return 0
scoreboard players set #dis_warn br.tmp 5
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.lightning_bolt.thunder master @s ~ ~ ~ 0.7 0.8
