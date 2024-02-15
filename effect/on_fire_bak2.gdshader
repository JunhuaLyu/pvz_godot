shader_type canvas_item;
uniform sampler2D noise_texture;
uniform float noise_speed : hint_range(0.0, 1.0, 0.01) = 1.0;
uniform float noise_size : hint_range(0.0, 10.0, 0.01) = 5.0;
uniform vec4 edge_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 noise_uv = UV;
	noise_uv.y = noise_uv.y + TIME;
	noise_uv.y = float(uint(noise_uv.y * 100.0) % uint(100)) / 100.0;
	noise_uv.y = clamp(noise_uv.y, 0.0, 1.0);
	vec4 noise_color = texture(noise_texture, noise_uv);
	//vec4 noise_color = vec4(1.0, 1.0, 1.0, 1.0);
	float noise = clamp(pow(noise_color.r, noise_size), 0.0, 1.0);
	vec2 uv_1 = clamp(UV + noise, vec2(0.0), vec2(1.0));
	float tex_color_a = texture(TEXTURE, uv_1).a;
	COLOR = vec4(uv_1, 0.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
