# 1.9.216 未使用処理の整理

公開・互換用コマンドを起点に加え、JSONの呼び出し、Javaの動的パス、マクロの実引数から到達性を照合。以下160関数は現行の起点から呼ばれない、廃止したHUD用タグだけを更新する、または空の関数であるため削除した。自動検査だけで削除を決めず内容も確認した。

保存済みの属性を解除する移行処理、旧コマンド名、手動登録、旧アイテムで使うリソースは互換性のため維持。プラグインのライフサイクル・イベント・レンダラーのコールバックも使用中のため維持。

旧装飾専用の scripts/gen_lobby_decor_1_9_102.py と gen_lobby_decor_1_9_162.py も削除。source/ 配下の一度限りの過去版移行スクリプト、変更履歴、過去の配布ZIPは履歴資料として保持する。

削除関数：

- `oa:ach/armor_check`
- `oa:br/finale/burst_at`
- `oa:br/finale/burst_pick`
- `oa:br/finale/lamps_off`
- `oa:br/live_spread`
- `oa:br/locator/hide`
- `oa:br/locator/killing`
- `oa:br/locator/player`
- `oa:br/locator/show`
- `oa:br/mining/player`
- `oa:br/mining/ray`
- `oa:br/solo_spawn`
- `oa:br/spawn_check`
- `oa:br/spawn_failed`
- `oa:br/spawn_marker`
- `oa:br/spawn_points/place`
- `oa:br/spawn_points/verify`
- `oa:br/spawn_reroll`
- `oa:br/spawn_retry`
- `oa:br/spawn_scan`
- `oa:br/spawn_validate`
- `oa:br/zone/center_x`
- `oa:br/zone/center_z`
- `oa:br/zone/column`
- `oa:curse/radar/reselect`
- `oa:curse/radar/select`
- `oa:debug/gacha/11`
- `oa:debug/gacha/13`
- `oa:debug/gacha/14`
- `oa:debug/gacha/15`
- `oa:debug/gacha/16`
- `oa:debug/gacha/18`
- `oa:debug/gacha/3`
- `oa:debug/gacha/5`
- `oa:debug/gacha/7`
- `oa:debug/gacha/8`
- `oa:debug/gacha/9`
- `oa:debug/gacha/bomb`
- `oa:debug/gacha/shuffle_one`
- `oa:debug/gacha/size_15`
- `oa:debug/gacha/size_8`
- `oa:debug/gacha/tp_list`
- `oa:debug/hat_hit`
- `oa:debug/hat_strike`
- `oa:debug/mob/blast_push`
- `oa:disaster/k10/msg`
- `oa:disaster/k11/msg`
- `oa:disaster/k8/msg`
- `oa:disaster/k9/msg`
- `oa:disaster/mob_summon_pig`
- `oa:disaster/phase`
- `oa:fish/prepare_jump`
- `oa:fish/restore_jump`
- `oa:fish/restore_macro`
- `oa:fish/water_state`
- `oa:fish/water_used`
- `oa:furoball/impact_block`
- `oa:furoball/push`
- `oa:furoball/push_once`
- `oa:furoball/save_push`
- `oa:itori/dive_drop`
- `oa:itori/dive_goal`
- `oa:itori/dive_step`
- `oa:itori/retired_boost_cleanup`
- `oa:knockback/start_throw`
- `oa:lobby/decor`
- `oa:lobby/decor_floor`
- `oa:lobby/decor_v162`
- `oa:lobby/gallery/button_press`
- `oa:lobby/gallery/button_release`
- `oa:lobby/gallery/itori_build`
- `oa:lobby/gallery/itori_ensure`
- `oa:lobby/refresh_displays`
- `oa:map/internal/read_center`
- `oa:status/finish_push`
- `oa:status/prepare_push`
- `oa:status/push_rotation`
- `oa:status/rotate_push`
- `oa:tayayuyu/bomb_all`
- `oa:tayayuyu/bomb_spawn`
- `oa:tayayuyu/hop`
- `oa:tayayuyu/hop_all`
- `oa:tayayuyu/hunger_all`
- `oa:tayayuyu/intro`
- `oa:tayayuyu/move/offset`
- `oa:tayayuyu/peace_all`
- `oa:tayayuyu/reveal_all`
- `oa:tayayuyu/shuffle`
- `oa:tayayuyu/speed`
- `oa:tayayuyu/speed_all`
- `oa:tayayuyu/stiff`
- `oa:tayayuyu/tiny_all`
- `oa:throwable/body`
- `oa:throwable/direction`
- `oa:throwable/hit`
- `oa:throwable/native_owner`
- `oa:throwable/owner`
- `oa:throwable/ray`
- `oa:throwable/tick`
- `oa:yuttari/save_push`

