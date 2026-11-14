# macro: dir（-1＝前へ、1＝次へ）。@s＝押したプレイヤー。生成済みのマップを、選択中の次（前）から順に探して切り替える
# マップの並び：0 地上（br）→ 1 ネザー（nether）→ 2 洞窟（cave）→ 0 …（マップを増やしたら step_try の行と、3 の折り返しを直す）
$scoreboard players set #ms_dir oa.tmp $(dir)
scoreboard players operation #ms oa.tmp = #map oa.mapid
scoreboard players set #ms_n oa.tmp 0
function oa:lobby/mapsel/step_try
