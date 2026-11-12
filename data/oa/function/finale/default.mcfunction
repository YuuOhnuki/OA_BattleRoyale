# どのマップにも使える標準の終盤演出：花火＋ランプ点滅＋中心の光の柱（控えめ）
function oa:finale/bursts
function oa:finale/lamps
execute if score #fstep br.tmp matches 0 run particle minecraft:end_rod ~ ~-6 ~ 0.4 12 0.4 0.02 12 force @a[tag=br.playing,distance=..160]
