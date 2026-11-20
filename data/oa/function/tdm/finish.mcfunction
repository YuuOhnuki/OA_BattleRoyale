execute unless score #active tdm.sys matches 1 run return 0
execute if score #red tdm.points > #blue tdm.points run title @a[tag=tdm.player] title {text:"赤チームの勝ち！",color:"red"}
execute if score #blue tdm.points > #red tdm.points run title @a[tag=tdm.player] title {text:"青チームの勝ち！",color:"blue"}
execute if score #red tdm.points = #blue tdm.points run title @a[tag=tdm.player] title {text:"引き分け！",color:"gold"}
tellraw @a[tag=tdm.player] [{text:"TDM結果  赤 ",color:"red"},{score:{name:"#red",objective:"tdm.points"}},{text:" - ",color:"gray"},{score:{name:"#blue",objective:"tdm.points"},color:"blue"},{text:" 青",color:"blue"}]
execute as @a[tag=tdm.player] run tellraw @s [{text:"あなたのキル数：",color:"aqua"},{score:{name:"@s",objective:"tdm.points"}}]
function oa:tdm/stop
