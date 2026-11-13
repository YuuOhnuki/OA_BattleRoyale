execute if score #dis_kind br.tmp matches 1 run function oa:disaster/k1/end
tellraw @a[tag=br.playing] {text:"✔ 災害が収まりました",color:"green"}
scoreboard players set #dis_kind br.tmp 0
scoreboard players set #dis_left br.tmp 0
function oa:disaster/clear_marks
execute store result score #dis_cd br.tmp run random value 70..110
