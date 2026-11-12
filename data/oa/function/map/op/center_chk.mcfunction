$execute if dimension $(dim) run function oa:br/center
$execute unless dimension $(dim) run tellraw @s {text:"このマップのディメンション内で実行してください（先に「中心へ移動」で入ります）。",color:"red"}
