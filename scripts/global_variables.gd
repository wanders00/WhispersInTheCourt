extends Node

var is_interacting = 0
var x_pos = 0
var y_pos = 0
var is_started = 0

# 0 = have not interacted
# 1 = first option
# 2 = second option
var map = {
	"first" : 0,
	"outside_addict" : 0,
	"west_wing_chill" : 0,
	"west_wing_bro" : 0,
	"west_wing_aristocrat" : 0
}

func update(key, value):
	map[key] = value

func get_value(key):
	return map[key]
	
