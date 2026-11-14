# 1.9.178: 進捗 oa:ach_trig/dqn（ゆうあの帽子を被った人に倒された）のご褒美。倒された本人が、この試合でガチャの帽子の効果を引いていれば実績
advancement revoke @s only oa:ach_trig/dqn
execute if entity @s[tag=br.playing,tag=oa.dqn] run function oa:ach/give {id:"tayayuyu_dqn",name:"DQNに屈した"}
