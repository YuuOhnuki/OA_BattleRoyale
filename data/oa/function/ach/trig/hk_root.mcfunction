# 1.9.173: 進捗 oa:ach_trig/hk_root（拘束中＝oa.stapled の人を倒した）のご褒美。倒した側がほちきすを持っていれば「人が病んでるところみると興奮する」
advancement revoke @s only oa:ach_trig/hk_root
execute if entity @s[tag=br.playing] if score @s oa.kind matches 7 run function oa:ach/give {id:"hotchikisu_root",name:"人が病んでるところみると興奮する"}
