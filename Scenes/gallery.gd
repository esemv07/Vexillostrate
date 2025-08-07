extends Control

@onready var http_request: HTTPRequest = $HTTPRequest

var Card: PackedScene = preload("res://UI Elements/gallery_image.tscn")
var COLLECTION_ID = "user_details"
var image_texture: Texture


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
					%GridContainer.add_child(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_http_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	print("Request completed with result: %d, response_code: %d" % [result, response_code])
	
	if response_code == 200:
		var image = Image.new()
		var error = image.load_png_from_buffer(body)
		
		if error == OK:
			var texture = ImageTexture.new()
			texture.create_from_image(image)
			image_texture = texture
			$TextureRect.texture = texture
			print("Image loaded successfully.")
		else:
			print("Error loading image from buffer: %s" % error)
	else:
		print("HTTP request failed with response code: %d" % response_code)
