execute unless entity @s[tag=oa.practice] run return 0
execute unless dimension oa:practice run return 0
# 1.9.186: 練習場でバニラの装備・武器を試す（練習中だけ。練習場を出ると練習中の荷物ごと消える）
execute if score @s oa.lobby matches 209 run function oa:practice/vanilla/armor {m:"iron"}
execute if score @s oa.lobby matches 210 run function oa:practice/vanilla/armor {m:"diamond"}
execute if score @s oa.lobby matches 211 run tellraw @s {text:"バトルロワイヤルに出現しない装備は練習できません。展示から選んでください。",color:"yellow"}
execute if score @s oa.lobby matches 212 run function oa:practice/vanilla/melee
execute if score @s oa.lobby matches 213 run function oa:practice/vanilla/ranged
execute if score @s oa.lobby matches 214 run function oa:practice/vanilla/shield
execute if score @s oa.lobby matches 215 run function oa:practice/vanilla/unequip
playsound minecraft:item.armor.equip_iron player @s ~ ~ ~ 0.8 1.2
