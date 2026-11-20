execute if score @s oa.tdm matches 10 run return run function oa:tdm/menu
execute unless score #state br.state matches 0 run return run tellraw @s {text:"武器・チームは試合前に選択してください",color:"yellow"}
execute if entity @s[tag=oa.practice] run return 0
function oa:br/join
execute if score @s oa.tdm matches 1 run scoreboard players set @s tdm.load 2
execute if score @s oa.tdm matches 1 run tellraw @s {"text": "TDMの初期武器：ぴちぴち（死亡後もこの武器で復活）", "color": "aqua"}
execute if score @s oa.tdm matches 2 run scoreboard players set @s tdm.load 4
execute if score @s oa.tdm matches 2 run tellraw @s {"text": "TDMの初期武器：ネロ（死亡後もこの武器で復活）", "color": "aqua"}
execute if score @s oa.tdm matches 3 run scoreboard players set @s tdm.load 6
execute if score @s oa.tdm matches 3 run tellraw @s {"text": "TDMの初期武器：ゆったり（死亡後もこの武器で復活）", "color": "aqua"}
execute if score @s oa.tdm matches 4 run scoreboard players set @s tdm.load 7
execute if score @s oa.tdm matches 4 run tellraw @s {"text": "TDMの初期武器：ほちきす（死亡後もこの武器で復活）", "color": "aqua"}
execute if score @s oa.tdm matches 5 run scoreboard players set @s tdm.load 8
execute if score @s oa.tdm matches 5 run tellraw @s {"text": "TDMの初期武器：こまめ（死亡後もこの武器で復活）", "color": "aqua"}
execute if score @s oa.tdm matches 6 run scoreboard players set @s tdm.load 10
execute if score @s oa.tdm matches 6 run tellraw @s {"text": "TDMの初期武器：いとり（死亡後もこの武器で復活）", "color": "aqua"}
execute if score @s oa.tdm matches 11 run scoreboard players set @s tdm.team 1
execute if score @s oa.tdm matches 12 run scoreboard players set @s tdm.team 2
execute if score @s oa.tdm matches 11 run tellraw @s {text:"TDM：赤チームを希望",color:"red"}
execute if score @s oa.tdm matches 12 run tellraw @s {text:"TDM：青チームを希望",color:"blue"}
