tellraw @a[tag=br.admin] {text:"配置TPに失敗したため開始を中止し、所持品を復元します。",color:"red"}
function oa:br/finish
execute in oa:br run kill @e[distance=0..,tag=br.spawn]
