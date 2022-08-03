extends Node


var size_multiplier := 2


func _ready():
	OS.window_size = OS.window_size * size_multiplier

