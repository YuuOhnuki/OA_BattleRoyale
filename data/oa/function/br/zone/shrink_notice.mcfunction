# 1.9.213: 安置の収縮中の知らせ（ボスバーには出さず、チャットに。br/tick から毎tick）。残り30秒・残り10秒・収縮完了
execute if score #time br.time matches 3000 run function oa:br/zone/shrink_msg {left:"残り30秒"}
execute if score #time br.time matches 3400 run function oa:br/zone/shrink_msg {left:"残り10秒"}
execute if score #time br.time matches 3600 run function oa:br/zone/shrink_done
execute if score #time br.time matches 5400 run function oa:br/zone/shrink_msg {left:"残り30秒"}
execute if score #time br.time matches 5800 run function oa:br/zone/shrink_msg {left:"残り10秒"}
execute if score #time br.time matches 6000 run function oa:br/zone/shrink_done
execute if score #time br.time matches 7800 run function oa:br/zone/shrink_msg {left:"残り30秒"}
execute if score #time br.time matches 8200 run function oa:br/zone/shrink_msg {left:"残り10秒"}
execute if score #time br.time matches 8400 run function oa:br/zone/shrink_done
execute if score #time br.time matches 11400 run function oa:br/zone/shrink_msg {left:"残り30秒"}
execute if score #time br.time matches 11800 run function oa:br/zone/shrink_msg {left:"残り10秒"}
execute if score #time br.time matches 12000 run function oa:br/zone/shrink_done
execute if score #time br.time matches 12600 run function oa:br/zone/shrink_msg {left:"残り30秒"}
execute if score #time br.time matches 13000 run function oa:br/zone/shrink_msg {left:"残り10秒"}
execute if score #time br.time matches 13200 run function oa:br/zone/shrink_done
