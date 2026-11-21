scoreboard players set #ready tdm.sys 197
scoreboard players set #building tdm.sys 0
execute if score #state br.state matches 0 if score #game oa.game matches 1 as @a[tag=tdm.pending_start,limit=1] at @s run function oa:tdm/start
tag @a remove tdm.pending_start
