# Per-mask cumulative equipped ticks. No reset on reload, rejoin, gear switch, or owner change.
$scoreboard players add #k$(serial) oa.ktimer 1
$execute if score #k$(serial) oa.ktimer matches 1200.. run function oa:curse/expire
