extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var viewport_center= Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2)
	var norm_pos = mouse_pos - viewport_center
	if !get_viewport_rect().grow(-10).has_point(mouse_pos):
		return

	var step = 2
	var x_limits = get_viewport_rect().size.x/2.5
	if (norm_pos.x > x_limits):
		self.position += Vector2(step,0)
	elif (norm_pos.x < -(x_limits)):
		self.position += Vector2(-step,0)
	
	var y_limits = get_viewport_rect().size.y/2.5
	if (norm_pos.y > y_limits):
		self.position += Vector2(0,step)
	elif (norm_pos.y < -(y_limits)):
		self.position += Vector2(0,-step)
	
#	get_node("/root/Node2D/Viewport/Camera2D").position = self.position*-1
