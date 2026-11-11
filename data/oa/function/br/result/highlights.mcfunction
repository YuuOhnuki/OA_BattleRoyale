tellraw @a[tag=oa.res_view] {text:"━━ ハイライト ━━",color:"light_purple",bold:true}
function oa:br/result/award {obj:"br.st_kill",label:"キルキング",color:"red",unit:"キル"}
function oa:br/result/award {obj:"br.st_tmp",label:"ダメージ王",color:"gold",unit:" ダメージ"}
function oa:br/result/award {obj:"br.st_dist",label:"マラソンマン",color:"aqua",unit:"m"}
function oa:br/result/award {obj:"br.st_open",label:"トレジャーハンター",color:"green",unit:"個開封"}
function oa:br/result/award {obj:"br.st_jmp",label:"ジャンプ王",color:"yellow",unit:"回"}
scoreboard players set #hmax br.tmp 0
execute as @a[tag=oa.last_result,tag=!br.winner] if score @s br.surv > #hmax br.tmp run scoreboard players operation #hmax br.tmp = @s br.surv
execute if score #hmax br.tmp matches 1.. as @a[tag=oa.last_result,tag=!br.winner] if score @s br.surv = #hmax br.tmp run tag @s add oa.hl_tmp
execute if score #hmax br.tmp matches 1.. run scoreboard players operation #hmax br.tmp /= #20 br.tmp
execute if score #hmax br.tmp matches 1.. run tellraw @a[tag=oa.res_view] [{text:" ◆ 粘りの人：",color:"light_purple"},{selector:"@a[tag=oa.hl_tmp]",color:"white"},{text:"  ",color:"gray"},{score:{name:"#hmax",objective:"br.tmp"},color:"yellow"},{text:"秒生存",color:"gray"}]
tag @a remove oa.hl_tmp
