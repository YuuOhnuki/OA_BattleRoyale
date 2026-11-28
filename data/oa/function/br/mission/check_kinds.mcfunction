# 1.9.261：お題24［難］固有武器（kind 1〜10）を2種類同時に持つ
scoreboard players set #m_kinds br.tmp 0
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:1}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:1}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:2}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:2}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:2}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:2}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:2}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:2}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:3}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:3}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:3}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:3}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:3}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:3}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:4}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:4}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:4}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:4}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:4}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:4}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:5}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:5}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:5}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:5}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:6}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:6}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:6}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:6}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:6}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:6}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:7}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:7}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:7}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:8}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:8}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:8}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:8}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:8}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:8}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:9}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:9}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:9}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:9}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:9}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:9}}] run scoreboard players add #m_kinds br.tmp 1
execute if items entity @s container.* *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:10}}] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players add #m_kinds br.tmp 1
execute unless items entity @s container.* *[minecraft:custom_data~{oa:{kind:10}}] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:10}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players add #m_kinds br.tmp 1
execute if score #m_kinds br.tmp matches 2.. run function oa:br/mission/clear
