shader_type canvas_item;

uniform float range : hint_range(0.0, 1.0, 0.01) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if (UV.y < range && color.a > 0.25) {
		color.a = 0.25;
	}
	COLOR = color;
}
