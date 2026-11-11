execute unless entity @s[tag=oa.practice] run return 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute if entity @s[tag=jp_riding] run ride @s dismount
execute if entity @s[tag=jp_no_fall] run function jumppad:clear_fall_immunity
tag @s add oa.practice_exiting
execute if entity @s[tag=oa.debug] run function oa:practice/clean
execute store result storage oa:br_args id int 1 run scoreboard players get @s oa.id
function oa:br/restore with storage oa:br_args
execute if score @s br.saved matches 1 run return 0
tag @s remove oa.practice
tag @s remove oa.practice_exiting
execute if score #state br.state matches 0 run function oa:br/join
tellraw @s {text:"ロビーへ戻りました。練習中の荷物を消去しました。",color:"green"}
