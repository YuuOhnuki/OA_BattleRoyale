# 1.9.191〜：災害コンボを止める（disaster/init・clear から。災害そのものは halt_all が止める）
scoreboard players set #dc_on br.tmp 0
scoreboard players set #dc_warn br.tmp 0
scoreboard players set #g_tnt oa.tmp 0
# 1.9.192: 時限爆弾
function oa:tayayuyu/oni_reset
