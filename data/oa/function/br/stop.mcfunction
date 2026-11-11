execute if score #busy br.clean matches 1 if score #state br.state matches 4 run return run function oa:br/cleanup/abort
execute if score #busy br.clean matches 1 run return run tellraw @s {text:"終了後の清掃中です。完了までお待ちください",color:"yellow"}
execute if score #state br.state matches 1 run tellraw @a[tag=br.playing] {text:"管理者が試合を中止しました",color:"yellow"}
function oa:br/finish
