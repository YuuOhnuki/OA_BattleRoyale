
execute unless score #state br.state matches 1 if score #map oa.mapid matches 0 in oa:br store result score #idle_width br.tmp run worldborder get
execute unless score #state br.state matches 1 if score #map oa.mapid matches 1 in oa:br_nether store result score #idle_width br.tmp run worldborder get
execute unless score #state br.state matches 1 unless score #idle_width br.tmp matches 59999968 if score #map oa.mapid matches 0 in oa:br run worldborder set 59999968
execute unless score #state br.state matches 1 unless score #idle_width br.tmp matches 59999968 if score #map oa.mapid matches 1 in oa:br_nether run worldborder set 59999968
