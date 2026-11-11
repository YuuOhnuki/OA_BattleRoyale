tellraw @s {"text": "フリンズ：古律・孤灯の秘密", "color": "light_purple"}
scoreboard players set @s oa.i_flins 100
playsound minecraft:entity.lightning_bolt.thunder player @a[distance=..32] ~ ~ ~ 0.75 1.5
function oa:itori/lightning_fx
