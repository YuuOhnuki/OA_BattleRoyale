execute if entity @s[tag=oa.practice] run return run function oa:practice/leave
execute if entity @s[tag=br.playing] if score @s br.round = #round br.round if score #state br.state matches 1 run return run tellraw @s {text:"試合中は復元できません",color:"red"}
execute unless score @s br.saved matches 1 run return 0
function oa:br/clear_match_effects
function oa:br/locator/restore
execute store result storage oa:br_args id int 1 run scoreboard players get @s oa.id
function oa:br/restore with storage oa:br_args
