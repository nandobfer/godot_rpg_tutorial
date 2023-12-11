extends Node

# Scene resources
@onready var pickups_scene = preload("res://Scenes/Pickup.tscn")

enum Pickups { COPPER, SILVER, GOLD }