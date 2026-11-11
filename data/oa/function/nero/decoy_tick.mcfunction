execute if score @s oa.decoy matches 0 run return run function oa:nero/decoy_return
# Sustain only while ability is active; ending clears the owned resistance effect.
effect give @s minecraft:resistance 2 4 true
