# マップ定義表（ID・ディメンション・中心・タイル関数の場所・終盤演出の関数・天候 weather:1b/0b、起こる災害の抽選 disasters:"oa:disaster/pool/<名前>"）。マップを増やすときはここに1行足す。finale を省くと oa:finale/default、weather を省くと天候なしになる。
data modify storage oa:maps defs set value {br:{id:0,key:"br",name:"地上（草原と雪原）",dim:"oa:br",x:0,y:80,z:0,center_y:70,tiles:"oa:map/internal/tiles",finale:"oa:finale/br",weather:1b,disasters:"oa:disaster/pool/br"},nether:{id:1,key:"nether",name:"ネザー",dim:"oa:br_nether",x:0,y:80,z:0,center_y:70,tiles:"oa:maps/nether/tiles",finale:"oa:finale/nether",weather:0b,disasters:"oa:disaster/pool/nether"}}
execute unless data storage oa:maps current run data modify storage oa:maps current set value "br"
scoreboard players add #map oa.mapid 0
