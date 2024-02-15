shader_type canvas_item;
uniform sampler2D noise_texture;
uniform float noise_speed : hint_range(0.0, 1.0, 0.01) = 1.0;
uniform float noise_size : hint_range(0.0, 1.0, 0.01) = 1.0;
uniform vec4 edge_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 base_color = texture(TEXTURE, UV);
	
	vec2 noise_uv = UV;
	noise_uv.y = noise_uv.y + TIME * noise_speed;
	noise_uv.y = float(uint(noise_uv.y * 100.0) % uint(100)) / 100.0;
	vec4 noise_color = texture(noise_texture, noise_uv);
	float noise = pow(noise_color.r, 5.0) * noise_size;
	
	vec2 uv = UV;
	vec2 uv_1 = clamp(uv + noise, vec2(0.0), vec2(1.0));
	vec2 uv_2 = clamp(uv - noise, vec2(0.0), vec2(1.0));
	// 提取透明通道
	float tex_color_a = texture(TEXTURE, uv_1).a;
	tex_color_a += texture(TEXTURE, uv_2).a;
	tex_color_a = clamp(tex_color_a, 0.0, 1.0);
	
	// 边缘颜色
	vec4 _edge_color = edge_color;
	_edge_color.a = edge_color.a * tex_color_a;
	
	vec4 outline_color = mix(base_color, _edge_color, clamp(tex_color_a - base_color.a, 0.0, 1.0));
	COLOR = outline_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
