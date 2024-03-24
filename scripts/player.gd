extends CharacterBody2D

var speed = 275  # speed in pixels/sec

@onready var all_interactions = []
@onready var interact_label = $"Interaction Components/InteractLabel"
@onready var sprite_2d = $Sprite2D

func _ready():
	update_interactions()

func _physics_process(_delta):
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = direction * speed
	if Global.is_interacting != 0:
		velocity.x = 0
		velocity.y = 0
	
	if (velocity.x < -1):
		sprite_2d.play("left")
	elif (velocity.x > 1):
		sprite_2d.play("right")
	elif (velocity.y < -1):
		sprite_2d.play("up")
	elif (velocity.y > 1):
		sprite_2d.play("down")
	else:
		sprite_2d.play("default")

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
		if Global.is_interacting != 0:
			return
		
		print("Starting chat scene...")
		
		Global.is_interacting = 1
		
		var current = all_interactions[0]
		
		DialogueManager.show_example_dialogue_balloon(load(current.dialogue_path), current.dialogue_name)

func _on_teleport_area_area_entered(area):
	Global.x_pos = area.x_pos
	Global.y_pos = area.y_pos
	call_deferred("deferred_scene_change", area.new_scene_path)

func deferred_scene_change(new_scene_path):
	var current_scene = get_tree().current_scene
	var new_scene = load(new_scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene
	current_scene.queue_free()
