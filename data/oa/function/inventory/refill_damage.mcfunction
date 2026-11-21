scoreboard players set #weapon_up oa.tmp 0
execute if entity @s[tag=br.alive,tag=!oa.practice] if score #state br.state matches 1 if score #time br.time matches 7200.. run scoreboard players set #weapon_up oa.tmp 1
execute if score #weapon_up oa.tmp matches 0 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:4}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{damage194:1b,damage194_up:0b}}] run item modify entity @s weapon.mainhand oa:melee_iron
execute if score #weapon_up oa.tmp matches 1 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:4}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{damage194:1b,damage194_up:1b}}] run item modify entity @s weapon.mainhand oa:melee_iron_refill
execute if score #weapon_up oa.tmp matches 0 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:6}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{damage194:1b,damage194_up:0b}}] run item modify entity @s weapon.mainhand oa:melee_iron
execute if score #weapon_up oa.tmp matches 1 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:6}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{damage194:1b,damage194_up:1b}}] run item modify entity @s weapon.mainhand oa:melee_iron_refill
execute if score #weapon_up oa.tmp matches 0 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:8}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{damage194:1b,damage194_up:0b}}] run item modify entity @s weapon.mainhand oa:melee_komame
execute if score #weapon_up oa.tmp matches 1 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:8}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{damage194:1b,damage194_up:1b}}] run item modify entity @s weapon.mainhand oa:melee_komame_refill
execute if score #weapon_up oa.tmp matches 0 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{damage194:1b,damage194_up:0b}}] run item modify entity @s weapon.mainhand oa:melee_tayayuyu
execute if score #weapon_up oa.tmp matches 1 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{damage194:1b,damage194_up:1b}}] run item modify entity @s weapon.mainhand oa:melee_tayayuyu_refill

# description214: base damage followed by refill damage in parentheses.
function oa:inventory/lore {slot:"weapon.mainhand"}

# description214: show the actual strengthened item, never forecast refill stats.
function oa:inventory/lore {slot:"weapon.mainhand"}
