extends State
class_name DashState

@onready var player: Neuro = owner 
@onready var dash_sprite = $"../../DashSprite"
@onready var animation_player = $"../../AnimationPlayer"

func enter(flip := false) -> void:
    if flip: 
        dash_sprite.flip_h = true 
    else: 
        dash_sprite.flip_h = false 
    dash_sprite.visible = true
    animation_player.play("dash") 

func exit() -> void: 
    dash_sprite.visible = false 
    animation_player.stop() 

func physics_process(delta: float) -> void: 
    var input_axis = Input.get_axis("left", "right")
    handle_movement(delta, input_axis)
    
    if Input.is_action_pressed("left"): 
        dash_sprite.flip_h = true
    elif Input.is_action_pressed("right"): 
        dash_sprite.flip_h = false  
    else: 
        state_machine.transition_to("IdleState", dash_sprite.flip_h)

    if not Input.is_action_pressed("dash"):
        state_machine.transition_to("WalkState", dash_sprite.flip_h)
        
    if Input.is_action_just_pressed("jump"):
        state_machine.transition_to("JumpState", dash_sprite.flip_h)

func handle_movement(delta: float, input_axis: float) -> void: 
    player.velocity.x = move_toward(player.velocity.x, player.dash_speed * input_axis, 
                                   player.acceleration * delta)
                                
