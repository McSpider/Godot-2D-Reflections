extends Sprite

# Applied to nodes inside the main viewport that contain a viewport texture and should not move with the camera.
# Instead they should be fixed to the viewport origin so their contents line up properly.

func _ready():
	self.centered = false
	get_viewport().connect('size_changed', self, 'main_viewport_resized')
	
	# Not actually valid, only works for 3D camera,
	#  so we have to connect the signal from the actual camera...
	# https://github.com/godotengine/godot/issues/5411
	#get_viewport().get_camera().connect("camera_moved", self, "main_camera_moved")


func _draw():
	# Debug position/size of this sprite.
	#draw_rect(self.get_rect().abs().grow(-1),ColorN("Orange"),false)
	pass

func main_camera_moved(linked_object, camera):
	# Sprite size does not update when the viewport texture updates
	#  force update it by toggling the centered property.
	self.centered = !self.centered
	self.centered = !self.centered
	
	# top left corner of viewport
	self.position = get_viewport_transform().affine_inverse().get_origin()

# Undo camera scaling since the ViewportTextures viewport already does the zoom through its own camera
# NOTE: this needs to be called manually or through a signal whenever the camera zoom is changed or the camera is switched.
func main_camera_changed(linked_object, camera):
	self.scale = camera.zoom

# Last resize event of window doesn't seem to call size_changed on the viewport?
#  doing fast resizes makes stuff not line up until the camera moves.
#  Probably because it's the sprites/viewport locations that are snapping into place after resize
#  need to call main_camera_moved (on this/the viewports) after doing a resize
# Sprite size does not update when the viewport texture updates
#  force update it by toggling the centered property.
# https://github.com/godotengine/godot/issues/8924#issuecomment-304413387
func main_viewport_resized():
	self.centered = !self.centered
	self.centered = !self.centered
	
	# top left corner of viewport
	self.position = get_viewport_transform().affine_inverse().get_origin()
