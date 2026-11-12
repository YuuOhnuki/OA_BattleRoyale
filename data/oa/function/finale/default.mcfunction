# どのマップにも使える標準の終盤演出：花火＋ランプ点滅＋中心の光の柱
function oa:finale/bursts
function oa:finale/lamps
particle minecraft:end_rod ~ ~-6 ~ 0.4 12 0.4 0.02 30 force @a[tag=br.playing,distance=..160]
