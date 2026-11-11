execute store result score #guard_roll oa.tmp run random value 1..100
execute if score #guard_roll oa.tmp matches 1..25 run tag @s add oa.curse_guard
