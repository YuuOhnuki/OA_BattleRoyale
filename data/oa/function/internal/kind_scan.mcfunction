# 1.9.182: player_tick から移した、使っている固有武器の種類（oa.kind）の判定。手・頭に OA の装備があるときだけ呼ばれる（順番も元のまま）
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players set @s oa.kind 1
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:2}}] run scoreboard players set @s oa.kind 2
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:3}}] run scoreboard players set @s oa.kind 3
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:4}}] run scoreboard players set @s oa.kind 4
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run scoreboard players set @s oa.kind 5
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:6}}] run scoreboard players set @s oa.kind 6
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set @s oa.kind 7
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set @s oa.kind 7
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:8}}] run scoreboard players set @s oa.kind 8
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] run scoreboard players set @s oa.kind 9
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players set @s oa.kind 10
