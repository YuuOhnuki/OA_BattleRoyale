particle minecraft:dust{color:[0.5,1.0,0.2],scale:1.2} ~ ~1.2 ~ 0.4 0.5 0.4 0 10 normal @s
tag @s add br.dis_msg
execute if score #dis_phase br.tmp matches 1 run title @s actionbar {text:"☣ 酸性雨！ 屋根の下か頭防具で防ごう",color:"green"}
function oa:disaster/dmg {amount:2,type:"minecraft:magic"}
playsound minecraft:block.fire.extinguish player @s ~ ~ ~ 0.6 1.5
