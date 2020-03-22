extends Area2D

signal hitted


func _on_EnemyShip_body_entered(body):
	if body.is_in_group("PlayerBullets"):
		emit_signal("hitted", body)
