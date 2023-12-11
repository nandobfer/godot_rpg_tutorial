extends ColorRect

@onready var value = $Value
@onready var sprite = $Sprite2D


func update_silver_ui(silver):
    value.text = str(silver)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
