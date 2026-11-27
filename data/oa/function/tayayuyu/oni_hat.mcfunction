# A real equipped TNT item, not a floating display. Never overwrite a failed drop.
kill @e[type=minecraft:item_display,tag=oa.g_oni_hat]
execute if items entity @s armor.head *[minecraft:custom_data~{oa_tnt_oni:1b}] run return 0
# 1.9.253: 元の頭の物はインベントリの空きへ（固有武器は従来どおり足もとへ）
function oa:inventory/hold_head
execute if items entity @s armor.head * run return 0
attribute @s minecraft:movement_speed modifier remove oa:curse
tag @s remove oa.curse_v1911
attribute @s minecraft:max_health modifier remove oa:curse_hp
tag @s remove oa.curse_v250
clear @s *[minecraft:custom_data~{oa_tnt_oni:1b}]
item replace entity @s armor.head with minecraft:tnt[minecraft:custom_name={text:"TNT鬼",color:"red",italic:false},minecraft:custom_data={oa_tnt_oni:1b},minecraft:max_stack_size=1,minecraft:equippable={slot:"head",swappable:false,damage_on_hurt:false,dispensable:false},minecraft:enchantments={"minecraft:binding_curse":1,"minecraft:vanishing_curse":1},minecraft:enchantment_glint_override=false]
function oa:inventory/release_head
