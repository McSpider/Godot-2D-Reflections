extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	for x in range(0,1024/32):
		for y in range(0,632/32):
			if (x%2 && y%2):
				draw_rect(Rect2(x*32,y*32,32,32),ColorN("Black",0.65))
			if (!x%2 && !y%2):
				draw_rect(Rect2(x*32,y*32,32,32),ColorN("Black",0.25))
