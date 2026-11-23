# 生成: scripts/build_map_sky.py（直接編集しない）
data modify storage oa_map2:job working set value 0b
scoreboard players set #state oa.map2 2
function oa:map/internal/save_cur {key:"sky"}
tellraw @a[tag=br.admin] {text:"[天空島] テンプレート配置に失敗しました。完成扱いにせず停止しました。ログを確認して再生成してください。",color:"red"}
