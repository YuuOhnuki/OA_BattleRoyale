tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：TNTの雨",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 10秒間、空からTNTが降る（1発で最大8HP、地形は壊れない）", "color": "gray"}
# 1.9.191: br/second から10秒（tnt_second）。生存者ごとに毎秒3個、まわりに落とす
scoreboard players set #g_tnt oa.tmp 10
scoreboard players operation #g_tnt_by oa.tmp = #gacha_caster oa.tmp
function oa:tayayuyu/tnt_second
