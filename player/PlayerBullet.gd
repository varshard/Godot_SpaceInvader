extends KinematicBody2D

export var speed = Vector2(0, -300)

enum States {
	Default,
	Hit,
	Done
}

var sprite
var state = States.Default
var timer
var is_timer_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $Sprite
	timer = $ExplosionTimer

func _physics_process(delta):
	var velocity = Vector2()
	if state == States.Hit:
		if !is_timer_started:
			timer.start()
			is_timer_started = true
	elif state == States.Done:
		queue_free()
	else:
		velocity = speed * delta
		move_and_collide(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_EnemyShip_hitted():
	sprite.play("hitted")
	state = States.Hit
	
func _on_ExplosionTimer_timeout():
	is_timer_started = false
	state = States.Done
