# 1.9.173: 進捗 oa:ach_trig/hk_itori（oa.nm_itori の付いた人を倒した）のご褒美。倒した側がほちきすを持っていれば実績
advancement revoke @s only oa:ach_trig/hk_itori
execute if entity @s[tag=br.playing] if score @s oa.kind matches 7 run function oa:ach/give {id:"hk_itori",name:"いとりちゅあん"}
