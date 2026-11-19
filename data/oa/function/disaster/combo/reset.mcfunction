# 1.9.191: 災害コンボを止める（disaster/init・clear から）
execute if score #dc1 br.tmp matches 1.. run function oa:disaster/k1/end
scoreboard players set #dc_on br.tmp 0
scoreboard players set #dc_warn br.tmp 0
scoreboard players set #dc1 br.tmp 0
scoreboard players set #dc2 br.tmp 0
scoreboard players set #dc3 br.tmp 0
scoreboard players set #dc4 br.tmp 0
scoreboard players set #dc5 br.tmp 0
scoreboard players set #dc6 br.tmp 0
scoreboard players set #g_tnt oa.tmp 0
# 1.9.192: 時限爆弾
function oa:tayayuyu/oni_reset
