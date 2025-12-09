extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_node("/root/GameController").leverPull()
		$AnimatedSprite2D.play("After")
		$CollisionShape2D.queue_free()
		
