shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform float contrast : hint_range(0.0, 4.0) = 3.0;
uniform float hatch_scale : hint_range(50.0, 800.0) = 420.0;
uniform float hatch_angle : hint_range(0.0, 180.0) = 135.0;
uniform float hatch_softness : hint_range(0.0, 1.0) = 0.03;
uniform float black_level : hint_range(0.0, 1.0) = 0.26;
uniform float white_level : hint_range(0.0, 1.0) = 0.76;

uniform vec3 red_keep_color : source_color = vec3(1.0, 0.0, 0.0);
uniform float red_threshold : hint_range(0.0, 1.0) = 0.10;
uniform float red_keep_strength : hint_range(0.0, 1.0) = 1.0;

uniform float vignette_strength : hint_range(0.0, 1.0) = 0.92;
uniform float grain_strength : hint_range(0.0, 1.0) = 0.13;
uniform float shadow_crush : hint_range(0.0, 3.0) = 2.05;
uniform float highlight_fade : hint_range(0.0, 2.0) = 0.55;

uniform float outline_strength : hint_range(0.0, 5.0) = 2.2;
uniform float outline_threshold : hint_range(0.0, 1.0) = 0.07;
uniform vec3 outline_color : source_color = vec3(0.0, 0.0, 0.0);

float luma(vec3 c) {
	return dot(c, vec3(0.299, 0.587, 0.114));
}

vec2 rotate2d(vec2 p, float a) {
	float c = cos(a);
	float s = sin(a);
	return vec2(c * p.x - s * p.y, s * p.x + c * p.y);
}

float hash12(vec2 p) {
	p = fract(p * vec2(123.34, 456.21));
	p += dot(p, p + 45.32);
	return fract(p.x * p.y);
}

float hatch(vec2 uv, float angle, float scale) {
	vec2 p = rotate2d(uv * scale, radians(angle));
	float line = abs(fract(p.x) - 0.5);
	return 1.0 - smoothstep(0.0, hatch_softness, line);
}

float edge_detect(vec2 uv) {
	vec2 tex_size = vec2(textureSize(screen_texture, 0));
	vec2 px = 1.0 / tex_size;

	float c1 = luma(texture(screen_texture, uv + vec2(px.x, 0.0)).rgb);
	float c2 = luma(texture(screen_texture, uv - vec2(px.x, 0.0)).rgb);
	float c3 = luma(texture(screen_texture, uv + vec2(0.0, px.y)).rgb);
	float c4 = luma(texture(screen_texture, uv - vec2(0.0, px.y)).rgb);

	float dx = abs(c1 - c2);
	float dy = abs(c3 - c4);

	return clamp((dx + dy) * outline_strength, 0.0, 1.0);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec3 col = texture(screen_texture, uv).rgb;

	float red_mask = step(red_threshold, col.r - max(col.g, col.b));

	vec3 out_col;

	if (red_mask > 0.5) {
		float g = luma(col);
		out_col = mix(vec3(g * 0.5), red_keep_color, red_keep_strength);
	} else {
		float gray = luma(col);
		gray = pow(clamp(gray, 0.0, 1.0), shadow_crush);
		gray = (gray - 0.5) * contrast + 0.5;
		gray = clamp(gray, 0.0, 1.0);
		gray = mix(gray, gray * 0.72, highlight_fade);

		float dark = 1.0 - smoothstep(black_level, white_level, gray);

		float h1 = hatch(uv, hatch_angle, hatch_scale);
		float h2 = hatch(uv + vec2(0.003, 0.002), hatch_angle + 90.0, hatch_scale * 0.72);
		float h3 = hatch(uv + vec2(0.006, -0.004), hatch_angle + 45.0, hatch_scale * 0.58);
		float lines = max(max(h1, h2 * 0.85), h3 * 0.55);

		float ink = dark * mix(0.05, 1.0, lines);
		vec3 bw = vec3(1.0 - ink);

		float g = hash12(uv * vec2(1800.0, 1100.0) + TIME * 2.0) - 0.5;
		bw += g * grain_strength;

		float vig = smoothstep(1.0, 0.12, distance(uv, vec2(0.5)));
		bw *= mix(1.0, vig, vignette_strength);

		bw = pow(clamp(bw, 0.0, 1.0), vec3(1.15));

		out_col = clamp(bw, 0.0, 1.0);
	}

	float edge = edge_detect(uv);
	out_col = mix(out_col, outline_color, smoothstep(outline_threshold, outline_threshold + 0.18, edge));

	COLOR = vec4(out_col, 1.0);
}