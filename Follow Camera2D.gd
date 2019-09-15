extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	update_target()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_target()


	# Mask Camera needs to have the same setup as the currently active camera
	# if it does not then the mask will not line up, this is because we are using screen uv coordinates to apply the mask.
func update_target():
		get_node("/root/Control/Viewport/Node2D").position = self.get_parent().position# - Vector2(512,300)
