execute if score #map oa.mapid matches 0 in oa:br store result score #shown_width br.tmp run worldborder get
execute if score #map oa.mapid matches 1 in oa:br_nether store result score #shown_width br.tmp run worldborder get
scoreboard players set #remaining br.tmp 600
scoreboard players operation #remaining br.tmp -= #sec br.sec
execute if score #remaining br.tmp matches ..-1 run scoreboard players set #remaining br.tmp 0
data modify storage oa:br_ui state set value "待機中"
execute if score #shrinking br.flag matches 1 run data modify storage oa:br_ui state set value "収縮中"
execute if score #sec br.sec matches 600.. run data modify storage oa:br_ui state set value "延長戦"
execute store result storage oa:br_ui phase int 1 run scoreboard players get #phase br.tmp
execute store result storage oa:br_ui alive int 1 run scoreboard players get #alive br.live
execute store result storage oa:br_ui width int 1 run scoreboard players get #shown_width br.tmp
scoreboard players operation #m br.tmp = #next br.tmp
scoreboard players operation #s br.tmp = #next br.tmp
scoreboard players operation #m br.tmp /= #60 br.tmp
scoreboard players operation #s br.tmp %= #60 br.tmp
execute store result storage oa:br_ui next_m int 1 run scoreboard players get #m br.tmp
execute store result storage oa:br_ui next_s int 1 run scoreboard players get #s br.tmp
data modify storage oa:br_ui next_pad set value ""
execute if score #s br.tmp matches ..9 run data modify storage oa:br_ui next_pad set value "0"
scoreboard players operation #m br.tmp = #remaining br.tmp
scoreboard players operation #s br.tmp = #remaining br.tmp
scoreboard players operation #m br.tmp /= #60 br.tmp
scoreboard players operation #s br.tmp %= #60 br.tmp
execute store result storage oa:br_ui left_m int 1 run scoreboard players get #m br.tmp
execute store result storage oa:br_ui left_s int 1 run scoreboard players get #s br.tmp
data modify storage oa:br_ui left_pad set value ""
execute if score #s br.tmp matches ..9 run data modify storage oa:br_ui left_pad set value "0"
data modify storage oa:br_ui view set value 0
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 1
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 2
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 3
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 4
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 5
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 6
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 7
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 8
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 9
function oa:br/ui/rows with storage oa:br_ui
data modify storage oa:br_ui view set value 10
function oa:br/ui/rows with storage oa:br_ui
