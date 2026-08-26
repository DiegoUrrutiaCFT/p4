extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var anim = $Sprite2D

var coins=0
@onready var hud=get_node("/root/Node2D/UI");

func add_coin():
	coins+=1
	hud.set_coins(coins)
	if coins >= 7:
		reiniciar_por_victoria()

func reiniciar_por_victoria() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("ui_accept") or Input.is_physical_key_pressed(KEY_SPACE):
		if is_on_floor(): 
			velocity.y = -400 # 
			
			$FX.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h=direction>0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if not is_on_floor() && velocity.y<0:
		anim.play("jump")
	elif direction !=0:
		anim.play("walk")
	else:
		anim.play("idle")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_R:
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()
