execute if score @s oa.tdm matches 10 run return run function oa:tdm/menu
execute if score @s oa.tdm matches 11..12 unless score #state br.state matches 0 run return run tellraw @s {text:"チームは試合前に選択してください",color:"yellow"}
execute unless score #state br.state matches 0 unless entity @s[tag=tdm.player,scores={tdm.wait=1..}] run return run tellraw @s {text:"次の武器は復活待ちの間に選べます",color:"yellow"}
execute if entity @s[tag=oa.practice] run return 0
execute if score #state br.state matches 0 run function oa:br/join
execute if score @s oa.tdm matches 1 run scoreboard players set @s tdm.load 2
execute if score @s oa.tdm matches 1 run tellraw @s {"text": "次の出撃武器：ぴちぴち", "color": "aqua"}
execute if score @s oa.tdm matches 2 run scoreboard players set @s tdm.load 4
execute if score @s oa.tdm matches 2 run tellraw @s {"text": "次の出撃武器：ねろ", "color": "aqua"}
execute if score @s oa.tdm matches 3 run scoreboard players set @s tdm.load 6
execute if score @s oa.tdm matches 3 run tellraw @s {"text": "次の出撃武器：ゆったり", "color": "aqua"}
execute if score @s oa.tdm matches 4 run scoreboard players set @s tdm.load 7
execute if score @s oa.tdm matches 4 run tellraw @s {"text": "次の出撃武器：ほちきす", "color": "aqua"}
execute if score @s oa.tdm matches 5 run scoreboard players set @s tdm.load 8
execute if score @s oa.tdm matches 5 run tellraw @s {"text": "次の出撃武器：こまめ", "color": "aqua"}
execute if score @s oa.tdm matches 6 run scoreboard players set @s tdm.load 10
execute if score @s oa.tdm matches 6 run tellraw @s {"text": "次の出撃武器：いとり", "color": "aqua"}
execute if score @s oa.tdm matches 7 run scoreboard players set @s tdm.load 3
execute if score @s oa.tdm matches 7 run tellraw @s {"text": "次の出撃武器：らじ", "color": "aqua"}
execute if score @s oa.tdm matches 8 run scoreboard players set @s tdm.load 5
execute if score @s oa.tdm matches 8 run tellraw @s {"text": "次の出撃武器：キリング", "color": "aqua"}
execute if score @s oa.tdm matches 11 run scoreboard players set @s tdm.team 1
execute if score @s oa.tdm matches 12 run scoreboard players set @s tdm.team 2
