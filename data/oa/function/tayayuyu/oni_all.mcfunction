tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：時限爆弾",color:"green"}
tellraw @a[tag=br.playing] {"text": " → 鬼は殴って爆弾を押しつけろ\n → 45秒後に持っている人が爆発", "color": "gray"}
# 1.9.192: 全体で1つ（#g_oni＝残り tick、tick から oni_tick）。すでに動いていれば延長しない
execute if score #g_oni oa.tmp matches 1.. run return run tellraw @a[tag=br.playing] {text:"時限爆弾は作動中",color:"gray"}
scoreboard players set #g_oni oa.tmp 900
scoreboard players operation #g_oni_by oa.tmp = #gacha_caster oa.tmp
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead,sort=random,limit=1] at @s run function oa:tayayuyu/oni_take
execute unless entity @a[tag=oa.g_oni] run return run function oa:tayayuyu/oni_reset
function oa:tayayuyu/oni_reveal
tellraw @a[tag=br.playing] [{text:"💣 最初の鬼：",color:"red",bold:true},{selector:"@a[tag=oa.g_oni]",color:"white"}]
