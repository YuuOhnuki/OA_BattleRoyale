# 1.9.169: ボタンを押したら切り替わる先のマップ（生成済みのものを #ms_dir の向きに探す）を #mp に入れる（0〜2、なければ -1）。lobby/mapsel/step_try と同じ順番
scoreboard players operation #mp oa.tmp = #map oa.mapid
scoreboard players set #mp_n oa.tmp 0
function oa:lobby/mapsel/peek_try
