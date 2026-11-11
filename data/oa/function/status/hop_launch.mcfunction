# Amplifier 21: target vertical speed 1.1, reached only for two simulation ticks.
# effect's one-second duration is a fallback; normal release is after two ticks.
effect give @s minecraft:levitation 1 21 true
tag @s add oa.hop_lift
scoreboard players set @s oa.hlift 2
particle minecraft:snowflake ~ ~0.1 ~ 0.25 0.05 0.25 0.02 4 normal @a[distance=..24]
