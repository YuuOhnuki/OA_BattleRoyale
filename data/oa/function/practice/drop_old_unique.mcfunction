# 1.9.211: 練習場で固有武器を受け取る前に、持っている固有武器を消して後片付けする（1人1個。新しい物と入れ替え）
scoreboard players set #practice_old oa.tmp 0
execute if items entity @s container.* *[minecraft:custom_data~{oa:{unique:1b}}] run scoreboard players set #practice_old oa.tmp 1
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{unique:1b}}] run scoreboard players set #practice_old oa.tmp 1
execute if items entity @s armor.* *[minecraft:custom_data~{oa:{unique:1b}}] run scoreboard players set #practice_old oa.tmp 1
execute if score #practice_old oa.tmp matches 0 run return 0
clear @s *[minecraft:custom_data~{oa:{unique:1b}}]
function oa:internal/cleanup
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.have 0
