$execute if entity @e[type=#oa:br_throwables,tag=oa.throw_observed,scores={oa.proj=$(id)},limit=1] run return run function oa:throwable/observe/update {id:$(id)}
function oa:throwable/observe/impact
kill @s
