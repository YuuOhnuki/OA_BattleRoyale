# 管理者用：災害コンボ（このマップの災害すべて）を5秒後に。試合中のみ
execute unless score #state br.state matches 1 run return run tellraw @s {"text":"試合中だけ使えます","color":"red"}
function oa:disaster/combo/begin
