execute if score #game oa.game matches 1 run scoreboard players set @s tdm.team 0
execute if score #game oa.game matches 0 run scoreboard players set @s br.pick 0
execute if score #game oa.game matches 0 run function oa:br/team/sync
scoreboard players set @s oa.lobby 0
tellraw @s {text:"チーム選択を解除しました",color:"aqua"}
