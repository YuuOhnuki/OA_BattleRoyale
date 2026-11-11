tag @s add oa.gacha_bomb_done
scoreboard players operation #gacha_active_event oa.tmp = @s oa.gevent
scoreboard players set #gacha_pending oa.tmp 0
execute as @e[distance=0..,type=minecraft:block_display,tag=oa.gacha_bomb,tag=oa.db_projectile,tag=!oa.gacha_bomb_done] if score @s oa.gevent = #gacha_active_event oa.tmp run scoreboard players set #gacha_pending oa.tmp 1
$execute if score #gacha_pending oa.tmp matches 0 run data remove storage oa:gacha_hits debug_hits.e$(event)
