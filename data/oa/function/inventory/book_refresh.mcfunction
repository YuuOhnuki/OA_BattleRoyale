execute if entity @s[tag=br.playing] run return 0
execute if entity @s[tag=oa.practice] run return 0
scoreboard players set #old_guide oa.tmp 0
execute if items entity @s container.* *[minecraft:custom_data~{oa_player_book:1b}] run scoreboard players set #old_guide oa.tmp 1
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_player_book:1b}] run scoreboard players set #old_guide oa.tmp 1
execute if score #old_guide oa.tmp matches 1 unless items entity @s container.* *[minecraft:custom_data~{guide_v204:1b}] unless items entity @s weapon.offhand *[minecraft:custom_data~{guide_v204:1b}] run function oa:lobby/guide/book
scoreboard players set #old_admin oa.tmp 0
execute if entity @s[tag=br.admin] if items entity @s container.* *[minecraft:custom_data~{oa_admin_book:1b}] run scoreboard players set #old_admin oa.tmp 1
execute if entity @s[tag=br.admin] if items entity @s weapon.offhand *[minecraft:custom_data~{oa_admin_book:1b}] run scoreboard players set #old_admin oa.tmp 1
execute if score #old_admin oa.tmp matches 1 unless items entity @s container.* *[minecraft:custom_data~{book_v204:1b}] unless items entity @s weapon.offhand *[minecraft:custom_data~{book_v204:1b}] run function oa:admin/book
