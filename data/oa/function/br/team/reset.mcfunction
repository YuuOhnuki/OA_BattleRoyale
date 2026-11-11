scoreboard players reset * br.pick
scoreboard players set @a br.pick 0
tag @a[tag=br.lobby] add br.pick_rearm
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round run team leave @s
team empty oa_br1
team empty oa_br2
team empty oa_br3
team empty oa_br4
team empty oa_br5
team empty oa_br6
team empty oa_br7
team empty oa_br8
team empty oa_br9
team empty oa_br10
team empty oa_brsolo
team empty oa_brgrace
team empty oa_watch
