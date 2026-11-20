scoreboard players set #red_n tdm.sys 0
scoreboard players set #blue_n tdm.sys 0
execute as @a[tag=br.lobby,scores={tdm.team=1}] run scoreboard players add #red_n tdm.sys 1
execute as @a[tag=br.lobby,scores={tdm.team=2}] run scoreboard players add #blue_n tdm.sys 1
scoreboard players operation #diff tdm.sys = #red_n tdm.sys
scoreboard players operation #diff tdm.sys -= #blue_n tdm.sys
execute if score #diff tdm.sys matches -1..1 run return 0
execute if score #diff tdm.sys matches 2.. as @a[tag=br.lobby,scores={tdm.team=1},sort=random,limit=1] run scoreboard players set @s tdm.team 2
execute if score #diff tdm.sys matches ..-2 as @a[tag=br.lobby,scores={tdm.team=2},sort=random,limit=1] run scoreboard players set @s tdm.team 1
function oa:tdm/rebalance
