extends Viewport

# Applied to the mask and reflection viewports uses signals from the current camera to keep
#  the viewport syncronized.
# These viewports need to contain a node with a Camera2D as the child

# The node that contains the current camera needs to have the main_camera_moved signal.
# The viewport that contains the current camera needs to have the main_viewport_resized signal.

onready var camera_container = null
onready var camera = null

func _ready():
	# Get the viewport we are supposed to track,
	#  could be done other ways.
	var viewport = get_node("/root/Control/ViewportContainer/Viewport")
	viewport.connect('size_changed', self, 'main_viewport_resized', [viewport])
	
	# Setup camera programatically since we will always need it
	var _camera_container = Node2D.new()
	_camera_container.name = "CameraContainer"
	var _camera = Camera2D.new()
	_camera.name = "Camera2D"
	_camera.current = true
	_camera_container.add_child(_camera)
	add_child(_camera_container)
	camera_container = _camera_container
	camera = _camera


func main_camera_moved(linked_object, main_camera):
	camera_container.position = linked_object.position

# When the main camera changes zoom, etc. this needs to be mirrored to the "CameraContainer/Camera2D"
func main_camera_changed(linked_object, main_camera):
	camera_container.position = linked_object.position
	camera.zoom = main_camera.zoom
	camera.drag_margin_h_enabled = main_camera.drag_margin_h_enabled
	camera.drag_margin_v_enabled = main_camera.drag_margin_v_enabled
	camera.drag_margin_left = main_camera.drag_margin_left
	camera.drag_margin_right = main_camera.drag_margin_right
	camera.drag_margin_top = main_camera.drag_margin_top
	camera.drag_margin_bottom = main_camera.drag_margin_bottom
	# TODO: Do other properties we may need as well

func main_viewport_resized(viewport):
	set_size(viewport.size)
