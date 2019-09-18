Generation III Pokémon style reflections in Godot using a Viewport Texture as a mask.

Done using a separate viewport that isn’t rendered to the screen but instead its texture is used in a shader as an alpha mask. This can be used for much more than just reflections, you could also use it to mask objects that are supposed to be above the player but are actually below it in the scene tree, fog of war, etc.

_See `robots` branch for example with 500 moving sprites._

![Screenshot](https://github.com/McSpider/Reflections/blob/pokemon/Images/Screenshot.png)



#### Scenes
`pokemon.tscn` the main scene  
Draws reflections to a viewport and then mask a sprite containing its texture, also does Y sorting. With character camera.


#### Scene Tree
`M Viewport` - Viewport used to render the mask.  
`• Sprite` - Sprite defining the areas to mask for reflections. Opacity defines opacity of reflection. (Modulated to black, makes the mask area easier to debug using the `Mask` sprite)  
`R Viewport` - Viewport used to render the reflections.  
`• YSort` - Container for our reflections.  
`ViewportContainer/Viewport` - Main viewport used to render the scene.  
`• Background` - A sprite containing the game background/terrain, this could be a tilemap or anything else.  
`• Mask` - A sprite with the texture from `M Viewport`, used to debug where reflections will be shown.  
`• Reflections` - A sprite with the texture from `R Viewport`, draws the reflections to the scene.  
`·• YSort` - Container for our reflection test objects.  
`··• Cursor Char` - Character that tracks the mouse cursor.  
`··• Player` - Character that moves with the keyboard arrow keys.  
`···• Reflection` - Character reflection, gets re-parented to `R Viewport/YSort` on scene load. Position linked with that of `Player` by the script attached it.  
`···• Camera2D` - The main camera of the scene, this camera gets mirrored to the mask and reflection viewports.  
`··• Static Character` - Character that does not move.


#### Notes
I’m using sprites with a single texture as the background and mask, however this can be whatever you want, anything drawn inside the mask viewport will act as a mask if it has any opacity.

In this example all nodes are referenced by path wherever needed, e.g. `/root/Control/ViewportContainer/Viewport` Ideally in a final game you would setup a singleton to manage your reflections instead of accessing the nodes directly.

The mask viewport has to be setup with "Transparent Bg" checked and "Render Target">"Update Mode" set to Always.

While `M Viewport` and `R Viewport` are simple enough to set up using a script instead of the scene editor this did not work properly when I tried to do so. Viewports created using a script exhibited tearing and lagged behind when rendering.

`M Viewport` and `R Viewport` mirror the size of the main viewport and have a camera that tracks the main camera.  
`Mask` and `Reflections` sprites overlay the entire scene and have a script attached to keep their positions correct relative to the camera.  

A camera needs to be setup inside the mask viewport that exactly mirrors the current camera. I'm doing this by putting it in a Node2D which gets the characters position assigned to it every frame, thus tracking it exactly.
Additionally if the window is re-sizable the mask viewport needs to track the main viewports size, it does not do so automatically since it is not inside a ViewportContainer. (We don’t want it to be in one either, otherwise it draws to the screen.)

"Flip V" needs to be enabled on sprites using the texture, this is because viewport textures are upside down due to engine design constraints

When the viewport is resized nodes using the ViewportTextures need to be flagged so their size updates, currently done by toggling the centered property on viewport resize. If the node is inside the scene with the main camera it either needs to be in a separate canvas layer (which cuases problems when trying to layer it with the scene) or its position needs to be adjusted when the camera moves. This can be done by using the origin of the inverse of the viewport transform.

Extending this for split screen/multiple viewports gets slightly more convoluted since you need to create a separate mask viewport with camera for each active viewport/camera.

If the mask camera does not exactly track the main camera the mask will not line up, this is because we are using screen uv coordinates to apply it. Same applies for the mask viewport size.

When reflecting multiple objects the reflections will overlap and blend, this is fixed by rendering the reflections into a separate viewport at full opacity and then using that viewport texture in a sprite that is being masked. This can be avoided if you can guarantee that reflections never overlap, or you don't care that they look glitchy.

To use `Shader.tres` load it to the sprite/whatever and then make it unique by right clicking.

![Visual Shader Screenshot](https://github.com/McSpider/Reflections/blob/pokemon/Images/Visual%20Shader.png)

The visual shader multiplies the alpha value of the mask texture with the sprites alpha value.

![Scene Tree Screenshot](https://github.com/McSpider/Reflections/blob/pokemon/Images/Scene%20Tree.png)



#### Known Issues
When resizing the window in the `pokemon.tscn` the mask will stay aligned while resizing but once the resize is done it won't line up anymore. This is because after the window resizes the sprites snap to slightly different locations and the camera doesn't update for this. Once the position of the camera updates everything lines up again.


#### Credits
[Kyle-Dove](https://www.deviantart.com/kyle-dove/art/Hoenn-People-Overworlds-WIP-135091898) - Pokémon style people  
[Magiscarf](https://www.deviantart.com/magiscarf/art/Tileset-ver-3-Free--690477146) - Pokemon style tileset  
[ChaoticCherryCake](https://www.deviantart.com/chaoticcherrycake/art/Pokemon-Tileset-From-Public-Tiles-32x32-623246343) - Pokemon style tileset  
