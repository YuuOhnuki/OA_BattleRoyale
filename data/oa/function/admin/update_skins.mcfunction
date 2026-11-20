execute unless entity @s[tag=br.admin] run return 0
execute if data storage oa:lobby origin{terminal:203} run return run tellraw @s {text:"出撃ターミナルには人物の展示がありません（武器展示は oa.admin 46 で置き直せます）。",color:"yellow"}
data modify storage oa:lobby_events force_skins set value 1b
data modify storage oa:lobby_events skins set value 1b
function oa:lobby/events/request
