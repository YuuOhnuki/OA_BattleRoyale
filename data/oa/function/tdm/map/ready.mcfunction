execute in oa:tdm run function oa:tdm/map/build
scoreboard players set #building tdm.sys 0
execute unless score #ready tdm.sys matches 197 run return run tellraw @a[tag=br.admin] {text:"TDMマップの生成に失敗しました。再度開始してください",color:"red"}
execute if score #state br.state matches 0 if score #game oa.game matches 1 as @a[tag=tdm.pending_start,limit=1] at @s run function oa:tdm/start
tag @a remove tdm.pending_start
