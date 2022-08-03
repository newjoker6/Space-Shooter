extends KinematicBody2D

var velocity := Vector2.ZERO
var speed := 200
var power_type:String
var speed_multiplier := 2


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y = speed


#warning-ignore:unused_argument
func _process(delta):
	if self.position.y > 420:
		self.queue_free()
	#warning-ignore:return_value_discarded
	move_and_slide(velocity)


func create_powerup(type:String):
	power_type = type
	$AnimationPlayer.play(type)


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		match power_type:
			"Speed":
				body.enable_speed(speed_multiplier)

			"Health":
				body.health_up(1)
			
			"Shields":
				if not body.shielded:
					body.shield_activate()
					body.shielded = true
			
			"Multi":
				body.enable_multi_shot()
				
			_:
				pass
		
		self.queue_free()
