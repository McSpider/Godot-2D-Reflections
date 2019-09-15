extends Viewport

# Since the mask viewport is not inside a ViewportContainer
#  we have to manually make it match the main viewport.
# We do this by listening to the size changed signal and then updating the mask viewport size.

# Called when the node enters the scene tree for the first time.
func _ready():
	connect('size_changed', self, '_on_viewport_size_changed')
	pass # Replace with function body.

func _on_viewport_size_changed():
	get_node("/root/Control/Viewport").set_size(size)
