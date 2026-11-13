function oa:br/spawn_points/check
execute if score #spawn_floor br.flag matches 1 run return run function oa:br/tp_fix_done
scoreboard players remove #tpfix_n br.tmp 1
execute if score #tpfix_n br.tmp matches ..0 run return 0
execute unless loaded ~ ~1 ~ run return 0
execute positioned ~ ~1 ~ run function oa:br/tp_fix_up
