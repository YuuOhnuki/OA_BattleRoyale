# 1.9.260: 1.9.146〜1.9.171 の旧武器の書き換え（melee_fish・melee_staple・staple_upgrade・tayayuyu_upgrade）は削除。
# 固有武器はすべて give/internal/* で作られ、作る時点で同じ書き換えを済ませている（試合をまたいで残らない）。item_modifier の JSON は give が使うので残す
function oa:inventory/refill_damage
