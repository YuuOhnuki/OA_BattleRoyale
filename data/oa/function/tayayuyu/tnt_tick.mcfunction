# 1.9.191: 降っているTNT（world_tick から）。地面に着く・4秒経つと爆発（本物の爆発はさせない）
execute unless score @s br.round = #round br.round run return run kill @s
execute unless score #state br.state matches 1 run return run kill @s
scoreboard players remove @s oa.gbomb 1
execute if score @s oa.gbomb matches ..0 run return run function oa:tayayuyu/tnt_explode
execute unless block ~ ~-0.2 ~ #oa:spawn_clear run function oa:tayayuyu/tnt_explode
