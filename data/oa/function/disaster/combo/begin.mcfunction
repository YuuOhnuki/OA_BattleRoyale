# 1.9.191: たやゆゆのガチャ「災害コンボ」。このマップで起こる災害（地上は1〜6、ほかは3〜6）を5秒後にすべて同時に起こす。
# 長さはそれぞれの災害と同じ。種類ごとの残り秒は #dc1〜#dc6（br.tmp）。今起きている（予告中を含む）通常の災害と同じ種類は重ねない
execute if score #dc_on br.tmp matches 1 run return run tellraw @a[tag=br.playing] {text:"（災害コンボはすでに起きています）",color:"gray"}
scoreboard players set #dc_p1 br.tmp 0
scoreboard players set #dc_p2 br.tmp 0
execute if score #map oa.mapid matches 0 run scoreboard players set #dc_p1 br.tmp 1
execute if score #map oa.mapid matches 0 run scoreboard players set #dc_p2 br.tmp 1
scoreboard players set #dc_p3 br.tmp 1
scoreboard players set #dc_p4 br.tmp 1
scoreboard players set #dc_p5 br.tmp 1
scoreboard players set #dc_p6 br.tmp 1
execute if score #dis_kind br.tmp matches 1 run scoreboard players set #dc_p1 br.tmp 0
execute if score #dis_kind br.tmp matches 2 run scoreboard players set #dc_p2 br.tmp 0
execute if score #dis_kind br.tmp matches 3 run scoreboard players set #dc_p3 br.tmp 0
execute if score #dis_kind br.tmp matches 4 run scoreboard players set #dc_p4 br.tmp 0
execute if score #dis_kind br.tmp matches 5 run scoreboard players set #dc_p5 br.tmp 0
execute if score #dis_kind br.tmp matches 6 run scoreboard players set #dc_p6 br.tmp 0
execute if score #dc_p1 br.tmp matches 1 run function oa:disaster/k1/warn
execute if score #dc_p2 br.tmp matches 1 run function oa:disaster/k2/warn
execute if score #dc_p3 br.tmp matches 1 run function oa:disaster/k3/warn
execute if score #dc_p4 br.tmp matches 1 run function oa:disaster/k4/warn
execute if score #dc_p5 br.tmp matches 1 run function oa:disaster/k5/warn
execute if score #dc_p6 br.tmp matches 1 run function oa:disaster/k6/warn
title @a[tag=br.playing] times 10 70 15
title @a[tag=br.playing] subtitle {text:"このマップの災害がすべて同時に起こる！",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害コンボ",color:"dark_red",bold:true}
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.lightning_bolt.thunder master @s ~ ~ ~ 0.9 0.6
scoreboard players set #dc_on br.tmp 1
scoreboard players set #dc_warn br.tmp 5
scoreboard players set #dc_t br.tmp 0
