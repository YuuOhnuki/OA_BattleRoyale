execute as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa_receiver:1b}] run function oa:status/clean_ground
execute as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa_status_paper:1b}] run kill @s
execute as @e[distance=0..,type=minecraft:item,tag=oa.ground,tag=!oa.named_ground] at @s run function oa:ground/label
execute as @e[distance=0..,type=minecraft:item,tag=oa.ground] run function oa:ground/age
execute as @e[distance=0..,type=minecraft:item] unless items entity @s contents *[minecraft:max_stack_size=1] at @s if items entity @s contents *[minecraft:custom_data~{oa_normal:"bat"}] run function oa:normal/nonstack/split
execute as @e[distance=0..,type=minecraft:item] unless items entity @s contents *[minecraft:max_stack_size=1] at @s if items entity @s contents *[minecraft:custom_data~{oa_normal:"kb_stick"}] run function oa:normal/nonstack/split
execute as @e[distance=0..,type=minecraft:item] unless items entity @s contents *[minecraft:max_stack_size=1] at @s if items entity @s contents *[minecraft:custom_data~{oa_overwork:1b}] run function oa:normal/nonstack/split
execute if dimension oa:br if score #state br.state matches 1 if score #hat_round oa.serial = #round br.round as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa:{kind:1}}] run function oa:tayayuyu/prune_ground_hat
execute if dimension oa:br_nether if score #state br.state matches 1 if score #hat_round oa.serial = #round br.round as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa:{kind:1}}] run function oa:tayayuyu/prune_ground_hat
execute as @e[distance=0..,type=minecraft:item,tag=oa.ground] unless items entity @s contents *[minecraft:custom_data~{oa:{name_v172:1b}}] run function oa:ground/rename
execute as @e[distance=0..,type=minecraft:item,tag=!oa.furo_named] if items entity @s contents *[minecraft:custom_data~{oa_furoball:1b}] run function oa:furoball/ground
execute as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa_player_book:1b}] run kill @s
execute as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa_db_patch:1b}] run function oa:debug/restore_ground
execute as @e[distance=0..,type=minecraft:item,nbt={Item:{components:{"minecraft:enchantments":{"oa:debug_curse":1}}}}] run item modify entity @s contents oa:debug/bind
execute as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa_furoball:1b}] unless items entity @s contents *[minecraft:custom_data~{furo_stack1927:1b}] run item modify entity @s contents oa:furo_stack1927
