function oa:map/pause
tellraw @a [{text:"[OA Map 305] 停止区画 ",color:"red"},{score:{name:"#tile",objective:"oa.map2"}},{text:" / 処理段階 "},{score:{name:"#stage",objective:"oa.map2"}},{text:"（1=配置、2=登録）"}]
tellraw @a [{text:"チェスト 登録/予定: ",color:"yellow"},{score:{name:"#localc",objective:"oa.map2"}},{text:"/"},{score:{name:"#expectedc",objective:"oa.map2"}},{text:" 鉱石 登録/予定: "},{score:{name:"#localo",objective:"oa.map2"}},{text:"/"},{score:{name:"#expectedo",objective:"oa.map2"}},{text:"。修正後 /function oa:map/resume"}]
