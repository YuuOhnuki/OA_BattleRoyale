execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合待機中に練習場を生成してください。",color:"yellow"}
execute if data storage oa:practice {layout:1998} run return run tellraw @s {text:"練習庭園は生成済みです。ロビーから入場できます。",color:"green"}
execute if data storage oa:practice {building:1b} run return 0
scoreboard players set #practice_dim oa.tmp 0
execute in oa:practice run scoreboard players set #practice_dim oa.tmp 1
execute if score #practice_dim oa.tmp matches 0 run return run tellraw @s {text:"練習場のディメンションを読み込むため、サーバーを再起動してください。",color:"red"}
data modify storage oa:practice building set value 1b
execute in oa:practice run forceload add -50 -50 49 49
schedule function oa:practice/build_wait 2t replace
tellraw @s {text:"練習庭園を準備しています。",color:"aqua"}
