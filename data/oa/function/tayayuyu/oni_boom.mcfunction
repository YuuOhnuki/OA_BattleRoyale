# 1.9.192: 時間切れ。最後に持っていた鬼が爆発（防具・耐性・トーテムを無視して倒れる。キルは使用者）
tag @a remove oa.g_source
execute as @a if score @s oa.id = #g_oni_by oa.tmp run tag @s add oa.g_source
execute as @a[tag=oa.g_oni] at @s run function oa:tayayuyu/oni_boom_one
tag @a remove oa.g_source
function oa:tayayuyu/oni_reset
