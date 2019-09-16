extends Viewport

# Since the mask and reflection viewports are not inside a ViewportContainer
#  we have to manually make them match the main viewport.
# We do this by listening to the size changed signal and then updating their sizes.

func _ready():
	connect('size_changed', self, '_on_viewport_size_changed')

func _on_viewport_size_changed():
	get_node("/root/Control/Viewport").set_size(size)
	get_node("/root/Control/R Viewport").set_size(size)
	# TODO: changing viewport size also modifies the reflections position...
