extends Control


@onready var _lines: Node2D = $Line2D
@onready var colour_picker = %ColorPickerButton
@onready var width_slider = %LineWidthSlider

@onready var submitted = false

var curr_image_url = ""
var curr_country = ""
var COLLECTION_ID = "user_details"
var API_URL = "https://api.cloudinary.com/v1_1/db5vkjpwu/image/upload"

# var active_colour = colour_picker.get_pick_color()
# var width = width_slider.value

var home_screen = "res://Scenes/home_screen.tscn"
var gallery = "res://Scenes/gallery.tscn"

var _pressed: bool = false
var _current_line: Line2D = null

var COLOURS = [
	"000000",
	"ffffff",
]
var colour := Color.WHITE
var Swatch: PackedScene = preload("res://UI Elements/color_swatch.tscn")
var curr_colour = "ColorSwatch"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Add black an white swatches as default colours
	for colour in COLOURS:
		var swatch: Button = Swatch.instantiate()
		swatch.colour = colour
		var hex_colour = swatch.colour.to_html(false)
		$VBoxContainer.add_child(swatch)
		swatch.pressed.connect(_on_colour_swatch_pressed.bind(hex_colour, swatch.name))
	$ControlPanelContainer.visible = false
	$SubmitPanelContainer.visible = false
	pick_random_country()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if !submitted:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				_pressed = event.pressed
				
				if _pressed:
					_current_line = Line2D.new()
					_current_line.default_color = colour_picker.get_pick_color()
					_current_line.width = width_slider.value
					_lines.add_child(_current_line)
					_current_line.add_point(event.position)
		elif event is InputEventMouseMotion and _pressed:
			_current_line.add_point(event.position)


# Save current colour to pallette
func _on_save_colour_button_pressed() -> void:
	colour = colour_picker.get_pick_color()
	var swatch: Button = Swatch.instantiate()
	swatch.colour = colour
	var hex_colour = swatch.colour.to_html(false)
	$VBoxContainer.add_child(swatch)
	swatch.pressed.connect(_on_colour_swatch_pressed.bind(hex_colour, swatch.name))
	curr_colour = swatch.name

# Change colour to pallette pressed colour
func _on_colour_swatch_pressed(colour_string: String, current: String) -> void:
	colour_picker.set_pick_color(colour_string)
	curr_colour = current


func _on_clear_button_pressed() -> void:
	for line in _lines.get_children():
		_lines.remove_child(line)
		line.queue_free()


func _on_delete_colour_button_pressed() -> void:
	var colour_path = "VBoxContainer/%s" %curr_colour
	var remove_colour = get_node(colour_path)
	$VBoxContainer.remove_child(remove_colour)


func pick_random_country():
	# Randomise Country
	var difficulty = Constants.DIFFICULTY.pick_random()
	var all = Constants.COUNTRIES[difficulty].keys()
	var rand = randi() % Constants.COUNTRIES[difficulty].size()
	var rand_country = all[rand]
	# Set Country Outline Ratio Image
	var country = Constants.COUNTRIES[difficulty][rand_country]["ratio"]
	var path = "%s/%s %s" % [Constants.OUTLINE_PATH, country, Constants.OUTLINE_NAME]
	var outline = load(path)
	$FlagOutline.texture = outline
	var name = Constants.COUNTRIES[difficulty][rand_country]["name"]
	%CountryLabel.text = name
	curr_country = name
	# Prepare Rect for Screenshot Image
	var rect_pos = Constants.RATIO_DIMENSIONS[country]["position"]
	var rect_size = Constants.RATIO_DIMENSIONS[country]["size"]
	$ReferenceRect.position = Vector2(rect_pos[0], rect_pos[1])
	$ReferenceRect.size = Vector2(rect_size[0], rect_size[1])


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file(home_screen)


func _on_controls_button_pressed() -> void:
	$ControlPanelContainer.visible = true


func _on_back_button_pressed() -> void:
	$ControlPanelContainer.visible = false


func _on_submit_button_pressed() -> void:
	submitted = true
	var full_image = get_viewport().get_texture().get_image()
	var crop_rect = $ReferenceRect.get_rect()
	var crop_image = full_image.get_region(crop_rect)
	var texture = ImageTexture.create_from_image(crop_image)
	%TextureRect.texture = texture
	var dimensions = texture.get_size()
	var width = dimensions.x / 1.25
	var height = dimensions.y / 1.25
	%TextureRect.custom_minimum_size = Vector2(width, height)
	print(%TextureRect.custom_minimum_size)
	$SubmitPanelContainer.visible = true



### CURRENTLY NOT WORKING ###
func _on_save_button_pressed() -> void:
	var image_save = %TextureRect.texture.get_image()
	var image_bytes = image_save.save_png_to_buffer()
	upload_image_to_cloudinary(image_bytes, API_URL)


func save_image_url():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var image_url = curr_image_url
		var data: Dictionary = {
			"images": [{
				"url": image_url,
				"country": curr_country
				}],
		}
		var document = await collection.get_doc(auth.localid)
		if document:
			await collection.update(update_data(document))
		else:
			await collection.add(auth.localid, data)


func update_data(document : FirestoreDocument) -> FirestoreDocument:
	if document.get_value("images"):
		var images = document.get_value("images")
		var data: Dictionary = {
			"url": curr_image_url,
			"country": curr_country
		}
		images.append(data)
		document["images"] = images
	else:
		document["images"] = [{
				"url": curr_image_url,
				"country": curr_country
				}]
	return document


func upload_image_to_cloudinary(image_bytes, api_url: String):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_image_upload_completed"))
	
	var boundary = "PlaceholderBoundary"
	var headers = [
		"Content-Type: multipart/form-data; boundary=" + boundary,
	]
	
	var body_parts = PackedStringArray()
	# Upload Preset
	body_parts.push_back("--" + boundary)
	body_parts.push_back('Content-Disposition: form-data; name="upload_preset"')
	body_parts.push_back("")
	body_parts.push_back("unsigned-vex-upload")
	
	# File Upload PReparation
	body_parts.push_back("--" + boundary)
	body_parts.push_back('Content-Disposition: form-data; name="file"; filename="image.png"')
	body_parts.push_back("Content-Type: image/png")
	body_parts.push_back("")
	
	# Image Bytes Upload
	var request_body = PackedByteArray()
	for part in body_parts:
		request_body += part.to_utf8_buffer()
		request_body += "\r\n".to_utf8_buffer()
	request_body += image_bytes
	request_body += "\r\n".to_utf8_buffer()
	request_body += ("--" + boundary + "--\r\n").to_utf8_buffer()
	
	http_request.request_raw(api_url, headers, HTTPClient.METHOD_POST, request_body)

func _on_image_upload_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	if response_code == 200:
		var response_json = JSON.parse_string(body.get_string_from_utf8())
		if response_json and response_json.has("url"):
			var image_url = response_json["url"]
			print("Image uploaded successfully. URL: ", image_url)
			curr_image_url = image_url
			save_image_url()
		else:
			print("API response did not contain a URL.")
	else:
		print("Image upload failed with code: ", response_code)
		print("Response body: ", body.get_string_from_utf8())


func _on_gallery_button_pressed() -> void:
	get_tree().change_scene_to_file(gallery)
