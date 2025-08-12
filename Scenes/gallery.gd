extends Control

@onready var http_request: HTTPRequest = $HTTPRequest

var Card: PackedScene = preload("res://UI Elements/gallery_image.tscn")
var COLLECTION_ID = "user_details"
var image_texture: Texture
var home_screen = "res://Scenes/home_screen.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer.visible = false
	$NoSavesLabel.visible = false
	$ControlPanelContainer.visible = false
	load_data()
	
	http_request.request_completed.connect(_on_http_request_completed)
	
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var document = await collection.get_doc(auth.localid)
		if document:
			if document.get_value("images"):
				var images = document.get_value("images")
				for image in images:
					var image_url = image["url"]
					http_request.request(image_url)
					var response = await http_request.request_completed
					var card = Card.instantiate()
					card.image = image_texture
					card.country = image["country"]
					card.date = image["date"]
					card.score = "Accuracy: %d%%" % image["score"]
					%GridContainer.add_child(card)
			else:
				$NoSavesLabel.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_http_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	print("Request completed with result: %d, response_code: %d" % [result, response_code])
	
	if response_code == 200:
		var image = Image.new()
		var error = image.load_png_from_buffer(body)
		
		if error == OK:
			var texture: ImageTexture = ImageTexture.create_from_image(image)
			image_texture = texture
			print("Image loaded successfully.")
		else:
			print("Error loading image from buffer: %s" % error)
	else:
		print("HTTP request failed with response code: %d" % response_code)


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
				%UsernameEdit.text = document.get_value("username")
				%UsernameLabel.text = document.get_value("username")
				Constants.username = document.get_value("username")
		elif document:
			print(document.error)
		else:
			print("No document found")


func _on_profile_button_pressed() -> void:
	$PanelContainer.visible = true


func _on_save_button_pressed() -> void:
	save_username()


func _on_back_button_pressed() -> void:
	$PanelContainer.visible = false


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file(home_screen)


func _on_controls_back_button_pressed() -> void:
	$ControlPanelContainer.visible = false


func _on_controls_button_pressed() -> void:
	$ControlPanelContainer.visible = true
