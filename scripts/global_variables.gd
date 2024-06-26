extends Node

var is_interacting = 0
var x_pos = 0
var y_pos = 0
var is_started = 0
var game_over = 0

# 0 = have not interacted
# 1 = first option
# 2 = second option
var map = {
	"first" : 0,
	"throne_room_cat" : 0,
	"throne_room_princess" : 0,
	"first_evildoer" : 0,
	"second_evildoer" : 0,
	"entrance_duke" : 0,
	"training_area_cat" : 0,
	"training_area_prince" : 0,
	"east_wing_duck" : 0,
	"east_wing_weapons_master" : 0,
	"east_wing_female_aristocrat" : 0,
	"outside_addict" : 0,
	"west_wing_chill" : 0,
	"west_wing_bro" : 0,
	"west_wing_aristocrat" : 0
}

func update(key, value):
	map[key] = value

func get_value(key):
	return map[key]
	
func reset_map():
	map = {
	"first" : 0,
	"throne_room_cat" : 0,
	"throne_room_princess" : 0,
	"first_evildoer" : 0,
	"second_evildoer" : 0,
	"entrance_duke" : 0,
	"training_area_cat" : 0,
	"training_area_prince" : 0,
	"east_wing_duck" : 0,
	"east_wing_weapons_master" : 0,
	"east_wing_female_aristocrat" : 0,
	"outside_addict" : 0,
	"west_wing_chill" : 0,
	"west_wing_bro" : 0,
	"west_wing_aristocrat" : 0
}
