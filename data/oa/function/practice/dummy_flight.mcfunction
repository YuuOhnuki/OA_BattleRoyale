scoreboard players add @s oa.tfall 1
execute if score @s oa.tfall matches 4.. if entity @s[nbt={OnGround:1b}] run function oa:practice/dummy_land
execute if entity @s[tag=oa.taya_fall] if score @s oa.tfall matches 100.. run function oa:practice/dummy_land
