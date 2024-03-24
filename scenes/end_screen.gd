extends Control

@onready var label1 = $VBoxContainer/Label
@onready var label2 = $VBoxContainer/Label2

# Called when the node enters the scene tree for the first time.
func _ready():
	label1.text = "Game Over"
	
	var first = Global.get_value("first_evildoer")
	var second = Global.get_value("second_evildoer")
	
	var sum = first + second
	
	label2.text = "You caught " + str(sum) + " out of 2 evildoers!"
	
	if first == 1:
		label2.text += "\nYou caught the kidnapper ('Crewmate') and saved the Princess!"
	else:
		label2.text += "\nAn evildoer kidnapped the Princess!"
	if second == 1:
		label2.text += "\nYou caught the murderer ('Sir Geoffrey') and saved the Prince!"
	else:
		label2.text += "\nAn evildoer murdered the Prince!"
	
	if sum == 2:
		label2.text += "\nWell done! The Kingdom will prosper thanks to your service!"
	elif sum == 1:
		label2.text += "\nYou kinda did it... At least the King got one child to continue the bloodline."
	elif sum == 0:
		label2.text += "\nThe Kingdom will most likely turn to ruin thanks to you.... Good job..."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_exit_pressed():
	Global.is_interacting = 0
	Global.x_pos = 0
	Global.y_pos = 0
	Global.is_started = 0
	Global.game_over = 0
	Global.reset_map()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
