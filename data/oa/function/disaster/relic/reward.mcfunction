effect give @s minecraft:regeneration 8 1 true
effect give @s minecraft:absorption 20 1 true
title @s times 5 40 10
# 1.9.221：お題「封印の宝珠を解錠する」
execute if score #mission br.tmp matches 11 if score @s br.mdone matches 0 if entity @s[tag=br.alive] run function oa:br/mission/clear
title @s title {text:"✦ 宝珠を解錠！",color:"light_purple",bold:true}
title @s subtitle {text:"戦利品が足元に現れた。体力も回復する",color:"yellow"}
