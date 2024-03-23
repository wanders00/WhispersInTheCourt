extends CharacterBody2D

@onready var sprite_2d = $KingSprite2D

func _ready():
	sprite_2d.play("default")

func _process(delta):
	pass
