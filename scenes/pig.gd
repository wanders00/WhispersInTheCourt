extends CharacterBody2D

@onready var sprite_2d = $AnimatedSprite2D

func _ready():
	sprite_2d.play("default")
	sprite_2d.set_flip_h(true)

func _process(delta):
	pass
	
