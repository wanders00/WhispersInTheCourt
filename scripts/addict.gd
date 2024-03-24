extends CharacterBody2D

@onready var sprite_2d = $AnimatedSprite2D

func _ready():
	sprite_2d.play("default")

func _process(_delta):
	var temp = Global.get_value("outside_addict")
	if temp == 1:
		sprite_2d.play("dying :nerd:")
	elif temp == 2:
		sprite_2d.play("dead :skull:")
	elif temp == 3:
		sprite_2d.play("default")
