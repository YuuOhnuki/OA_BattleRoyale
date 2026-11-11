execute unless entity @s[tag=oa.debug,tag=br.admin] run return 0
execute as @e[tag=oa.debug_spawned,distance=..64] at @s run function oa:br/world/remove_mob
kill @e[type=minecraft:text_display,tag=oa.debug_damage_label,distance=..64]
