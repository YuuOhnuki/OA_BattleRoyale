execute if entity @s[tag=oa.practice] run return 0
execute unless entity @s[tag=br.admin] run return 0
execute if score @s oa.debug_cmd matches 1 run return run function oa:debug/start
execute unless entity @s[tag=oa.debug] run return run tellraw @s {text:"先に管理ブックからデバッグを開始してください。",color:"yellow"}
execute if score @s oa.debug_cmd matches 2 run return run function oa:debug/stop
execute if score @s oa.debug_cmd matches 3 run return run function oa:debug/book
execute if score @s oa.debug_cmd matches 4 run function oa:test/reset
execute if score @s oa.debug_cmd matches 5 run function oa:debug/spawn_target
execute if score @s oa.debug_cmd matches 6 run function oa:debug/spawn_attacker
execute if score @s oa.debug_cmd matches 7 run function oa:debug/clear_targets
execute if score @s oa.debug_cmd matches 8 run function oa:debug/reset_itori
execute if score @s oa.debug_cmd matches 100 run function oa:debug/toggle_cd
execute if score @s oa.debug_cmd matches 101 run function oa:debug/toggle_unique
execute if score @s oa.debug_cmd matches 102 run function oa:debug/toggle_match
execute if score @s oa.debug_cmd matches 103 run function oa:debug/toggle_grace
execute if score @s oa.debug_cmd matches 104 run function oa:debug/toggle_team
execute if score @s oa.debug_cmd matches 105 run function oa:debug/toggle_consume
execute if score @s oa.debug_cmd matches 106 run function oa:debug/toggle_wear
execute if score @s oa.debug_cmd matches 107 run function oa:debug/toggle_bind
execute if score @s oa.debug_cmd matches 108 run function oa:debug/toggle_mobs
execute if score @s oa.debug_cmd matches 109 run function oa:debug/toggle_heal
execute if score @s oa.debug_cmd matches 100..109 run function oa:debug/apply
execute if score @s oa.debug_cmd matches 100..109 run function oa:debug/items_restore
execute if score @s oa.debug_cmd matches 100..109 run function oa:debug/book

execute if score @s oa.debug_cmd matches 9 run function oa:debug/spawn_dummy
