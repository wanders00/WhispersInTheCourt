extends CharacterBody2D

var speed = 200  # speed in pixels/sec

@onready var all_interactions = []
@onready var interact_label = $"Interaction Components/InteractLabel"

func _ready():
	update_interactions()

func _physics_process(_delta):
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else: 
		interact_label.text = ""

func execute_interaction():
	if all_interactions:
		var current = all_interactions[0]
		print("Starting chat scene...")
		var chat_scene
		
		var has_interacted = Global.get_value(current.global_key)
		if has_interacted != 0:
			chat_scene = load("res://interacts/text_box-no-dialogue.tscn").instantiate()
			if has_interacted == 1:
				chat_scene.queue_text(current.first_have_interacted_text)
			else:
				chat_scene.queue_text(current.second_have_interacted_text)
			add_child(chat_scene)
			return
		
		chat_scene = load(current.interact_path).instantiate()
		for text in current.interact_texts:
			chat_scene.queue_text(text)
		if current.interact_options:
			chat_scene.set_options(current.interact_options[0], current.interact_options[1])
		chat_scene.set_global_key(current.global_key)
		add_child(chat_scene)
