# Synchronous claim: first eligible player consumes it, so two players cannot both receive it.
tag @e[tag=tdm.claim] remove tdm.claim
tag @e[tag=tdm.pickup,distance=..1.4,sort=nearest,limit=1] add tdm.claim
scoreboard players operation #pickup tdm.sys = @e[tag=tdm.claim,limit=1] tdm.type
execute if score #pickup tdm.sys matches 101 if score @s tdm.armor matches 1.. run return 0
execute if score #pickup tdm.sys matches 102 if score @s tdm.armor matches 2 run return 0
execute if score #pickup tdm.sys matches 101 run function oa:tdm/armor/iron
execute if score #pickup tdm.sys matches 101 run scoreboard players set @s tdm.armor 1
execute if score #pickup tdm.sys matches 102 run function oa:tdm/armor/diamond
execute if score #pickup tdm.sys matches 102 run scoreboard players set @s tdm.armor 2
execute if score #pickup tdm.sys matches ..10 run function oa:tdm/loot/swap
execute if score #pickup tdm.sys matches 101.. run title @s actionbar {text:"防具が強化されました！死亡するとチェーンに戻ります",color:"aqua"}
playsound minecraft:entity.player.levelup player @s ~ ~ ~ 0.6 1.4
kill @e[tag=tdm.claim]
