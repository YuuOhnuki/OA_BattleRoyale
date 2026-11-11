execute store result storage oa:br_args team int 1 run scoreboard players get @s br.pick
execute if score #mode br.mode matches 0 run function oa:br/spawn_points/pick
execute if score #mode br.mode matches 0 run function oa:br/spawn_points/save_player with storage oa:br_args
execute if score #mode br.mode matches 1 run function oa:br/spawn_points/team with storage oa:br_args
