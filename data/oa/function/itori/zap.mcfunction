effect give @s minecraft:slowness 1 1 true
function oa:itori/lightning_fx
playsound minecraft:entity.lightning_bolt.thunder player @a[distance=..32] ~ ~ ~ 0.65 1.1
damage @s 1 oa:flins_lightning
