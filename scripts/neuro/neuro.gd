extends CharacterBody2D
class_name Neuro 

@export var speed = 50 
@export var dash_speed = 150
@export var acceleration = 1000 
@export var jump_velocity = -250 

@onready var sm = $StateMachine as StateMachine 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
    sm.setup()

func _physics_process(delta):
    apply_gravity(delta)
    sm.physics_process(delta)
    move_and_slide()

func apply_gravity(delta: float) -> void: 
    velocity.y += gravity * delta 
