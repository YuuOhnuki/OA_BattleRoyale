# 1.9.191: 大当たり「神引き」（1%）。使用者以外の生存者全員に即死のダメージ（使用者のキル）。武器の説明には書かない
tellraw @a[tag=br.playing] ""
tellraw @a[tag=br.playing] {text:"★★★ たやゆゆ変態ガチャ：大当たり！ 神引き ★★★",color:"#12a88f",bold:true}
tellraw @a[tag=br.playing] [{text:" → ",color:"gray"},{selector:"@s"},{text:" 以外の全員が消し飛ぶ",color:"gray"}]
tellraw @a[tag=br.playing] ""
# 1.9.192: 「たやゆゆの勝ち」は、優勝のタイトルのあとに出す（br/win_solo・win_team → tayayuyu/jackpot_title）
scoreboard players set #g_jp_win oa.tmp 1
execute as @a[tag=br.playing] at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.wither.spawn master @s ~ ~ ~ 0.8 1.3
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.generic.explode master @s ~ ~ ~ 1 0.5
particle minecraft:totem_of_undying ~ ~1 ~ 1 1.5 1 0.6 200 force @a[distance=..64]
particle minecraft:firework ~ ~1 ~ 1 1.5 1 0.3 120 force @a[distance=..64]
tag @s add oa.g_jackpot_self
execute as @a[tag=br.alive,tag=!oa.g_jackpot_self,gamemode=!spectator] at @s run function oa:tayayuyu/jackpot_hit
tag @s remove oa.g_jackpot_self
