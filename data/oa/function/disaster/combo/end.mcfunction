scoreboard players set #dc_on br.tmp 0
tellraw @a[tag=br.playing] {text:"✔ 災害コンボが収まりました",color:"green"}
execute unless score #dis_kind br.tmp matches 1.. run tag @a remove br.dis_msg
execute unless score #dis_kind br.tmp matches 1.. run scoreboard players set #dis_phase br.tmp 0
execute unless score #dis_kind br.tmp matches 1.. run function oa:disaster/clear_marks
