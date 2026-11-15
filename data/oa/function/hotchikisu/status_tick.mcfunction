execute if entity @s[gamemode=spectator] run return run function oa:hotchikisu/status_cleanup
execute if entity @s[nbt={Health:0.0f}] run return run function oa:hotchikisu/status_cleanup
# 1.9.188: 拘束の位置に留めるのはプラグイン（weapon/RootHoldService、ストレージ oa:roots の位置）。ここは粒だけ
execute if entity @s[tag=oa.stapled] at @s if score #clock oa.beat matches 0 run function oa:hotchikisu/root_fx
scoreboard players remove @s[scores={oa.root=1..}] oa.root 1
execute if score @s oa.root matches 0 if entity @s[tag=oa.stapled] run function oa:hotchikisu/release_root
execute if score @s oa.bleed matches 1.. run function oa:hotchikisu/bleed_update
