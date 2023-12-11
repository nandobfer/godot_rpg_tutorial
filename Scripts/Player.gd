extends CharacterBody2D
@onready var animation_sprite = $AnimatedSprite2D
@onready var health_bar = $UI/HealthBar
@onready var stamina_bar = $UI/StaminaBar

@export var speed = 100
var current_speed = speed

var health = 100
var max_health = 100
var health_regen = 1
var stamina = 100
var max_stamina = 100
var stamina_regen = 5

var is_attacking = false
var new_direction: Vector2

signal health_updated
signal stamina_updated

func _ready():
    health_updated.connect(health_bar.update_health_ui)
    stamina_updated.connect(stamina_bar.update_stamina_ui)

func _process(delta):
    #regenerates health
    var updated_health = min(health + health_regen * delta, max_health)
    if updated_health != health:
        health = updated_health
        health_updated.emit(health, max_health)
    #regenerates stamina    
    var updated_stamina = min(stamina + stamina_regen * delta, max_stamina)
    if updated_stamina != stamina:
        stamina = updated_stamina
        stamina_updated.emit(stamina, max_stamina)

func _input(event):
    if (event.is_action_pressed("ui_attack")):
        is_attacking = true
        var animation = "attack_"+getDirection(new_direction)
        animation_sprite.play(animation)

func _physics_process(delta):

    # get player input
    var direction: Vector2
    direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

    if (abs(direction.x) == 1 and abs(direction.y) == 1):
        direction = direction.normalized() 

    doSprint()
    

    var movement = current_speed * direction * delta
    if (!is_attacking):
        move_and_collide(movement)
        doPlayerAnimations(direction)

func doPlayerAnimations(direction: Vector2):
    if (direction == Vector2.ZERO):
        # idle
        var animation = "idle_" + getDirection(new_direction)
        animation_sprite.play(animation)
    else:
        #play walk animation, because we are moving
        new_direction = direction
        var animation = "walk_" + getDirection(new_direction)
        animation_sprite.play(animation)

func doSprint():
    if (Input.is_action_pressed('ui_sprint')):
        if (stamina < 5): 
            resetSpeed()
            return
            
        current_speed = 2*speed
        stamina = stamina - 5
        stamina_updated.emit(stamina, max_stamina)
    
    if(Input.is_action_just_released('ui_sprint')):
        resetSpeed()

func resetSpeed():
    current_speed = speed

func getDirection(direction: Vector2):
    var normalized_direction = direction.normalized()

    if (normalized_direction.y > 0):
        return 'down'
    elif (normalized_direction.y < 0):
        return 'up'
    elif (normalized_direction.x > 0):
        # right
        animation_sprite.flip_h = false 
        return 'side'
    elif (normalized_direction.x < 0):
        # left
        animation_sprite.flip_h = true
        return 'side'

    return 'side'


func _on_animated_sprite_2d_animation_finished():
    is_attacking = false
