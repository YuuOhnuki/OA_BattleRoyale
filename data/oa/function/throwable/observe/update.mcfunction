$execute at @e[type=#oa:br_throwables,tag=oa.throw_observed,scores={oa.proj=$(id)},limit=1] run tp @s ~ ~ ~
$data modify entity @s data.velocity set from entity @e[type=#oa:br_throwables,tag=oa.throw_observed,scores={oa.proj=$(id)},limit=1] Motion
