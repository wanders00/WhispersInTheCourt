extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position.x = Global.x_pos
	$Player.position.y = Global.y_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
