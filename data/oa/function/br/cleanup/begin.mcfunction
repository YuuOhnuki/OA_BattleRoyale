scoreboard players set #busy br.clean 1
scoreboard players set #quad br.clean 0
scoreboard players set #sixteen br.clean 16
scoreboard players set #abort br.clean 0
data modify storage oa:cleanup forced set value []
function oa:br/cleanup/read_origin
tellraw @a[tag=br.admin] {text:"[OA] マップ内の落とし物を清掃中…未読込区画を順番に読み込みます",color:"yellow"}
function oa:br/cleanup/tile
