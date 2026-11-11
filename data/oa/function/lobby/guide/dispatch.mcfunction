execute if score @s oa.lobby matches 8 run return run function oa:practice/enter
execute if entity @s[tag=oa.practice] if score @s oa.lobby matches 1..2 run return run function oa:practice/leave
execute if entity @s[tag=oa.practice] if score @s oa.lobby matches 101..110 run return 0
execute if score @s oa.lobby matches 7 run return run function oa:lobby/guide/book
execute if score @s oa.lobby matches 6 run return run function oa:lobby/return
execute if score @s oa.lobby matches 2 run return run function oa:lobby/guide/watch
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中の参加・チーム変更は管理者へ依頼してください。",color:"yellow"}
execute if score @s oa.lobby matches 1 run return run function oa:lobby/return
execute if score @s oa.lobby matches 101..110 run function oa:br/join
execute if score @s oa.lobby matches 101 run function oa:br/team/1
execute if score @s oa.lobby matches 102 run function oa:br/team/2
execute if score @s oa.lobby matches 103 run function oa:br/team/3
execute if score @s oa.lobby matches 104 run function oa:br/team/4
execute if score @s oa.lobby matches 105 run function oa:br/team/5
execute if score @s oa.lobby matches 106 run function oa:br/team/6
execute if score @s oa.lobby matches 107 run function oa:br/team/7
execute if score @s oa.lobby matches 108 run function oa:br/team/8
execute if score @s oa.lobby matches 109 run function oa:br/team/9
execute if score @s oa.lobby matches 110 run function oa:br/team/10
