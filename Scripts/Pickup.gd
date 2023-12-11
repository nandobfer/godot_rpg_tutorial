@tool

extends Area2D

@export var item : Global.Pickups

@onready var sprite = $Sprite2D

var copper_texture = preload("res://Assets/Icons/coin_05b.png")
var silver_texture = preload("res://Assets/Icons/coin_05c.png")
var gold_texture = preload("res://Assets/Icons/coin_05d.png")

# Called when the node enters the scene tree for the first time.
func _ready():
    if (!Engine.is_editor_hint()):
        if (item == Global.Pickups.COPPER):
            sprite.set_texture(copper_texture)
        if (item == Global.Pickups.SILVER):
            sprite.set_texture(silver_texture)
        if (item == Global.Pickups.GOLD):
            sprite.set_texture(gold_texture)


func _process(_delta):
    #executes the code in the editor without running the game
    if (Engine.is_editor_hint()):
        if (item == Global.Pickups.COPPER):
            sprite.set_texture(copper_texture)
        if (item == Global.Pickups.SILVER):
            sprite.set_texture(silver_texture)
        if (item == Global.Pickups.GOLD):
            sprite.set_texture(gold_texture)


func _on_body_entered(body):
    if (body.name == "Player"):
        body.add_pickup(item)
        get_tree().queue_delete(self)
