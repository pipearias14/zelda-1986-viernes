class_name Player
extends CharacterBody2D

@export var SPEED: float = 60.0
@export var is_attacking : bool = false
@export var facing_direction:= Vector2.DOWN
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var can_move: bool=true


func _physics_process(delta: float) -> void:
	
	if not can_move:
		velocity = Vector2.ZERO
		return
	
	if Input.is_action_just_pressed("ATACAR"):
		attack()
	
	if is_attacking:
		return
		
	var direction = Input.get_vector(
		"IZQUIERDA",
		"DERECHA",
		"ARRIBA",
		"ABAJO")
	velocity = direction * SPEED
	
	if direction.x >0:
		facing_direction = Vector2.RIGHT
		animated_sprite_2d.play("walk_right")
	elif direction.x <0:
		facing_direction = Vector2.LEFT
		animated_sprite_2d.play("walk_left")
	elif direction.y >0:
		facing_direction = Vector2.DOWN
		animated_sprite_2d.play("walk_down")
	elif direction.y <0:
		facing_direction = Vector2.UP
		animated_sprite_2d.play("walk_up")
		
	
	move_and_slide()	
	
	#Cuando el player este quieto,ejecutamos la animacion hacia la direccion donde este mirando
	#y luego pausamos la animacion
	if direction == Vector2.ZERO:
		if facing_direction == Vector2.UP:
			animated_sprite_2d.play("walk_up")
		elif facing_direction == Vector2.DOWN:
			animated_sprite_2d.play("walk_down")
		elif facing_direction == Vector2.RIGHT:
			animated_sprite_2d.play("walk_right")
		elif facing_direction == Vector2.LEFT:
			animated_sprite_2d.play("walk_left")
			
		animated_sprite_2d.pause()
		return
	
func attack() -> void:
	is_attacking = true
	
	if facing_direction == Vector2.UP:
		animated_sprite_2d.play("attack_up")
	elif facing_direction == Vector2.DOWN:
		animated_sprite_2d.play("attack_down")
	elif facing_direction == Vector2.RIGHT:
		animated_sprite_2d.play("attack_right")
	elif facing_direction == Vector2.LEFT:
		animated_sprite_2d.play("attack_left")
	
	await animated_sprite_2d.animation_finished
	is_attacking = false
	
func move_screen_transition_player(direction: Vector2,distance: float)->void:
	can_move = false
	
	#verificar la direccion del personaje y hacia esa direccion voy a ejecutar la animacion
	
	if direction.x > 0:
		animated_sprite_2d.play("walk_right")
	elif direction.x <0:
		animated_sprite_2d.play("walk_left")
	elif direction.y >0:
		animated_sprite_2d.play("walk_down")
	elif direction.y <0:
		animated_sprite_2d.play("walk_up")
		
	var tween = create_tween()
	tween.tween_property(self, "position", position + direction * distance, 0.5)
	await tween.finished
