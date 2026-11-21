# 引き継ぎメモ（1.9.208 時点）

## 現状
- 1.9.208：医療品の説明更新だけに付くmedical_textフラグで生成直後と差があった。共通compにmedical_text208を含め、全lootへdeepcopy、modifierも同じcompだけを設定。採掘側と所持更新側のデータ一致を保つこと。ユーザー確認で対象は医療品。石炭の通常食料は元からチェストと同じ設定。実際の採掘操作は未確認。出血2/20tick、地図表示の着地判定は変更なし。

- 1.9.207：全員outline=False。5人の文字色を明るく変更。gen_weapon_presentationのJSONコンポーネント更新はfont/shadow等も除去し、地面ラベルの生成ブロックを毎回置き換える。古い白縁用アセットは互換用に残るが参照しない。性能・モデル変更なし。実クライアント描画は未確認。

- 1.9.206：共通fields/namedとgen_weapon_presentation.pyで説明順・色・白縁を生成。TDM HUDはマクロ文字列でなくinterpret付きコンポーネント。白縁フォントは色焼き込みのため文字色をwhiteにし、親の色を継承させない。実クライアントの描画は未確認。

- 1.9.205：rich/UnitTextはアイコン個数のみ。共通fields()でゆーの通常攻撃と右クリック、ふろっしゅの通常攻撃を省略。description205系の版印で既存品も更新。

- 1.9.204：weapon_catalog.py→gen_weapon_text.pyが説明の正本。タグdescription204/description_up、name_v204、itori_text204で既存品も更新。melee_*の実値は変更せずrefill_damage後にloreを更新。いとりは独立した通常ダメージ条件と同じ判定で表示＋1を切替。
- カスタムデータの版フラグは必ず1b（intの1だと既存の述語1bに一致せず毎tick更新になる）。進行度はintで保持。

