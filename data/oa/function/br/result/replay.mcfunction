execute unless entity @a[tag=oa.last_result] run return run tellraw @s {text:"まだ試合結果がありません。",color:"yellow"}
tag @s add oa.res_view
function oa:br/result/body
tag @s remove oa.res_view
