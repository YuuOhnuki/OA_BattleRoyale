# Play after inventory restoration and teleport, so the lobby can see the celebration.
execute as @a[tag=tdm.fx_result,tag=tdm.fx_win] at @s run playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 0.8 1
execute as @a[tag=tdm.fx_result,tag=tdm.fx_win] at @s run particle minecraft:firework ~ ~1.5 ~ 0.7 0.8 0.7 0.1 45 normal @a[distance=..32]
execute as @a[tag=tdm.fx_result,tag=!tdm.fx_win] at @s run playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.7 0.7
tag @a remove tdm.fx_result
tag @a remove tdm.fx_win
