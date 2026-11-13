particle minecraft:dust{color:[0.5,1.0,0.2],scale:1.2} ~ ~1.2 ~ 0.4 0.5 0.4 0 10 normal @s
tag @s add br.dis_msg
execute if score #dis_phase br.tmp matches 1 run title @s actionbar {text:"☣ 酸性雨！ 屋根の下へ入るか、頭に防具を着けよう",color:"green"}
damage @s 2 minecraft:magic
playsound minecraft:block.fire.extinguish player @s ~ ~ ~ 0.6 1.5
