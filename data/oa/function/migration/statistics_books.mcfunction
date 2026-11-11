tag @s remove oa.old_admin_book
tag @s remove oa.old_guide_book
execute if items entity @s hotbar.* *[minecraft:custom_data~{oa_admin_book:1b,book_v190:1b}] run tag @s add oa.old_admin_book
execute if items entity @s inventory.* *[minecraft:custom_data~{oa_admin_book:1b,book_v190:1b}] run tag @s add oa.old_admin_book
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_admin_book:1b,book_v190:1b}] run tag @s add oa.old_admin_book
execute if items entity @s hotbar.* *[minecraft:custom_data~{oa_player_book:1b,guide_v190:1b}] run tag @s add oa.old_guide_book
execute if items entity @s inventory.* *[minecraft:custom_data~{oa_player_book:1b,guide_v190:1b}] run tag @s add oa.old_guide_book
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_player_book:1b,guide_v190:1b}] run tag @s add oa.old_guide_book
execute if entity @s[tag=oa.old_admin_book,tag=br.admin] run function oa:admin/book
execute if entity @s[tag=oa.old_admin_book,tag=!br.admin] run clear @s *[minecraft:custom_data~{oa_admin_book:1b}]
execute if entity @s[tag=oa.old_guide_book] run function oa:lobby/guide/book
tag @s remove oa.old_admin_book
tag @s remove oa.old_guide_book
tag @s remove oa.rank_recorded
