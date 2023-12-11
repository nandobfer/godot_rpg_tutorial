extends ColorRect

@onready var value = $Value
@onready var sprite = $Sprite2D
@onready var player = $"../.."


func update_gold_ui(gold):
    value.text = str(gold)

# Called when the node enters the scene tree for the first time.
func _ready():
    value.text = str(player.gold)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
