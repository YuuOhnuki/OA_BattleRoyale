scoreboard players set #mode oa.map2 2
scoreboard players set #tile oa.map2 0
data modify storage oa_map2:args tile set value 0
tellraw @a {text:"[OA Map 305] 地形・登録完了。最後に海水を配置します",color:"aqua"}
schedule function oa:map/internal/job/next 1t replace
