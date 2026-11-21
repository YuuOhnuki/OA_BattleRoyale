advancement revoke @s only oa:practice/weapon_3
execute unless entity @s[tag=oa.practice] run return 0
execute unless dimension oa:practice run return 0
execute unless entity @s[tag=oa.practice,gamemode=!spectator] run return 0
execute unless dimension oa:practice run return 0
execute store result score #practice_space oa.tmp run function oa:practice/catalog/has_space
execute if score #practice_space oa.tmp matches 0 run return run tellraw @s {text:"持ち物に空きを1つ作ってから受け取ってください。",color:"yellow"}
function oa:lobby/gallery/info/3
function oa:give/yuttari
