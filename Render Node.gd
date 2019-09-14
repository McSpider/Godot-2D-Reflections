extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_rect(Rect2(0,0,32,32),ColorN("Black"))
	draw_rect(Rect2(0,0,16,16),ColorN("Orange"))
	draw_rect(Rect2(32,32,32,32),ColorN("Purple"))
	draw_rect(Rect2(100,0,64,64),ColorN("Red"))
	draw_rect(Rect2(100,100,100,100),ColorN("Green"))
	draw_rect(Rect2(120,120,64,64),ColorN("Orange"))
	draw_rect(Rect2(120,120,1,1),ColorN("Blue"))
	
	draw_rect(Rect2(512,300,64,64),ColorN("Maroon"))
	
	draw_rect(Rect2(1024-16,600-16,16,16),ColorN("Orange"))
	draw_rect(Rect2(1024-16,0,16,16),ColorN("Orange"))
	draw_rect(Rect2(0,600-16,16,16),ColorN("Orange"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
