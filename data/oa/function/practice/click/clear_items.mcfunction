# 1.9.162: 練習場メニューの「持ち物を消す」（oa.lobby 208）。装備・持ち物を消し、固有武器の効果を解除して、メニューの本と案内の本を配り直す
function oa:itori/effects_end
function oa:internal/cleanup
function oa:status/reset
function oa:br/clear_inventory
effect give @s minecraft:resistance infinite 4 true
function oa:lobby/guide/book
function oa:practice/book
playsound minecraft:item.bundle.drop_contents player @s ~ ~ ~ 0.8 1
tellraw @s {text:"持ち物を消しました（練習場メニューと案内の本は配り直しました）。",color:"green"}
