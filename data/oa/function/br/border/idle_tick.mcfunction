
execute unless score #state br.state matches 1 in oa:br store result score #idle_width br.tmp run worldborder get
execute unless score #state br.state matches 1 unless score #idle_width br.tmp matches 59999968 in oa:br run worldborder set 59999968