初期化・書き込みのみで参照されないスコア21種の処理も削除（保存済みのスコアを消すコマンドは追加しない）：

`br.member`, `br.wkc`, `br.wkk`, `oa.exbtn`, `oa.fhb`, `oa.fid`, `oa.ftime`, `oa.fup`, `oa.i_held`, `oa.i_sub`, `oa.i_uses`, `oa.kby`, `oa.life`, `oa.rclock`, `oa.rindex`, `oa.shade`, `oa.sonic`, `oa.sparko`, `oa.water`, `oa.wdelay`, `tdm.slot`

仮スコアの未参照書き込み：`#3`, `#sonic`, `#ambush`, `#breath`, `#chance`, `#dis_last`, `#g_jp_by`, `#gacha_event`, `#refill`。レーダーの方角（east/south/rx/rz）・dim/compare/viewer_dimも表示・判定に使わないため、その計算を削除。チャットの座標・ワールド名、アクションバーの最寄り距離は維持する。

空の関数と呼び出しも削除（タイルの水設置59個・旧通算加算1個）。水のあるタイルの設置処理、チャンクの解放・次区画への進行は維持する。生成元も空の水関数を作らないよう修正。

- `oa:br/stats/add`
- `oa:map/internal/tiles/water/0`
- `oa:map/internal/tiles/water/1`
- `oa:map/internal/tiles/water/10`
- `oa:map/internal/tiles/water/11`
- `oa:map/internal/tiles/water/12`
- `oa:map/internal/tiles/water/13`
- `oa:map/internal/tiles/water/14`
- `oa:map/internal/tiles/water/15`
- `oa:map/internal/tiles/water/16`
- `oa:map/internal/tiles/water/17`
- `oa:map/internal/tiles/water/18`
- `oa:map/internal/tiles/water/19`
- `oa:map/internal/tiles/water/2`
- `oa:map/internal/tiles/water/20`
- `oa:map/internal/tiles/water/21`
- `oa:map/internal/tiles/water/22`
- `oa:map/internal/tiles/water/23`
- `oa:map/internal/tiles/water/26`
- `oa:map/internal/tiles/water/27`
- `oa:map/internal/tiles/water/28`
- `oa:map/internal/tiles/water/29`
- `oa:map/internal/tiles/water/3`
- `oa:map/internal/tiles/water/30`
- `oa:map/internal/tiles/water/31`
- `oa:map/internal/tiles/water/32`
- `oa:map/internal/tiles/water/36`
- `oa:map/internal/tiles/water/37`
- `oa:map/internal/tiles/water/38`
- `oa:map/internal/tiles/water/39`
- `oa:map/internal/tiles/water/4`
- `oa:map/internal/tiles/water/40`
- `oa:map/internal/tiles/water/42`
- `oa:map/internal/tiles/water/43`
- `oa:map/internal/tiles/water/46`
- `oa:map/internal/tiles/water/47`
- `oa:map/internal/tiles/water/48`
- `oa:map/internal/tiles/water/49`
- `oa:map/internal/tiles/water/5`
- `oa:map/internal/tiles/water/50`
- `oa:map/internal/tiles/water/51`
- `oa:map/internal/tiles/water/52`
- `oa:map/internal/tiles/water/53`
- `oa:map/internal/tiles/water/56`
- `oa:map/internal/tiles/water/57`
- `oa:map/internal/tiles/water/58`
- `oa:map/internal/tiles/water/59`
- `oa:map/internal/tiles/water/6`
- `oa:map/internal/tiles/water/60`
- `oa:map/internal/tiles/water/62`
- `oa:map/internal/tiles/water/63`
- `oa:map/internal/tiles/water/64`
- `oa:map/internal/tiles/water/65`
- `oa:map/internal/tiles/water/66`
- `oa:map/internal/tiles/water/67`
- `oa:map/internal/tiles/water/68`
- `oa:map/internal/tiles/water/69`
- `oa:map/internal/tiles/water/7`
- `oa:map/internal/tiles/water/8`
- `oa:map/internal/tiles/water/9`
