extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var textbox_container = $TextBoxContainer

@onready var start_symbol = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/start

@onready var end_symbol = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/end

@onready var label = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/Label

var tween
var global_key

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready():
	hide_textbox()

func _process(_delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				tween.kill()
				end_symbol.text = "J"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				if text_queue.is_empty():
					queue_free()
					return
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "Q"
	textbox_container.show()

func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_ratio = 0.0
	change_state(State.READING)
	show_textbox()
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
	await tween.finished
	end_symbol.text = "J"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state

func set_global_key(next_key):
	global_key = next_key
