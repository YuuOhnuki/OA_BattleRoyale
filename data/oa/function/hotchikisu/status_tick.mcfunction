execute if entity @s[gamemode=spectator] run return run function oa:hotchikisu/status_cleanup
execute if entity @s[nbt={Health:0.0f}] run return run function oa:hotchikisu/status_cleanup
execute if entity @s[tag=oa.stapled] run function oa:hotchikisu/root_hold
scoreboard players remove @s[scores={oa.root=1..}] oa.root 1
execute if score @s oa.root matches 0 if entity @s[tag=oa.stapled] run function oa:hotchikisu/release_root
execute if score @s oa.bleed matches 1.. run function oa:hotchikisu/bleed_update