- 1.9.203：ロビーを空間構成から再設計（出撃ターミナル v203）。生成元は scripts/gen_lobby_terminal.py（＋lobby_models.py で武器モデルの見かけの中心、render_lobby_preview.py でプレビュー）。生成時に、主通路・端末前の到達・当たり判定の重なり・ブロック光（舗装9／芝生7／端末前13以上）・浮き・ガラス板／柵／塀の接続を検査し、失敗すると書き出さない。範囲は1.9.202と同じ X/Z±40・Y-3〜+44。印は origin.terminal:203、202は tick_202 のまま。203では board/tick・gallery/update(46→terminal/refresh)・update_skins(51)・tdm/lobby_build が旧設備を作らない。
- 受付端末は interaction タグ oa.term.<action>。処理はプラグイン PlayerMenu.terminal（本人＝クリックしたプレイヤー）。DP側の入口は lobby/terminal/br_team・tdm_team・set_format・start_br・start_tdm（モード違いは拒否）。BR形式は #pref br.mode（load で 0 に初期化）。
- 表示の文字はプラグイン LobbyBoards が更新（oa.screen.*・oa.terminal.*・oa.gallery.*）。戦績ギャラリーは StatsStore の全期間と前回の試合、実績は oa.t_ach。DPの戦績ボード（board/*）は203では動かない。
- 一般化：text_display の大きさ1は1行が約0.25ブロック（1px=1/40ブロック）。看板の文字は離れて読む距離から大きさを決める（1.9.202の端末の文字は0.4〜0.7で小さすぎた）。
- 一般化：整数座標の `positioned X Y Z` は X/Z がブロック中心（+0.5）になる。ブロック（fill/setblock の ~）は影響しないが、summon した表示・当たり判定は0.5ずれる。lobby/build は `align xyz` を通す（1.9.202 までの表示も0.5ずれていた。tools/lobby_check.py の位置検査で発見）。
- 一般化：26.3 では chain → iron_chain。旧名の fill/setblock は関数ごと読み込めない（check_release.py が検出）。
- 一般化：テスト用サーバーの起動ログの oshi（Windows の性能カウンタ）の ERROR はデータパックと無関係。
- 生成試験でtext/item_displayのtransformationはscaleだけではSerialization errorsになることを確認。translationと左右のquaternionも生成元で明示し、再生成で警告なしを確認。起動だけではsummon時の不備は見えない。

- 1.9.202：lobby/buildはgen_lobby_terminal.py生成のterminal/buildのみ。save_originのterminal:202で新tickへ分岐し、旧gallery/map_labels/練習ゲート/羊毛パッドの再生成を避ける。旧ロビーは手動再建まで旧tick。右ギャラリーへboard処理を原点+26X/+20Zで移設。
- PlayerMenuは /oa とinteractionの実クリック者を使う。oa.ui=1で一般画面へ。旧公開triggerやbr.pick/tdm.teamは維持。map/selectは登録ホストも選択だけ許可。生成・削除は管理者のmap/doのまま。
- 本はgen_player_book.py、管理本はgen_admin_book.py→gen_admin_terminal_book.py。admin/book_contentはmode/map/stateのマクロ、取得時の状態と明記。

- 1.9.201：キル時tdm.foodはキル差分×8。heal_takeはHP10＋tdm.food10。foodLevelの実値も見て、HP・満腹度の両方満タンの場合だけ消費しない。既存プラグイン0.20.0が2tickごとに上限20まで加算。

- 1.9.200：TDMの開始時title times 0/25/0が終了まで残るため、finishで5/60/10に明示。冒険モードの待機者はcombat/select_targetsで除外し、yuttari/use・returnにも待機ガード、clean_playerで保存原点と入力を破棄。
- TdmMenuは固有item_model付き8アイコンを2段配置。管理操作は試合前のbr.host/br.adminだけに表示・実行。warmup中も選択可能、開始時tdm.ui=1。選択の許可はDP側も一致。
- OverworkServiceはインベントリ発動時、復活statusより先にクライアントだけへ実物ゆーを手のスロットに送信し、次tick実スロットを再送。実在庫・手持ちは移動せず、消費は従来どおり1個。
- BR順位は保存するMatchResultと同じ2＋長く生存した非優勝者数。jackpot_titleは優勝者だけへ送り、敗者の順位を上書きしない。

- 1.9.199：oni_hatを実際のTNT頭装備へ変更。inventory/dropで元の頭を落とし、失敗時は上書きしない。oa_tnt_oniタグの固定装備。oni_dropで自前TNTのみ消し、equip_curse/equip_yuua/equipは鬼の間停止。curse/tickは本当にマスクを装着している時だけ走り、TNTへマスクのモデルを上書きしない。
- キリング：enchantment/curseのdamage_immunityを削除して通常攻撃をプラグインcombat/KillingParryで止め、curse/rollを呼ぶ。oa.curse_guardの既存抽選を共有、oa.routed_damageはDP側へ任せる。保護キャンセル後のHIGHEST/ignoreCancelledでパリィの誤発火を防ぐ。必ずプラグイン0.19.0を先に配置し、ペアで反映する。
- TDM再生IV/速度II5秒、tdm.healをプラグインで実HPへ加算して10HPを保証。loadoutは#warmup>0の間は選択武器を配らず、warmup終了時に配布。
- 1.9.198：補給spawnからbr/supply/unique（固有10種、ゆー除外、ゆうあ1個制限）を必ず1回呼ぶ。元気百倍はhealth_revealを全生存者へ10秒、強化は従来どおり使用者だけ。TNT鬼はoni_revealを開始時と毎秒呼び、oa.goni_glowをoni_resetで解除。鬼の押しつけでは全員発光を消さない。
- ゆー：プラグイン0.18.0 weapon/OverworkServiceが手のトーテムなしでキャンセル初期値のEntityResurrectEventを受け、通常インベントリのoa_overwork付きトーテム1個を消費して復活を許可。overwork/usedで従来の2tick待ちへ接続。手にトーテムがある場合は介入しない。PaperのLivingEntityバイトコードで、手にない場合も復活イベント・既定トーテム効果が使われ、used_totem進捗は実物がある場合だけ発火することを確認。実際の致死イベントでの試験は未実施。
- 1.9.197：TDM HUD（hud_player→hud_lineマクロ、保有武器とCT）、回復ドロップ104=4HP、キル時の再生II/速度II/tdm.food+4。満腹度の実数加算はプラグイン0.17.0 TdmMenu。地面はシフトで武器交換し、drop_fromが実アイテムをtdm.savedのitem_displayへコピー。tdm.dropidで本体と名前表示を対応させremoveで両方を消す。tdm.lock=20、tdm.swap_latchedで即時拾い直しを防止。
- マップ#ready=197、生成元gen_tdm_map_v197.py。専用dimension_type oa:tdm（ambient_light0.25）、光源・看板・2方向から登れる整備通路。151候補の静的検査。勝利の音・粒子はロビーへ戻った2tick後に再生。マクロのname/slotとstorageを目視で照合。
- 1.9.196：nero/saveのdimension分岐にoa:tdmがなく、TDM位置がoverworldとして保存されていた。ネロ帰還の境界拒否とゆったり帰還の誤ディメンションにつながる。プラグインNeroMarkServiceもTDMを境界判定の対象外にしていたため対応。死亡時のクライアント再出現はプラグインTdmMenuのPlayerRespawnEventでTDM待機室へ固定し、lobby/login_warpもtdm.playerを除外。
- TDM: GUIはプラグインtdm/TdmMenu、ゲーム本体はデータパックtdm/*。tdm.ui=1でGUI、tdm.wait=200tick、#warmup tdm.sys=200tick、マップ#ready=196。新会場生成元scripts/gen_tdm_map_v196.py（既存gen_tdm_map.pyから起動）。155出現候補・通常移動経路を静的検査。標準装備とキルごと矢5本、重み付きランダム出現、ゆうあ150秒、ゆー不定期。
- 一般化：共通の位置保存・プラグインのディメンション判定・バニラの復活イベントも新ディメンション追加時の点検対象。起動できることはTPや復活が正常である証拠にはならない。
- 1.9.195：TDMを追加。tdm/*が進行・武器選択・拾得・復活・得点を担当。#game oa.game（0=BR/1=TDM）は選択、#active tdm.sysは進行中。br.state=1とbr.playing/br.aliveを武器・参加保護用に共用するが、BRのtick/loot/終了判定は入口で分岐する。BRの保存ID・br.pickは維持。専用dimensionはoa:tdm、マップ生成元はscripts/gen_tdm_map.py。
- 新ディメンションを足すときは武器のマクロ内のディメンション列挙（特にnero/return_live・clear_mark、internal/clear_owned、itoriの演出解除）も足す。TDMではBR境界判定を使わない。プラグイン側はTDMの地図配布除外と味方発光に対応（0.15.0）。
- 検証はユーザー指示により静的・起動チェックまで。試合進行・マップの実地確認は未確認。
- 1.9.194：武器調整。inventory/refill_damageで主手の数値を試合状態に合わせて置換し、加算の重複・練習場への持ち越しを防ぐ。いとりはnormal_damageで補充後の基礎値を3HPに。
- 1.9.193：大爆発（tayayuyu/blast）に「たやゆゆの負け」のタイトル。大当たりのタイトルは win_solo/win_team から 20 tick 後。
- 1.9.192：ガチャに時限爆弾（tayayuyu/oni_*、tick → oni_tick、#g_oni 残り tick、頭のTNTは item_display oa.g_oni_hat を毎 tick 目の上へ tp、押しつけは進捗 oa:tayayuyu/oni_pass＝鬼に直接殴られた人）と大爆発（blast、oa:gacha_blast）。抽選は1〜1500。大当たりのタイトルは win_solo/win_team から schedule。
- 1.9.191：たやゆゆのガチャを入れ替え（spec §7.3）。抽選 tayayuyu/roll（1〜1300、≤13 が大当たり14）、実行 tayayuyu/apply、テスト tayayuyu/test・force・test_menu。TNTの雨は br/second → tnt_second、降るTNT（タグ oa.g_tnt）は world_tick → tnt_tick。災害コンボは disaster/combo/*（#dc1〜6 に種類ごとの残り秒、#dis_left を一時的に入れ替えて kN/second を呼ぶ）。復活のお面は ach/new_kill → revive_rearm（タグ oa.g_revived）。爆速の止まれない動きはプラグイン 0.14.0 の RushService。
- 1.9.190：practice/enter の待機中の条件を外した（試合に出ていない人は試合中も入れる）。不参加パッド（brown_wool、ロビー原点から x=-9〜-7・z=32〜34、lobby/tick で br/sit_out）。今あるロビーには lobby/pad_optout（ストレージ oa:lobby optout_pad）が1回置く。lobby/build にも追加。
- 1.9.189：エリア外の猶予2秒。br/zone/out_track（br/tick から5 tick ごと、br.outt に外にいる tick）、br/zone/player は br.outt 40 以上のときだけダメージ。
- 1.9.188：武器の毎 tick の処理をプラグイン 0.13.0 へ（weapon/FuroballService・NeroMarkService・RootHoldService・ItoriBoltService）。データパックに残すのは、出す（furoball/spawn・nero/mark_or_return・itori/bolt_spawn・hotchikisu/root_target）と当たったあと（furoball/explode・itori/bolt_hit・kill_effect）と粒。プラグインは当たったら `execute as <弾> at @s run function …` を呼ぶ。ふろボールは #f_owner・#f_team・oa.f_current をプラグインが用意。
- 1.9.187：ネロの印の目印 item_display（oa.nero_vis、oa.id＝持ち主、oa.mvis が0で消える。プラグインの OwnerOnlyVisibility が本人以外から隠す）、mark_tick の粒は常時 oa.mark_owner に。nero/return は oa.stapled なら release_root してから飛ぶ。ぴちぴちの fish/fall_guard（fall_damage_multiplier oa:fish_fall、predicate oa:airborne、oa.ffall）。combat/select_targets は debug/select_targets のあとに模擬戦の相手を足す（debug 側が最初に全部消すため）。debug/furo_pool・itori/bolt_step に模擬戦の相手。
- 1.9.186：参加しない印 br.optout（br/leave で付き br/join で外れる。lobby/tick の自動登録は除外、br/team/select は未登録なら br/join）。admin/players/sit_out・set_team {n}・clear_team、admin/reset/*（プラグインから本人として呼ぶ）。試合開始の案内は br/intro → 初心者サポート → br/intro_end。お題のごほうび loot oa:br/medkit。ふろボールの打ち返し：interaction の当たり判定（oa.furo_hitbox、oa.fid で結ぶ、oa.fhb が0で消える）、furoball/deflect_check・deflect。バフ品 400tick・nutrition 5（印 buff_v1186）。補給 br/supply/far_check（#sup_min2）・cave_chest。毒霧 k4 は中心の目印1つ、半径 #fog_r。ネロの印 #flight 48・mark_step 0.25m×4・mark_clear（#oa:spawn_clear）・mark_climb（oa.mclimb）、粒は oa.mark_owner だけ。練習場 practice/vanilla/*、curse/radar はダミーも（@e[tag=oa.radar_target]）、enchantment/bat に debug_mob の分岐。tools/autoupdate/update.ps1 は applyMode restart（loadedSha・installedAt で置いただけかを見分ける）。
- 1.9.185：br/team/reset は br.pick を消さない（試合後も保つ）、cleanup/done・abort・br/restore の最後に br/team/sync。保護期間はソロでも oa_brgrace に入れない（live_join・tayayuyu/peace・revive も）、プレイヤー同士のダメージはプラグイン 0.9.0 の GraceProtection（EntityDamageByEntityEvent）。応急キットは consume 1秒・14HP・再生 I 10秒、印 kit_v1185（medical/upgrade）。medical/cap の上限は2tick後に cap_clear で外す（同じ tick に外すと即時回復が満タンまで効いていた）。yuua/strike の相手は @a（死んだプレイヤーは @e で選べない）。
- 1.9.184：即時リスポーン・実績メッセージ（br/start→finish・cleanup）とゆうあの死亡メッセージ（yuua/silence_*）をディメンションごとに設定（internal/gamerule_match・gamerule_all、引数 rule・value のマクロ）。保存・戻しはオーバーワールドの値。自然回復と br/world/* のスポーン系はまだ実行位置だけ。
- 1.9.183：ロケーターバーを全ディメンションで OFF（br/locator/all_off、毎秒 br/locator/tick から。true のワールドだけ書き換え）。Paper のゲームルールはワールドごと。同じ理由で、br/start の自然回復・即時リスポーン・実績メッセージ、ゆうあの show_death_messages、br/world/* のスポーン系は、実行位置（多くはオーバーワールド）にしか効いていない（未修正）。
- 1.9.182：軽量化。毎tick全員の持ち物の1マスずつの確認に、先頭で「対象の物がどこにもなければ return 0」の行（`items entity @s container.*` などのワイルドカード）。inventory/check のマスごとの処理は inventory/scan_slots、player_tick の oa.kind の11行は internal/kind_scan に移しただけ（順番も元のまま）。ground/pick は足もと1.5に拾える物がなければ終了、oa.pick の検索に type・distance。鉱石の点は br.ostg の4組に分けて1秒に1回＋生存者から8以内は5tickごと（ご褒美は7以内の人に渡すため）。測り方：テスト用サーバーで `tick query`（smoke_test.py の --max-mspt）と `/debug function oa:tick` → `oa_battleroyale_plugin/tools/trace_summary.py`。残る重いもの：ach/armor_check（毎秒1人50コマンド）、br/loot/chest_tick、br/zone/hud、br/ui/item_name。
- 1.9.181：通算（oa.t_games・t_win・t_kill）はプラグインの試合の記録が正本（br/stats/add で足さない、result/show で ach/stats_check を呼ばない。プラグインが書き込んで呼ぶ）。実績 yuua_sleep・killing_sleep は続けて30秒以上（br.a_w1/a_w5）。封印の宝珠の残り秒数の表示を1つずれていたのを修正（disaster/relic/pulse は dtmr/20、開始時に「あと5秒」）。
- 1.9.180：admin/players/live_join（途中参加）にも tp_fix（TP直後）と tp_fix_all（3tick後から10tickごと7回）、保存の前に internal/id。br/restore の保存データなし → br/restore_missing（br.retry=1 で毎tickのくり返しを止める）。admin/players/spawn_cave_try の高さ判定を体積の選択から Pos[1] のスコアに（大きさ0の防具立てが選ばれず洞窟の途中参加が毎回失敗）、admin/players/spawn の目印は生存者の位置に出す。実績 yuua_sleep・killing_sleep を被っている期間ごとに（br.a_k1/a_k5、oa.a_on1/a_on5）。どれもプラグインの自動テスト（途中参加の検査）で発見・確認。
- 1.9.179：1.9.178 の advancement/ach_trig/dqn.json が読み込めず、サーバーが起動しない不具合を修正。26.3 の entity_killed_player の player／entity は条件1つ（オブジェクト）で、配列は不可（Paper 26.3 のテスト用サーバーで発見・修正後に起動を確認）。
- 1.9.178：実績 tayayuyu_dqn。tayayuyu/hat_all で引いた本人に oa.dqn、advancement/ach_trig/dqn.json（entity_killed_player、倒した人の頭が kind:1）→ ach/trig/dqn。
- 1.9.177：lazi のマスクに防具力3・防具強度2（item_modifier visual/k3 の set_attributes、replace:false。印 mask_v1177 で既存品にも1回）。
- 1.9.176：lazi は CT2秒（oa.cd 40）、音波2HP、息切れ30%（oa.breath 40＝鈍足2秒）。1.9.175 の連続回数 oa.lzn は廃止（load からも削除。既存ワールドの目的は残るが未使用）。
- 1.9.175：lazi の音波4HP、抽選 息切れ25%／攻撃75%、攻撃4連続の次は息切れ（oa.lzn、load で作成、lazi/out_of_breath で0）。
- 1.9.174：ツルハシの can_break を固定（br/enter）、br/mining/player は廃止（return 0）。報酬は loot give、鉱石の位置のアイテムは tp で本人へ。洞窟の終盤演出を減らした。チェストの再補充の札の秒ずれは静的には原因不明（処理落ちを推定）。
- 1.9.173：実績の作り直し（表は scripts/gen_ach_1_9_123.py）。キルの相手が要る実績は、倒された側のタグ（oa.nm_*／oa.stapled／oa.tired）を条件にした進捗 advancement/ach_trig/*.json と、そのご褒美 function ach/trig/*（自分で進捗を取り消して何度でも判定）。毎秒の判定は ach/second（br/second から生存者ごと）、防具の破損は ach/armor_check（統計 minecraft.broken、目的 oa.ab0〜oa.ab24）。試合ごとの数は ach/reset（br/start の assign_pid）で0に戻す。
- 1.9.172：特別チェストの削減。地上はタイルの apply／water_apply の該当行を直接書き換え（register/chest ↔ chest_rich、loot chest_basic ↔ chest_site。地上のタイルは生成スクリプトで作り直さない）。ネザーは build_map_nether.py の最後で riches の一部を chests へ移す（_keep）。洞窟は build_map_cave.py の各配置の数と、祭壇・島の移し替え。
- 1.9.171：finale/step はマップ定義の y（全マップ 80）で演出関数を呼ぶ。洞窟は天井の上になるので finale/cave で 29 下げて finale/cave_at を呼ぶ。ランプ（神殿の床の輪 A/B/C と天井 D）は build_map_cave.py が置き、点滅の関数 maps/cave/finale_lamps・finale_all_on・finale_pillars も書き出す（神殿の床の立ち位置 y51 を原点とした相対座標）。br/finale/lamps_on（試合の終わり）に洞窟のランプを全部つける行を足した。地図パネルの描き直しは scripts/voxelize_tiles.py（地上のタイル関数→3D）と、リソースパックの source/build_lobby_map_*_1_9_39.py。
- 1.9.170：洞窟の古代都市（build_map_cave.py の「# 5 古代都市」の節、乱数 SEED+55）を作り直し：中央の4区画は広場、残りの区画に家・塔・廃墟。明るさは dimension_type の ambient_light 0.1 と、トンネル・エリアの明かりの確率。リソースパック 1.9.38（地図パネルの名前）。
- 1.9.169：ネザーの生成スクリプトの最後（到達性の検算の前）に、宝物庫の中庭の通常チェスト8を乱数なしで追加（変わるのは apply/place の 44・45・54 だけ）。洞窟は NCH=100・NORE=180（定数）、神殿の壁ぎわ8、中間の空洞3ずつ。マップ選択の文字は lobby/mapsel/labels（peek で行き先を探す。step_try と同じ順）。
- 1.9.168：特別チェストの最低保証（loot_table br/rich_iron を chest_site のプールに、chest_initial_late は rich のとき loot insert）。補給の着地後の光の柱（supply/fx の end_rod）を削除。マップ選択は前へ／次へ（lobby/mapsel/step・step_try、マーカー oa.mapsel_prev/next、文字 oa.mapsel_t_cur。マップを増やしたら step_try に1行足し、折り返しの数を直す）。左右は「パネルの前に立つと東が左」という推定で、前へ＝+x 側。
- 1.9.167：洞窟マップ（key `cave`、id 2、`oa:br_cave`）。生成は `scripts/build_map_cave.py`（2Dの「開いた場所・床・天井までの高さ・エリア」を描いてから3Dに起こす。床は隣と1段以内になるまでならす。到達性はBFSで検査）。地図パネルは `scripts/render_cave_panel.py`。マップごとの分岐は `#map oa.mapid matches 1 in oa:br_nether` の行を機械的に複製して `matches 2 in oa:br_cave` を足した（74ファイル112行）ほか、`unless dimension oa:br unless dimension oa:br_nether` に `unless dimension oa:br_cave` を足した。洞窟だけ動きを変えたのは：補給（launch_cave、place_try の under、ground_ok の頭上8、cave_fallback）、地面の武器（ground_try の under、random_ground の追加試行）、途中参加（admin/players/spawn_cave）、spawn_reroll、k3（warn_cave・impact_cave＝落盤）、finale/cave、pool/cave。`spreadplayers under` は岩だけの列では奈落（最低高度）に置くので、必ず床の判定で落とすこと。バリアを `#oa:spawn_unsafe_floor` に足した。
- 1.9.166：ぴちぴちの速度（oa:fish 1.5 add_multiplied_total）を廃止。ユーザーが v1.9.165.1（7101ee7）で fish/speed_upgrade の追加行を消し、active_changed の追加行も削除。外す処理（speed_upgrade・active_changed・cleanup の remove）は残す（古い付与を外すため）。
- 1.9.165：練習場の武器の名札の z を 14.5／18.5 → 15.5／19.5（台座のブロックの中心＝item_display と同じ）。1.9.161 以前から1ブロックずれていた。レイアウト版 1999。
- 1.9.164：ぴちぴちの激流を2に（fish_riptide_on.json）。所持中のアイテムを差し替えるため custom_data の目印を `{oa:{riptide1916:1b,rip2:1b}}` にして riptide_tick の判定も合わせた（この目印を変えないと、既存のトライデントが古いレベルのまま残る）。
- 1.9.163：k1/check・k2/check・k3/impact の屋根判定 `positioned over world_surface positioned ~ ~-40.9 ~ unless entity @s[dx=0,dy=40,dz=0]` は、箱が高さ41（dy+1）で上端が最上面+0.1 になり、外の人も常に「屋根の下」だった（1.9.131 から酸性雨・寒波、隕石群も同じ書き方でダメージなし）。−41.9 に直した。
- 1.9.162：ロビーの飾りは lobby/decor_v162（scripts/gen_lobby_decor_1_9_162.py で生成、build の decor の直後）。戦績ボードの行は `execute if entity @a[tag=oa.bsN]` 付きで召喚。ぴちぴちの跳躍 oa:fish_jump 0.5。練習場の台座は practice/build の各ブロック（11行ずつ）と showcase をずらし（平面図は build を Python でボクセルに展開して確認）、建物の名前の text_display を削除、レイアウト版 1998。練習場メニューの本は2ページ（custom_data practice_book_v162、古い本は practice/book で消して配り直す）、208＝practice/click/clear_items。
- 1.9.161：保護期間中のチームの名前表示を hideForOtherTeams に（br/grace/start）。補給の予告を tick 3900/6300/8700 に（br/loot/tick。中身の段階は preview の時刻範囲 ..6000/6001..8400/8401.. のまま合う）。災害は disaster/busy の秒の範囲では始めず、#dis_cd を0のまま待つ。補給の着地点は br/supply/place_try（spreadplayers を最大20回）→ ground_ok（#oa:supply_ground、#oa:spawn_clear で足・頭・上、前後左右2ブロック先の2段の段差。草の上なら ground_down で下げる）。特別チェストは chest_site の重み 上位2:通常3、chest_rare で当選率2倍。
- 1.9.160：特別チェスト（`br.rich`）に金色の粒（br/loot/chest_tick の末尾、0.5秒ごと）と、開封後の札「★ 特別チェスト／開封済み」。空中補給の落下範囲（br/supply/drop）を、縮小後のエリア（第1便 半分80、第2・3便 半分45）から10引いた値に。以前は予告の瞬間の #half（縮小開始時で、縮む前の大きさ）から8引いていた。
- 1.9.159：再補充までの残り時間を、チェストの名前から「開封済み」の札（text_display `br.open_label`）の2行目へ移した（br/loot/open_label が storage oa:br open_label を作り、open_label_all が毎秒札を書き換える。tick 7240 以降は書き換えない。特別チェストの札は `br.open_rich` で対象外。mark_open は `br.open_new` を付けて召喚直後に書き換える）。chest_tick の CustomName の書き換えはやめ、残った名前は br/finish と chest_initial で消す。災害のアクションバー（k1/hit・k2/hit・k4/zone・k5/shake）からダメージ量を外した。
- 1.9.158：1.9.157 は `ach/info` の2行目（`data modify storage oa:ach_info set value {}`、パスなし）が読み込みエラーで、本番の自動更新に巻き戻された（更新スクリプトの1件のエラーでも巻き戻す修正が正しく働いた）。生成スクリプトからその行を外し、`check_release.py` に「data modify のパスなし」の検査を追加。内容は 1.9.157 と同じ。
- 1.9.157：表示の改善。ゆーの名前を「ゆー：オーバーワーク」に。補給の便は「第N便 ★」だけ。「今回のお題」「達成するとごほうびがもらえます。」。開始の案内を3行に。通常チェストの名前（画面の題名）に再補充までの残り時間（br/loot/chest_title → chest_tick が1秒に1回 CustomName を書き換え、br/finish で消す）。実績の解除メッセージに説明のホバー（gen_ach が ach/info を書き出し、ach/give → ach/announce）。固有装備を拾ったお知らせに show_item のホバー（inventory/pick_notice。説明文を付けたあとに読み直す）。災害は3秒前から効果音だけでカウントダウン（disaster/warn）、チャットの説明は効果時間と一言だけ。ロビーの展示の看板は `oa.admin 46` で更新。
- 1.9.156：ネザーのチェストを約1.5倍（68→102：通常58→88、上位10→14）。`scripts/build_map_nether.py` の間引き（thin、1.9.119/1.9.120）をやめ、砦の廃墟の中央の東2マスに通常チェストを1つ追加。生成スクリプトは決定的で、変更前のコードで現行の出力を完全に再現できることを確かめてから変えた（地形の差は「空気→チェスト」34マスだけ）。ネザー会場の再生成が必要。地面の固有武器は序盤（tick 1200〜3600）も50%で追加の抽選（br/loot/ground_event）。
- 1.9.155：開始地点を地表にそろえる。登録は `br/spawn_points/add_find`（切り捨てた高さ→1つ上→1つ下→2つ下の順に `spawn_points/check`）。開始TP後の補正 `br/tp_fix` は、ブロック単位にそろえた高さで地表判定し、埋まっていれば上（tp_fix_up、最大80）、浮いていれば下（tp_fix_down、最大4）。`tp_position` でTP直後にも呼ぶ。「少し下にTPされる」原因はコード上では特定できていない（以前の判定は足と頭のブロックだけで、床の高さを見ていなかった）。
- 1.9.154：`br/spawn_points/add_here` の2行目で `tellraw @s` が抜けていた（1.9.141 で混入、`run return run [{text:…}]`）。関数ごと読み込めず、開始地点の登録が動かなかった。さらに自動更新が読み込みエラーで巻き戻すため、本番は 1.9.150〜1.9.153 が入らず 1.9.149 のままだった（1.9.141〜1.9.149 は `update.ps1` の `$errs[0].Trim()` の不具合で判定が落ち、誤りを含んだまま入っていた）。`tools/check_release.py` に「行頭と `run` の直後が実在するコマンドか」の検査を追加。`update.ps1` は `$errs = @(…)` に修正（サーバー側のコピーは手で差し替える）。補給の樽・鎖の `block_display` は 26.3 の新形式 `{id:…,properties:…}` に（1.9.134 の `{Name:…,Properties:…}` も誤りだった。本番ログの Serialization errors で判明）。
- 1.9.131：述語JSONは 26.3 では "condition" でなく "type" が必須。酸性雨・寒波の屋外判定は述語を使わず k1/check・k2/check（world_surface）で行う。
- 1.9.130：ハズレガチャ3種（critical/stiff/exposed）の冒頭で tayayuyu/self_glow を呼ぶ。発光の管理は oa.gglow。
- 1.9.129：開始地点の足元判定は #oa:spawn_unsafe_floor（不可）と #oa:spawn_clear（通れるブロックは不可）。br/spawn_points/check と br/spawn_check の2か所。
- 1.9.153：補給物資の矢印を、プレイヤーの向きから見た相対方向に変更（br/supply/guide_calc の末尾、guide_face のマクロでマーカーを物資へ向けて回転差を8方向に分ける）。
- 1.9.152：地震の判定を緩和（最初の2秒は無傷、移動は合計60cm/秒以上かジャンプ。k5/shake）。
- 1.9.151：災害を、合図（kN/warn、雷・タイトル・チャット）の5秒後に発生（disaster/warn → kN/start）に分けた。#dis_warn が待ち秒数。
- 1.9.150：1.9.148 の観戦者の救済（br/second）が at @s なしでディメンションを判定し、全観戦者を毎秒中心へ戻していた不具合を修正。
- 1.9.149：たやゆゆのガチャ復活の武器を、tick 7200 前は石の剣、以降は石の槍に分けた（tayayuyu/revive）。
- 1.9.148：ガチャ復活・途中参加後のソロ戦で oa_brsolo へ再加入（ネームタグ表示の修正）。観戦者がロビーに残る不具合を、internal/death と br/second（spec/return_center）で中心へ戻して修正。
- 1.9.147：脱落時の観戦の自動追従を廃止（br/spec/begin から spec/next の呼び出しを削除）。
- 1.9.146：たやゆゆのガチャ使用音を全参加者に聞こえるように（tayayuyu/use、各自の位置で再生）。
- 1.9.145：封印の宝珠の数を最大8→6（disaster/init の limit）。
- 1.9.144：封印の宝珠（disaster/relic/make）の発光（Glowing）を廃止。解錠中の光の柱（pulse）は残してある。
- 1.9.143：練習場でも参加登録（br.lobby）を保持。practice/enter で br.lobby を外さず、practice/leave は登録済みの人だけ br/join、br/start は練習場の参加者を practice/leave で復元してから開始。
- 1.9.142：空中補給の中身を回ごとに段階化（br/supply/preview で便を時刻から決定、spawn で中身）。ゆったりの押し出しを2倍（knockback/tick の kboost=2、4ステップ/tick）。
- 1.9.141：開始TP直後の地中埋まりを br/tp_fix_all で補正（真上の立てる場所へ）。開始地点の操作メッセージにマップ名を表示し、管理ブックの旧ページから開始地点ボタンを削除（地上／ネザーのページのみ）。
- 1.9.140：ゆーの地面の名前表示・演出は、perf/world_maintenance（5tickごと）と vclock 0（10tickごと）が重ならず動かないことがあったため、overwork/ground_init（タグ付与時に名前）＋world_tick の vclock 0 で演出に変更。
- 1.9.139：隕石（k3/impact）は屋根の下（world_surface 判定、k1/check と同じ）の生存者に当たらない。
- 1.9.138：「最大値を探す」処理は `execute as … if score @s X > #m run … operation #m = @s X` をやめ、`execute as … run … operation #m > @s X`（順序に依存しない書き方）に統一（戦績ボード・ハイライト・観戦の前後）。
- 1.9.137：チームの表示は名前の色だけ（br/team/setup の suffix は空）。
- 1.9.136：ロビーの「前回の試合結果」は生存時間→キルの順で並べ、番号を付ける（lobby/board/last_key、スコア br.lkey）。戦績・実績数は元から降順。
- 1.9.135：地震は統計（br.qwalk/qspr/qsneak/qjump）で「動いたらダメージ」。ゆーの地面アイテムは overwork/ground_init で拾得待ち解除＋ground の演出。
- 1.9.134：補給物資の block_display の block_state は、プロパティ付きは文字列でなく {Name,Properties} の形式（文字列だと Serialization errors）。
- 1.9.133：ギミック（間欠泉等）を廃止し、建物内の封印の宝珠（disaster/relic/）に置換。災害ダメージ増、警告のアクションバーは3秒交互（#dis_phase、br.dis_msg、br/ui/actionbar で通常バーを抑止）。無効化は #relic_off。
- 1.9.128：災害は data/oa/function/disaster/（second→begin→pool→kN/start、active→kN/second→end）。抽選プールはマップ定義の disasters。無効化は #dis_off（br.tmp）。印は tag br.dis のマーカー（br/finish と init で削除）。
- 1.9.127：観戦パッド（灰色の羊毛）は lobby/build.mcfunction の gray_wool の行（x=-13..-11, z=32..34）。判定は lobby/tick の足元ブロック。
- 1.9.126：ロビーの明かりは lobby/build.mcfunction の「1.9.125 明るさ」ブロック（シーランタンの帯と light ブロック）。ロビー更新で再構築される。
- 1.9.125：実績のタブは oa:ach/root の1つ。カテゴリは cat_br/cat_map/cat_weapon（枝の頭）。隠し実績は関連する枝の中。scripts/gen_ach_1_9_123.py の CATS と a(...) の親を編集して再実行する。
- 1.9.124：ロビーのチーム羊毛は lobby/build.mcfunction の「TEAM n」の行（地図手前 z=23/29）。選択判定は br/team/select の足元ブロック。旧位置の羊毛は消えないので、反映はロビー更新（oa.admin 14）で再構築する。
- 1.9.123：実績は scripts/gen_ach_1_9_123.py の表から advancement/ach・ach/list・count_ach・revoke_all を生成。新実績は表に足して再実行し、付与箇所（ach/give呼び出し）を実装する。練習場は ach/give 先頭のガードで無効。
- 1.9.122（**誤り。1.9.134 で訂正済み**）：プロパティ付きの block_state を文字列で書くとエラー（Serialization errors）になる。正しくは {Name:"minecraft:barrel",Properties:{facing:"up",open:"false"}} の形式。プロパティなしなら文字列でよい。
- 1.9.121：湧き許可は data/oa/tags/block/ground_spawn_surface.json と spawn_clear.json、loot/random_ground→ground_try（4回試行）。天候は defs の weather と br/weather/gate（#wx）。nbt の文字列表示は interpret:true。ロビーボードの更新時計 #bclock は board/tick が #perf=0 の1秒1回しか呼ばれないので閾値は5。練習場の本は practice/book、dispatch の oa.lobby 201〜207。
- 1.9.120：ネザー宝物庫は上位4つのみ、thin(chests,58)/thin(riches,10)。地上の起伏は R 60以内なし（damp）。再適用は git checkout 7704f35 -- data/oa/function/map/internal/tiles のあと build_map_1_9_117_relief.py。
- 1.9.119：補給3回（loot/tick）、補給案内30秒（supply/second の br.sup=..30）、ネザーのチェスト79（build_map_nether.py の thin()）、起伏は build_map_1_9_117_relief.py（replay版を git checkout 7704f35 -- tiles で戻してから適用）と nether relief() をなだらか＋建物ノールに、終盤演出を控えめに、ロビーボードは board_at で原点ずれを検知（board/check,move,clear）。
- 1.9.118：場所名の nbt 表示に interpret:true（引用符除去）。ネザー宝物庫の四隅の塔に屋根（build_map_nether.py）。
- 1.9.117：高低差（地上は scripts/build_map_1_9_117_relief.py が現行タイルをreplayして追記、1回だけ適用。ネザーは build_map_nether.py の relief()）。終盤演出は defs の finale → oa:finale/tick/step/exec、地上=finale/br、ネザー=finale/nether、既定=finale/default。昭心進行度は itori/progress_save・progress_restore（oa.ib_*）で練習場の出入りに退避・復元。lobby/center・warp の向きは南向き(0)。
- 1.9.116：ロビー中央の柱に埋まらないよう lobby/center の移動先を z+5.5 に。ロビーからのマップ選択（lobby/mapsel/*、stone_button 2個＋マーカー oa.button_mapsel、map_panel_update、sentinel oa.map_panel1116）。パネルは選択中のマップで item_model を切り替え（要リソースパック1.9.36）。
- 1.9.115：食料テーブル(br/food)の雪玉・卵・矢にスタック上限64を付与（チェストと同じ）。ネザーの鉱石を石炭(ore 1)・レッドストーン(ore 3)に変更。ore 5/6（クォーツ・金）の処理は互換のため残置。
- 1.9.114：空中補給の予告・降下の文言を変更（supply/preview, launch）。
- 1.9.113：ネザーのチェストを75→105（砦に上位1＋通常1、見張り塔に通常1）。補給物資のアクションバーは #sup_phase（br.tmp）で3秒ごとに通常バーと交互（supply/second と ui/actionbar）。
- 1.9.112：ネザーの大要塞（build_map_nether.py の FX,FZ,FH ブロック、チェスト75）、マップ別コマンド（map/do ＋ map/op/*、admin コード 60..71＝地上／80..91＝ネザー）、管理ブックは scripts/gen_admin_book.py で生成。
- 1.9.111：ネザーに建築物・障害物を追加（scripts/build_map_nether.py の rng2 ブロック）、版数のTAB表示と /trigger oa.ver、load_done メッセージ。version.mcfunction は先頭に oa.vtab 作成、末尾に storage と表示形式（版数を含む行）。
- 1.9.110：map/internal の root 直指定 data modify（select_load、load_saved、args_from_def）をキー単位のコピーに修正。
- 1.9.109：複数マップ基盤（map/internal/defs、select、create_nether）、ネザー会場（scripts/build_map_nether.py が maps/nether を生成）、固定参照の展開（scripts/multimap_expand.py）。検証・変更履歴は docs/changelog.md。
- 【最新】データパック 1.9.153 ＋ リソースパック 1.9.36（ネザー用ロビー地図パネル）
- データパック 1.9.108（`OA_BattleRoyale_v1.9.108.zip`）＋リソースパック 1.9.35（ロビー地図を再描画）。
- 1.9.99：遺跡の塔4基（scripts/build_map_1_9_99_towers.py）、実績20種を永続化、前回結果・実績一覧の trigger。`UPDATE_1_9_99_JA.md` 参照。
- 1.9.102：ロビー装飾（scripts/gen_lobby_decor_1_9_102.py）、洞窟入口・帆船（scripts/build_map_1_9_102_decor.py）、花火・補給・練習場モブ。リソースパックの地図画像は resourcepack/source/build_lobby_map_1_9_34.py で再生成。
- 1.9.100：チュートリアル／お題／初心者サポート／補給3種／戦績ボード／練習場の模擬戦・計測・射程レーン／雪原洞窟2・海中遺跡2（scripts/build_map_1_9_100_sites.py）。`UPDATE_1_9_100_JA.md` 参照。実機未検証点はそちらに記載。
- 1.9.98：リザルト、終盤の点滅と花火、空中補給、実績（キリング・ぴちぴち）。`UPDATE_1_9_98_JA.md` と `docs/roadmap.md` 参照。未実装は探索の報酬（E）と遊びやすさ（F）、他武器の実績。
- 1.9.97：中央広場のドーム骨組み、雪原の岩場化、草花・海草・ケルプの追加。詳細は `UPDATE_1_9_97_JA.md`。
- 検証は静的のみ（`VALIDATION_1_9_97.json` は全項目PASS）。**Java 26.3 の実サーバーでは未確認**。

## 未確認・要注意
- 26.3 のレジストリでのブロック名・状態の照合は未実施（waxed copper と short_grass は既存パックで使用済み、他は標準名）。
- ゲーム内スコアボードのバージョン表示は未観察（version.mcfunction の11行を静的に更新）。
- ドーム直下（広場の約29%）は雨が当たらない。
- 草花マスは地面アイテムのドロップ地点から外れる（地表の数%）。
- ジャンプ台の射線が支柱に当たる場合がある。
- `docs/spec.md` と `docs/discord-game-guide.md` は今回初めて作った。内容は実装から拾った要約なので、実装との照合を推奨。

## マップ生成の仕組み
- 100個のタイル関数：`tiles/place/N`（ブロック）、`tiles/water/N`（水）、`tiles/apply/N`（チェスト・鉱石登録）、`delete/apply/N`（削除）。`oa:map/rebuild` は place を再実行する。
- 本パックはこれらの関数に差分行を挿入する方式。ドームの高さ（Y+29まで）のため、フレームのあるタイル 34,43,44,45,54,55 の place と delete に `fill ... ~30 ... air` を追加済み。fill上限32768以内（最大30720）。

## スクリプト（scripts/）
- `build_map_1_9_97.py`：v1.9.96 のタイル関数をボクセルに再生し、ドーム・雪・植生・海を適用して差分行を出力。目標モデル `map_1_9_97_target.npz` を書く。
- `validate_map_1_9_97.py`：新パックを再生して目標と比較。保護セル、隣接、構文、fill体積、到達距離を検査。
- `finalize_1_9_97.py`：バージョン更新（pack.mcmeta、version.mcfunction、README）、MAP_MANIFEST、MAP_OVERVIEW.png。
- 実行順：クリーンな旧版を複製→build→validate→finalize。スクリプトは展開済みパック内の `source/` から動かす前提で、**パスは作業環境に合わせて直す必要がある**。
- `tools/` はボクセル再生と上面描画、`work/` はドームの試作と3Dプレビュー。

## 設計の数値
- ドーム：支柱8本(2x2、18°+45°×j)、リング r=25/17/9、K 22..39、頂点Y+29。
- 縦移動の到達：ぴちぴち6.13、パイモン併用8.43、ふろボール10.087、ヴァレサ約4。枠の最低足場は床+12（差11）。
- ジャンプ台27、チェスト59、鉱石108。縮小は tick 2400/4800/7200/10800/12000。

## 次にやること（候補）
1. 26.3 の検証用サーバーで読み込み、`/function oa:map/rebuild`、チェスト登録、`oa:br/spawn_points/verify` を実測。
2. ドーム周りの見た目と戦闘への影響を実プレイで確認。
3. 仕様書・Discordガイドを実装と照合して補正。
