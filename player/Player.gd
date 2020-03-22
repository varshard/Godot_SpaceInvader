extends Area2D

export var speed = 300
export (PackedScene) var bullet

var gun_barrel
var animation
var velocity = Vector2()
var view_port
var is_gun_ready = true
var gun_timer
var cool_down = 1

func _ready():
	gun_barrel = $GunBarrel
	animation = $AnimatedSprite
	animation.animation = "idle"
	view_port = get_viewport_rect().size	
	gun_timer = $GunTimer
	
func _physics_process(delta):
	get_input(delta)
	animation.play()
	
func get_input(delta):
	if Input.is_action_pressed("ui_left"):
		animation.animation = "left"
		clamp_pos(-speed * delta)
	elif Input.is_action_pressed("ui_right"):
		animation.animation = "right"
		clamp_pos(speed * delta)
	elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_left"):
		animation.animation = "idle"
	
	if Input.is_action_pressed("ui_shoot"):
		fire(delta)
		
func fire(delta):
	if is_gun_ready:
		var bullet_instance = bullet.instance()
		var parent = get_parent()
		bullet_instance.global_position = gun_barrel.global_position
		parent.add_child(bullet_instance)
		bullet_instance.add_to_group("PlayerBullets")
		is_gun_ready = false
		gun_timer.start()

func clamp_pos(speed):
	global_position.x = clamp(global_position.x + speed, 32, view_port.x - 32)

func _on_GunTimer_timeout():
	is_gun_ready = true
