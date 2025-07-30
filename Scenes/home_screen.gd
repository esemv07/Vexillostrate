extends Control


var auth_screen = "res://Scenes/authetification.tscn"
var game_screen = "res://Scenes/game.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ErrorLabel.visible = false
	Constants.DIFFICULTY = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_logout_button_pressed() -> void:
	Firebase.Auth.logout()
	get_tree().change_scene_to_file(auth_screen)


func _on_play_button_pressed() -> void:
	if %EasyCheckBox.button_pressed:
		Constants.DIFFICULTY.append("EASY")
	if %MediumCheckBox.button_pressed:
		Constants.DIFFICULTY.append("MEDIUM")
	if %HardCheckBox.button_pressed:
		Constants.DIFFICULTY.append("HARD")
	
	if !%EasyCheckBox.button_pressed and !%MediumCheckBox.button_pressed and !%HardCheckBox.button_pressed:
		%ErrorLabel.visible = true
	else:
		%ErrorLabel.visible = false
		get_tree().change_scene_to_file(game_screen)
