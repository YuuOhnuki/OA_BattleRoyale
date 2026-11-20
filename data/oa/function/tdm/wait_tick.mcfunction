execute at @s unless dimension oa:tdm in oa:tdm run tp @s 0.5 90 0.5
execute at @s unless entity @s[x=-5,y=89,z=-5,dx=10,dy=7,dz=10] in oa:tdm run tp @s 0.5 90 0.5
execute unless entity @s[gamemode=adventure] run gamemode adventure @s
tag @s add br.pvp_grace
effect give @s minecraft:resistance 2 4 true
scoreboard players operation #wait_seconds tdm.sys = @s tdm.wait
scoreboard players add #wait_seconds tdm.sys 19
scoreboard players set #twenty tdm.sys 20
scoreboard players operation #wait_seconds tdm.sys /= #twenty tdm.sys
title @s actionbar [{text:"復活まで ",color:"yellow"},{score:{name:"#wait_seconds",objective:"tdm.sys"}},{text:"秒  /tdm で次の武器を選択",color:"aqua"}]
