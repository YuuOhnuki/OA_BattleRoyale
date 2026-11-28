# 1.9.261：お題22［難］残り3人まで生き残る（生存者が3人以下になったとき、自分が生きていれば達成）
execute store result score #m_alive br.tmp if entity @a[tag=br.alive,tag=!oa.dead]
execute if score #m_alive br.tmp matches ..3 run function oa:br/mission/clear
