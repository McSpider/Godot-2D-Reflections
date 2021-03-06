Generation III Pokémon style reflections in Godot using a Viewport Texture as a mask.

Done using a separate viewport that isn’t rendered to the screen but instead its texture is used in a shader as an alpha mask. This can be used for much more than just reflections, you could also use it to mask objects that are supposed to be above the player but are actually below it in the scene tree, fog of war, etc.

![Screenshot](https://github.com/McSpider/Reflections/blob/master/Images/Screenshot.png)



#### Scenes
`test1.tscn`  
Masks reflections directly on the individual sprites, doesn't look quite right when multiple reflections overlap. No camera.

`test2.tscn`  
Draws reflections to a viewport and then masks a sprite containing its texture, also does Y sorting. No camera.

`pokemon.tscn` the main scene  
Draws reflections to a viewport and then mask a sprite containing its texture, also does Y sorting. With character camera.



#### Notes
I’m using sprites with a single texture as the background and mask, however this can be whatever you want, anything drawn inside the mask viewport will act as a mask if it has any opacity.
For example “example2.tscn" is using `draw_rect` to draw the mask, and is also rendering the mask to the screen using a sprite with its texture set to ViewportTexture.

The mask viewport has to be setup with "Transparent Bg" checked and "Render Target">"Update Mode" set to Always.

A camera needs to be setup inside the mask viewport that exactly mirrors the current camera. I'm doing this by putting it in a Node2D which gets the characters position assigned to it every frame, thus tracking it exactly.
Additionally if the window is re-sizable the mask viewport needs to track the main viewports size, it does not do so automatically since it is not inside a ViewportContainer. (We don’t want it to be in one either, otherwise it draws to the screen.)

Extending this for split screen/multiple viewports gets slightly more convoluted since you need to create a separate mask viewport with camera for each active viewport/camera.

If the mask camera does not exactly track the main camera the mask will not line up, this is because we are using screen uv coordinates to apply it. Same applies for the mask viewport size.

When reflecting multiple objects the reflections will overlap and blend, this is fixed by rendering the reflections into a separate viewport at full opacity and then using that viewport texture in a sprite that is being masked.

When using the mask or reflection viewport textures "Flip V" needs to be checked, otherwise everything will be upside down.

To use `Shader.tres` load it to the sprite/whatever and then make it unique by right clicking.

![Visual Shader Screenshot](https://github.com/McSpider/Reflections/blob/master/Images/Visual%20Shader.png)

The visual shader flips the alpha value in the mask and then subtracts it from the sprites alpha value making sure it does not go below zero.

![Scene Tree Screenshot](https://github.com/McSpider/Reflections/blob/master/Images/Scene%20Tree.png)



#### Credits
[Kyle-Dove](https://www.deviantart.com/kyle-dove/art/Hoenn-People-Overworlds-WIP-135091898) - Pokémon style people  
[Magiscarf](https://www.deviantart.com/magiscarf/art/Tileset-ver-3-Free--690477146) - Pokemon style tileset  
[ChaoticCherryCake](https://www.deviantart.com/chaoticcherrycake/art/Pokemon-Tileset-From-Public-Tiles-32x32-623246343) - Pokemon style tileset  
