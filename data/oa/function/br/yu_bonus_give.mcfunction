$scoreboard players set @s $(flag) 1
function oa:give/internal/overwork
$tellraw @s [{text:"✦ ",color:"gold"},{selector:"@s"},{text:" が$(what)ので、報酬として ",color:"yellow"},{"text":"ゆー：オーバーワーク","color":"#55C985","italic":false,"bold":true},{text:" をもらいました！",color:"yellow"}]
playsound minecraft:entity.player.levelup player @s ~ ~ ~ 1 1.4
particle minecraft:totem_of_undying ~ ~1 ~ 0.5 0.8 0.5 0.3 30 normal @a[distance=..32]
