execute if entity @s[tag=br.playing] run return run function oa:br/surrender
execute if entity @s[team=oa_br1] run team leave @s
execute if entity @s[team=oa_br2] run team leave @s
execute if entity @s[team=oa_br3] run team leave @s
execute if entity @s[team=oa_br4] run team leave @s
execute if entity @s[team=oa_br5] run team leave @s
execute if entity @s[team=oa_br6] run team leave @s
execute if entity @s[team=oa_br7] run team leave @s
execute if entity @s[team=oa_br8] run team leave @s
execute if entity @s[team=oa_br9] run team leave @s
execute if entity @s[team=oa_br10] run team leave @s
scoreboard players set @s br.pick 0
tag @s remove br.lobby
tellraw @s {text:"BR参加登録を解除しました",color:"gray"}
