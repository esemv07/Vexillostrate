extends Button

@export_color_no_alpha var colour: Color = Color(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ColorRect.set_color(colour)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
