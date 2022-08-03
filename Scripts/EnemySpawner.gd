extends Node


var enemies = [preload("res://Scenes/EnemyShip.tscn")]



func _on_Timer_timeout():
	randomize()
	var anim = randi() %2
	var selected_enemy = enemies[randi() %enemies.size()]
	var enemy_inst = selected_enemy.instance()
	var rand_positionX = randi() %200 +20
	
	if anim == 0:
		enemy_inst.position.x = rand_positionX
		add_child(enemy_inst)
	
	elif anim == 1:
		enemy_inst.position.x = 0
		add_child(enemy_inst)
		enemy_inst.velocity.y = 0
		enemy_inst.get_node("AnimationPlayer").play("move1")
		
		
