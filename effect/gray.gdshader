shader_type canvas_item;

//uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float range : hint_range(0.0, 1.0, 0.01) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//vec4 color = textureLod(screen_texture, SCREEN_UV, 0.0);
	vec4 color = texture(TEXTURE, UV);

	if (UV.y < range) {
		color.r = (color.r + color.g + color.b) / 3.0;
		color.g = color.r;
		color.b = color.r;
	}
	COLOR = color;
}
