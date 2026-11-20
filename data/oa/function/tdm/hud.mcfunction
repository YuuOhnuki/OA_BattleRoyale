scoreboard players set #seconds tdm.sys 6000
scoreboard players operation #seconds tdm.sys -= #time tdm.sys
scoreboard players set #twenty tdm.sys 20
scoreboard players operation #seconds tdm.sys /= #twenty tdm.sys
scoreboard players operation 残り秒 tdm.board = #seconds tdm.sys
scoreboard players operation 赤チーム tdm.board = #red tdm.points
scoreboard players operation 青チーム tdm.board = #blue tdm.points
title @a[tag=tdm.player] actionbar [{text:"TDM  赤 ",color:"red"},{score:{name:"#red",objective:"tdm.points"}},{text:" : ",color:"gray"},{score:{name:"#blue",objective:"tdm.points"},color:"blue"},{text:" 青  |  残り ",color:"aqua"},{score:{name:"#seconds",objective:"tdm.sys"},color:"white"},{text:"秒",color:"white"}]
execute if score #seconds tdm.sys matches 60 run tellraw @a[tag=tdm.player] {text:"残り1分！",color:"gold"}
