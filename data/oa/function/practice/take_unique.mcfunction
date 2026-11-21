# 1.9.211: give/<武器> が足もとに出した固有武器を、地面に残さずそのまま持ち物へ入れる（ゆうあは頭へ）
tag @e[type=minecraft:item,tag=oa.pick,distance=..4] remove oa.pick
execute as @e[type=minecraft:item,distance=..2,tag=!oa.ground,sort=nearest,limit=1] if items entity @s contents *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:ground/init
scoreboard players set @e[type=minecraft:item,tag=oa.ground,distance=..2] oa.wait 0
function oa:ground/pick
