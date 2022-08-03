extends KinematicBody2D


var velocity := Vector2.ZERO
var speed := 200


func _ready():
	velocity.y = -speed


#warning-ignore:unused_argument
func _process(delta):
	#warning-ignore:return_value_discarded
	check_position()
	move_and_slide(velocity)


func check_position():
	if self.position.y < 0:
		queue_free()
	
	elif self.position.y > 450:
		queue_free()


func _on_ShotArea_body_entered(body):
	if "Player" in body.name:
		body.hit(1)
		
	if body.is_in_group("Enemy"):
		body.hit(1)
	
	self.queue_free()




