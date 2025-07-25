extends Control


@onready var _lines: Node2D = $Line2D
@onready var colour_picker = %ColorPickerButton
@onready var width_slider = %LineWidthSlider

# var active_colour = colour_picker.get_pick_color()
# var width = width_slider.value

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
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
