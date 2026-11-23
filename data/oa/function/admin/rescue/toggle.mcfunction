# 1.9.242：初心者救済モードの切り替え（oa.admin 160・管理ブック）
execute if score #rescue br.flag matches 1 run return run function oa:admin/rescue/off
function oa:admin/rescue/on
