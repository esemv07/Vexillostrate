extends Control

@export var image: Texture
@export var country: String
@export var date: String
@export var score: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%FlagDrawing.texture = image
	%CountryName.text = country
	%DrawnDate.text = date
	%AccuracyScore.text = score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
