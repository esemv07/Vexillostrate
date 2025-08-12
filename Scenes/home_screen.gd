extends Control


var COLLECTION_ID = "user_details"
var auth_screen = "res://Scenes/authetification.tscn"
var game_screen = "res://Scenes/game.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ErrorLabel.visible = false
	$PanelContainer.visible = false
	Constants.DIFFICULTY = []
	load_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_logout_button_pressed() -> void:
	Firebase.Auth.logout()
	get_tree().change_scene_to_file(auth_screen)


func save_username():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var username = %UsernameEdit.text
		var data: Dictionary = {
			"username": username,
		}
		var document = await collection.get_doc(auth.localid)
		if document:
			await collection.update(update_data(document))
		else:
			await collection.add(auth.localid, data)


func update_data(document : FirestoreDocument) -> FirestoreDocument:
	if document.get_value("username"):
		document["username"] = %UsernameEdit.text
		%UsernameLabel.text = document["username"]
	return document


func load_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var document = await collection.get_doc(auth.localid)
		if document:
			if document.get_value("username"):
				%UsernameLabel.text = document.get_value("username")
				%UsernameEdit.text = document.get_value("username")
			if document.get_value("username"):
				Constants.username = document.get_value("username")
		elif document:
			print(document.error)
		else:
			print("No document found")


func _on_play_button_pressed() -> void:
	%LoadingLabel.visible = true
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


func disable_buttons():
	%PlayButton.disabled = true
	%LogoutButton.disabled = true
	%EasyCheckBox.disabled = true
	%MediumCheckBox.disabled = true
	%HardCheckBox.disabled = true


func enable_buttons():
	%PlayButton.disabled = false
	%LogoutButton.disabled = false
	%EasyCheckBox.disabled = false
	%MediumCheckBox.disabled = false
	%HardCheckBox.disabled = false


func _on_profile_button_pressed() -> void:
	$PanelContainer.visible = true
	disable_buttons()


func _on_save_button_pressed() -> void:
	save_username()


func _on_back_button_pressed() -> void:
	$PanelContainer.visible = false
	enable_buttons()
