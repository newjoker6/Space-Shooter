extends CanvasLayer



func _ready():
	self.add_to_group("GUI")


func update_bar(bar:String, value:int):
	get_node(bar).value = value


func game_over():
	$GameOver.visible = true


func _on_RetryButton_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
