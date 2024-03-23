extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player").position = Vector2(Global.x_pos, Global.y_pos)
