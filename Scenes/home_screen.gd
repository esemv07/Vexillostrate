extends Control


var auth_screen = "res://Scenes/authetification.tscn"
var game_screen = "res://Scenes/game.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_logout_button_pressed() -> void:
	Firebase.Auth.logout()
	get_tree().change_scene_to_file(auth_screen)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(game_screen)
