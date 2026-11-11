execute if score @s br.saved matches 1 run return run tellraw @a[tag=oa.roster_actor] {text:"所持品の復元待ちです。復元完了後に操作してください。",color:"yellow"}
function oa:br/join
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を参加登録しました。",color:"green"}]
