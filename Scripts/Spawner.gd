extends Node


var powerups_list := ["Health", "Shields", "Speed", "Multi"]
var powerup = preload("res://Scenes/PowerUp.tscn")


func _on_Timer_timeout():
	randomize()
	var power_inst = powerup.instance()
	var position_x = randi() %224
	var power = randi() %powerups_list.size()
	
	var chance = randi() %5
	
	match chance:
		
		0:
			power_inst.position.x = position_x
			power_inst.create_powerup(powerups_list[power])
			
			add_child(power_inst)
		_:
			print("no power")

