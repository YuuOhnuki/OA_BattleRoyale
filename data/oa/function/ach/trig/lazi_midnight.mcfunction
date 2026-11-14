# 1.9.173: 進捗 oa:ach_trig/lazi_midnight（息切れ＝oa.tired のときに倒された）のご褒美。倒された本人に「午前0時」
advancement revoke @s only oa:ach_trig/lazi_midnight
execute if entity @s[tag=br.playing] run function oa:ach/give {id:"lazi_midnight",name:"午前0時"}
