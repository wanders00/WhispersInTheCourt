extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var textbox_container = $TextBoxContainer

@onready var start_symbol = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/start

@onready var end_symbol = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/end

@onready var label = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/Label

@onready var options_container = $OptionsContainer

var tween
var global_key

enum State {
	READY,
	READING,
	FINISHED
}

@onready var first_option_label = $OptionsContainer/HBoxContainer/FirstOptionPanel/MarginContainer/HBoxContainer/Label
@onready var first_option_selected = $OptionsContainer/HBoxContainer/FirstOptionPanel/MarginContainer/HBoxContainer/Selected

@onready var second_option_label = $OptionsContainer/HBoxContainer/SecondOptionPanel/MarginContainer/HBoxContainer/Label
@onready var second_option_selected = $OptionsContainer/HBoxContainer/SecondOptionPanel/MarginContainer/HBoxContainer/Selected

var current_state = State.READY
var text_queue = []
var first_option = ""
var second_option = ""

enum Option {
	FIRST,
	SECOND
}

var selected_option = Option.FIRST

func _ready():
	first_option_label.text = first_option
	second_option_label.text = second_option
	first_option_selected.text = "+"
	second_option_selected.text = ""
	change_option(Option.FIRST)
	hide_textbox()

func _process(_delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				options_container.hide()
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				tween.kill()
				end_symbol.text = "J"
				change_state(State.FINISHED)
		State.FINISHED:
			if text_queue.is_empty():
				options_container.show()
				if Input.is_action_just_pressed("ui_left"):
					first_option_selected.text = "+"
					second_option_selected.text = ""
					change_option(Option.FIRST)
				elif Input.is_action_just_pressed("ui_right"):
					first_option_selected.text = ""
					second_option_selected.text = "+"
					change_option(Option.SECOND)
				elif Input.is_action_just_pressed("ui_accept"):
					change_state(State.READY)
					var temp
					if selected_option == Option.FIRST:
						temp = 1
					else:
						temp = 2
					Global.update(global_key, temp)
					queue_free()
			elif Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				#hide_textbox()

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

func set_options(next_first_option, next_second_option):
	first_option = next_first_option
	second_option = next_second_option

func set_global_key(next_key):
	global_key = next_key

func change_state(next_state):
	current_state = next_state

func change_option(next_option):
	selected_option = next_option
