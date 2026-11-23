# 1.9.191〜：たやゆゆのガチャ「災害コンボ」。このマップで起こる災害を5秒後にすべて同時に起こす（1.9.212 から新しい災害も含む）。
# 長さはそれぞれの災害と同じ。今起きている同じ災害には重ねない。予告中の通常の災害は、このコンボにまとめる
execute if score #dc_on br.tmp matches 1 run return run tellraw @a[tag=br.playing] {text:"災害コンボは発生中",color:"gray"}
function oa:disaster/available
execute unless score #dis_warn br.tmp matches 1.. run function oa:disaster/plan_clear
scoreboard players set #dis_warn br.tmp 0
function oa:disaster/combo/plan_all
scoreboard players set #dc_announce br.tmp 1
function oa:disaster/announce
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.lightning_bolt.thunder master @s ~ ~ ~ 0.9 0.6
scoreboard players set #dc_on br.tmp 1
scoreboard players set #dc_warn br.tmp 5
