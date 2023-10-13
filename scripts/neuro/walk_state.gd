extends State
class_name WalkState 

@onready var player: Neuro = owner 
@onready var walk_sprite = $"../../WalkSprite"
@onready var animation_player = $"../../AnimationPlayer"

func enter(flip := false) -> void:
    if flip: 
        walk_sprite.flip_h = true 
    else: 
        walk_sprite.flip_h = false 
    walk_sprite.visible = true
    animation_player.play("walk") 

func exit() -> void: 
    walk_sprite.visible = false 
    animation_player.stop() 

func physics_process(delta: float) -> void: 
    var input_axis = Input.get_axis("left", "right")
    handle_movement(delta, input_axis)
    
    if Input.is_action_pressed("left"): 
        walk_sprite.flip_h = true 
    elif Input.is_action_pressed("right"): 
        walk_sprite.flip_h = false  
    else: 
        state_machine.transition_to("IdleState", walk_sprite.flip_h)
    
    if Input.is_action_pressed("dash"):
        state_machine.transition_to("DashState", walk_sprite.flip_h)
    
    if Input.is_action_just_pressed("jump"):
        state_machine.transition_to("JumpState", walk_sprite.flip_h)

func handle_movement(delta: float, input_axis: float) -> void: 
    player.velocity.x = move_toward(player.velocity.x, player.speed * input_axis, 
                                   player.acceleration * delta)
