# 1.9.186: 管理者が対象を「参加しない（ロビーで待つ）」にする（プラグインの管理メニューから、対象として）
execute unless score #state br.state matches 0 run return run tellraw @a[tag=oa.roster_actor] {text:"試合中は離脱にできません（観戦にしてください）。",color:"yellow"}
function oa:br/sit_out
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を不参加（ロビーで待つ）にしました。",color:"gray"}]
