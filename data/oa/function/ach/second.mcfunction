# 1.9.173: 実績の毎秒の判定（br/second から、試合中の生存者として、at @s）
# ゆったりの武器を持ち続けた秒数（60秒で「haves」）
execute if score @s oa.kind matches 6 run scoreboard players add @s br.a_yhold 1
execute unless score @s oa.kind matches 6 run scoreboard players set @s br.a_yhold 0
execute if score @s br.a_yhold matches 60.. run function oa:ach/give {id:"yuttari_haves",name:"haves"}
# 帽子（ゆうあ）・マスク（キリング）を被ったことがあるか（試合の終わりに、キル0なら「明日早いので寝ます」「そろそろ寝るか...。」）
execute if score @s oa.kind matches 1 run tag @s add oa.a_wore1
execute if score @s oa.kind matches 5 run tag @s add oa.a_wore5
# 動かずに立ち止まった秒数（位置が0.1ブロック以上変わらない。30秒で「一旦離席」）。保護期間のあとだけ数える
execute store result score #ax br.tmp run data get entity @s Pos[0] 10
execute store result score #ay br.tmp run data get entity @s Pos[1] 10
execute store result score #az br.tmp run data get entity @s Pos[2] 10
scoreboard players set #amv br.tmp 0
execute unless score #ax br.tmp = @s br.a_px run scoreboard players set #amv br.tmp 1
execute unless score #ay br.tmp = @s br.a_py run scoreboard players set #amv br.tmp 1
execute unless score #az br.tmp = @s br.a_pz run scoreboard players set #amv br.tmp 1
scoreboard players operation @s br.a_px = #ax br.tmp
scoreboard players operation @s br.a_py = #ay br.tmp
scoreboard players operation @s br.a_pz = #az br.tmp
execute if score #amv br.tmp matches 1 run scoreboard players set @s br.a_afk 0
execute if score #amv br.tmp matches 0 if score #time br.time matches 1200.. run scoreboard players add @s br.a_afk 1
execute if score @s br.a_afk matches 30.. run function oa:ach/give {id:"afk",name:"一旦離席"}
