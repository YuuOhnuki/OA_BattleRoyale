execute if score #state br.state matches 1.. run return 0
$data modify storage oa:br border_restore set value {x:$(x),z:$(z),damage:$(damage)}
tellraw @s {text:"終了後に戻すボーダー中心・ダメージ量を登録しました。幅は試合開始時に取得します",color:"green"}
