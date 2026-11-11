execute if score #state br.state matches 0 run tellraw @s {"text":"試合状態：待機中","color":"green"}
execute if score #state br.state matches 1 run tellraw @s {"text":"試合状態：試合中","color":"yellow"}
execute if score #state br.state matches 2 run tellraw @s {"text":"試合状態：清掃・復元中","color":"aqua"}
execute if score #state br.state matches 3 run tellraw @s {"text":"試合状態：勝者演出中","color":"gold"}
