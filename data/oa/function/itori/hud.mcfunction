execute if score @s oa.i_unlock matches 6 run data modify storage oa:itori_hud stage set value {text:"Ⅵ",color:"light_purple"}
execute if score @s oa.i_unlock matches 5 run data modify storage oa:itori_hud stage set value {text:"Ⅴ",color:"light_purple"}
execute if score @s oa.i_unlock matches 4 run data modify storage oa:itori_hud stage set value {text:"Ⅳ",color:"light_purple"}
execute if score @s oa.i_unlock matches 3 run data modify storage oa:itori_hud stage set value {text:"Ⅲ",color:"light_purple"}
execute if score @s oa.i_unlock matches 2 run data modify storage oa:itori_hud stage set value {text:"Ⅱ",color:"light_purple"}
execute if score @s oa.i_unlock matches 1 run data modify storage oa:itori_hud stage set value {text:"Ⅰ",color:"light_purple"}
execute if score @s oa.i_next matches 1 run data modify storage oa:itori_hud next set value {text:"ガイア",color:"light_purple"}
execute if score @s oa.i_next matches 2 run data modify storage oa:itori_hud next set value {text:"イネファ",color:"light_purple"}
execute if score @s oa.i_next matches 3 run data modify storage oa:itori_hud next set value {text:"ヴァレサ",color:"light_purple"}
execute if score @s oa.i_next matches 4 run data modify storage oa:itori_hud next set value {text:"シロネン",color:"light_purple"}
execute if score @s oa.i_next matches 5 run data modify storage oa:itori_hud next set value {text:"フリンズ",color:"light_purple"}
execute if score @s oa.i_next matches 6 run data modify storage oa:itori_hud next set value {text:"マーヴィカ",color:"light_purple"}
scoreboard players operation #i_cd oa.tmp = @s oa.cd
scoreboard players add #i_cd oa.tmp 19
scoreboard players set #i_twenty oa.tmp 20
scoreboard players operation #i_cd oa.tmp /= #i_twenty oa.tmp
data modify storage oa:itori_hud casting set value {text:""}
execute if entity @s[tag=oa.itori_windup] run data modify storage oa:itori_hud casting set value {text:" | 溜め中",color:"yellow"}
data modify storage oa:itori_hud edge_color set value {text:"",color:"white"}
execute if score @s br.out matches 1 run data modify storage oa:itori_hud edge_color set value {text:"（安置外）",color:"red"}
execute unless entity @s[tag=br.playing] run return run title @s actionbar {"text": "", "color": "white", "extra": [{"text":"いとり：昭心 ","color":"light_purple"},{"nbt":"stage","storage":"oa:itori_hud","interpret":true},{"text":" "}, {"text": "次："}, {"nbt": "next", "storage": "oa:itori_hud", "interpret": true}, {"nbt": "casting", "storage": "oa:itori_hud", "interpret": true}, {"text": " | CT "}, {"score": {"name": "#i_cd", "objective": "oa.tmp"}}, {"text": "秒"}, {"nbt": "display", "storage": "oa:allies", "interpret": true}]}
title @s actionbar {"text": "", "color": "white", "extra": [{"text":"いとり：昭心 ","color":"light_purple"},{"nbt":"stage","storage":"oa:itori_hud","interpret":true},{"text":" "}, {"text": "次："}, {"nbt": "next", "storage": "oa:itori_hud", "interpret": true}, {"nbt": "casting", "storage": "oa:itori_hud", "interpret": true}, {"text": " | CT "}, {"score": {"name": "#i_cd", "objective": "oa.tmp"}}, {"text": "秒"}, {"text": " | 境界 ", "color": "white"}, {"score": {"name": "@s", "objective": "br.edge"}, "color": "white"}, {"text": "m", "color": "white"}, {"nbt": "edge_color", "storage": "oa:itori_hud", "interpret": true}, {"nbt": "display", "storage": "oa:allies", "interpret": true}]}
