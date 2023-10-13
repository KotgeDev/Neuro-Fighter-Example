extends State 
class_name JumpState 

@onready var player: Neuro = owner 
@onready var jump_sprite = $"../../JumpSprite"
@onready var animation_player = $"../../AnimationPlayer"

func enter(flip := false) -> void:
    if flip: 
        jump_sprite.flip_h = true 
    else: 
        jump_sprite.flip_h = false 
    jump_sprite.visible = true 
    apply_jump()

func exit() -> void: 
    jump_sprite.visible = false 

func physics_process(_delta: float) -> void:
    if player.is_on_floor():
        if Input.is_action_pressed("left") or Input.is_action_pressed("right"): 
            if Input.is_action_pressed("dash"):
                state_machine.transition_to("DashState", jump_sprite.flip_h)
            else:
                state_machine.transition_to("WalkState", jump_sprite.flip_h) 
        else:
            state_machine.transition_to("IdleState", jump_sprite.flip_h)

func apply_jump() -> void: 
    player.velocity.y = player.jump_velocity
