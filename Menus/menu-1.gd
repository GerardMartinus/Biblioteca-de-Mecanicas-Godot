extends Control

@onready var MenuButtons = $LeftContainer/ButtonsContainer
@onready var SettingsButtons = $LeftContainer/ButtonsSettingsContainer
@onready var Credits = $LeftContainer/Credits

#@onready var scene = preload("res://FPS/FPS.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Pressionando botões do menu
	for buttons in MenuButtons.get_children():
		buttons.connect("pressed", _menu_buttons_pressed.bind(buttons))
	
	for buttons in SettingsButtons.get_children():
		buttons.connect("pressed", _settings_buttons_pressed.bind(buttons))
	
	for buttons in Credits.get_children():
		buttons.connect("pressed", _credits_buttons_pressed.bind(buttons))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _menu_buttons_pressed(button):
	match button.name:
		"Play":
			print("Player")
			#get_tree().root.add_child(scene)
			#hide()
		"Settings":
			MenuButtons.set_visible(false)
			SettingsButtons.set_visible(true)
			print("Settings")
			
		"Credits":
			MenuButtons.set_visible(false)
			Credits.set_visible(true)
			print("Credits")
		"Exit":
			get_tree().quit()

func _settings_buttons_pressed(button):
	match button.name:
		"Test":
			print("Test")
		"Back":
			MenuButtons.set_visible(true)
			SettingsButtons.set_visible(false)
			print("Back")

func _credits_buttons_pressed(button):
	match button.name:
		"Back":
			MenuButtons.set_visible(true)
			Credits.set_visible(false)
			print("Back")
