effect give @s minecraft:regeneration 8 1 true
effect give @s minecraft:absorption 20 1 true
title @s times 5 40 10
# 1.9.223：お題「封印の宝珠を4つ解錠する」用の試合ごとの数（判定は br/mission/check）
scoreboard players add @s br.st_relic 1
title @s title {text:"✦ 宝珠を解錠！",color:"light_purple",bold:true}
title @s subtitle {text:"戦利品が足元に現れた。体力も回復する",color:"yellow"}
