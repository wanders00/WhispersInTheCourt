extends CharacterBody2D

@onready var sprite_2d = $KnightSprite2D

func _ready():
	sprite_2d.play("default")

func _process(_delta):
	pass
