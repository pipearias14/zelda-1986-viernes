class_name OCTOROK 
extends CharacterBody2D
#Crea referencia a nodo de animaciones
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#Crea las referencias a los 4 ray cast, que detectan objetos u obstaculos que tenga el enemigo
@onready var ray_cast_2d_up: RayCast2D = $RayCast2D_UP
@onready var ray_cast_2d_down: RayCast2D = $RayCast2D_DOWN
@onready var ray_cast_2d_right: RayCast2D = $RayCast2D_RIGHT
@onready var ray_cast_2d_left: RayCast2D = $RayCast2D_LEFT

#variable para velocidad del enemigo
@export var SPEED: float = 60.0
# variable para controlar direccion hacia donde se desplaza y mira el enemigo
var direction: Vector2 = Vector2.DOWN

#se crea un arreglo para determinar las direcciones de movimiento
var array_directions: Array= [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]


func _ready() -> void:
	#Elige una direccion random
	direction = array_directions.pick_random()


func _physics_process(delta: float) -> void:
	#Verificar direccion de movimiento 
	if direction.x >0:
		animated_sprite_2d.play("walk_right")
	elif direction.x <0:
		animated_sprite_2d.play("walk_left")
	elif direction.y >0:
		animated_sprite_2d.play("walk_down")
	elif direction.y <0:
		animated_sprite_2d.play("walk_up")
	
	velocity =direction * SPEED
	move_and_slide()

#validar la direccion hacia donde se mueve y verificar si el rayCast detectó algo
	if direction == Vector2.UP and ray_cast_2d_up.is_colliding():
		change_direction()
	elif direction == Vector2.DOWN and ray_cast_2d_down.is_colliding():
		change_direction()
	elif direction == Vector2.RIGHT and ray_cast_2d_right.is_colliding():
		change_direction()
	elif direction == Vector2.LEFT and ray_cast_2d_left.is_colliding():
		change_direction()

func change_direction() -> void:
	#Se crea el arreglo para guardar las direcciones disponibles para el enemigo
	var available_direction : Array = []
	#Verifico los ray cast, si alguno no está colisionando, cuenta como un camino
	#disponible, por lo cual lo guardamos en el arreglo direcciones disponibles
	if not ray_cast_2d_up.is_colliding():
		available_direction.append(Vector2.UP)
	if not ray_cast_2d_down.is_colliding():
		available_direction.append(Vector2.DOWN)
	if not ray_cast_2d_right.is_colliding():
		available_direction.append(Vector2.RIGHT)
	if not ray_cast_2d_left.is_colliding():
		available_direction.append(Vector2.LEFT)
	
	
	
	#Elige una nueva direccion disponible
	direction =available_direction.pick_random()
