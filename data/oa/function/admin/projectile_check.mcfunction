tellraw @s {text:"飛び道具チェック（Java26.3）",color:"gold"}
execute if entity @s[tag=br.pvp_grace] run tellraw @s {text:"開始保護：有効（追加効果を抑止中）",color:"yellow"}
execute unless entity @s[tag=br.pvp_grace] run tellraw @s {text:"開始保護：なし",color:"green"}
execute if entity @s[tag=br.alive] run tellraw @s {text:"参加状態：生存参加者",color:"green"}
execute unless entity @s[tag=br.alive] run tellraw @s {text:"参加状態：生存参加者ではありません（追加効果の対象外）",color:"yellow"}
scoreboard players set #snow_n oa.tmp 0
scoreboard players set #egg_n oa.tmp 0
execute as @e[type=minecraft:snowball] run scoreboard players add #snow_n oa.tmp 1
execute as @e[type=minecraft:egg] run scoreboard players add #egg_n oa.tmp 1
tellraw @s [{text:"読み込み中の雪玉：",color:"aqua"},{score:{name:"#snow_n",objective:"oa.tmp"}},{text:"／卵："},{score:{name:"#egg_n",objective:"oa.tmp"}}]
tellraw @s {text:"26.3標準ではプレイヤーへ雪玉・卵のノックバックはありません。pvp設定値はデータパックから読めません。server.propertiesのpvp=trueを確認してください。",color:"gray"}
scoreboard players add @s oa.throw_hits 0
tellraw @s [{text:"自分への補助命中判定回数：",color:"aqua"},{score:{name:"@s",objective:"oa.throw_hits"}}]
