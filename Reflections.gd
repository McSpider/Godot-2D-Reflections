extends Sprite

# Applied to nodes inside the main viewport that contain a viewport texture and should not move with the camera.
# Instead they should be fixed to the center of the window so their contents line up properly.

func _ready():
	# Undo Camera scaling since the ViewportTextures viewport already does the zoom
	self.scale = get_parent().get_node("YSort/Player/Camera2D").zoom
	# Center texture since we are using get_camera_screen_center to position the sprite
	self.centered = true

func _physics_process(delta):
	self.position = get_parent().get_node("YSort/Player/Camera2D").get_camera_screen_center()
