extends CharacterBody2D
@onready var animation_sprite = $AnimatedSprite2D

@export var speed = 100
var current_speed = speed

var is_attacking = false
var new_direction: Vector2

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
        current_speed = 2*speed
    
    if(Input.is_action_just_released('ui_sprint')):
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
