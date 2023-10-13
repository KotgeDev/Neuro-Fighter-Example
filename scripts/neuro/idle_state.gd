extends State
class_name IdleState 

@onready var player: Neuro = owner 
@onready var idle_sprite = $"../../IdleSprite"
@onready var animation_player = $"../../AnimationPlayer"
@onready var downward_strike_sprite = $"../../DownwardStrikeSprite"
@onready var stab_sprite = $"../../StabSprite"

var attacking := false 

func enter(flip := false) -> void:
    if flip: 
        idle_sprite.flip_h = true 
    else: 
        idle_sprite.flip_h = false 
    idle_sprite.visible = true 
    animation_player.play("idle")
    player.velocity.x = 0.0 
    player.velocity.y = 0.0 

func exit() -> void: 
    idle_sprite.visible = false 
    animation_player.stop()

func physics_process(_delta: float) -> void:
    if not attacking: 
        if Input.is_action_pressed("left") or Input.is_action_pressed("right"): 
            if Input.is_action_pressed("dash"):
                state_machine.transition_to("DashState", idle_sprite.flip_h)
            else:
                state_machine.transition_to("WalkState", idle_sprite.flip_h)      
        
        if Input.is_action_just_pressed("jump"):
            state_machine.transition_to("JumpState", idle_sprite.flip_h)
        
        if Input.is_action_just_pressed("hit_a"): 
            downward_strike_sprite.flip_h = idle_sprite.flip_h 
            downward_strike_sprite.visible = true
            idle_sprite.visible = false 
            animation_player.play("downward_strike")
            attacking = true 
            
            await animation_player.animation_finished 

            downward_strike_sprite.visible = false 
            idle_sprite.visible = true
            animation_player.play("idle")
            attacking = false
            
        if Input.is_action_just_pressed("hit_b"): 
            stab_sprite.flip_h = idle_sprite.flip_h 
            stab_sprite.visible = true
            idle_sprite.visible = false 
            animation_player.play("stab")
            attacking = true 
            
            await animation_player.animation_finished 

            stab_sprite.visible = false 
            idle_sprite.visible = true
            animation_player.play("idle")
            attacking = false

