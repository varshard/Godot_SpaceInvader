extends Node2D

var player
var screen_size
var enemy

func _ready():
	screen_size = get_viewport_rect().size
	player = $Player
	player.position.x = screen_size.x / 2
	player.position.y = screen_size.y - 64
	enemy = $EnemyShip
	enemy.add_to_group("Enemies")

func _on_EnemyShip_hitted(body):
	body._on_EnemyShip_hitted()
