shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform float contrast : hint_range(0.0, 4.0) = 1.8;
uniform float hatch_scale : hint_range(50.0, 400.0) = 260.0;
uniform float hatch_angle : hint_range(0.0, 180.0) = 135.0;
uniform float hatch_softness : hint_range(0.0, 1.0) = 0.05;
uniform float black_level : hint_range(0.0, 1.0) = 0.20;
uniform float white_level : hint_range(0.0, 1.0) = 0.92;

uniform vec3 red_keep_color : source_color = vec3(1.0, 0.0, 0.0);
uniform float red_threshold : hint_range(0.0, 1.0) = 0.20;
uniform float red_keep_strength : hint_range(0.0, 1.0) = 1.0;

float luma(vec3 c) {
	return dot(c, vec3(0.299, 0.587, 0.114));
}

vec2 rotate2d(vec2 p, float a) {
	float c = cos(a);
	float s = sin(a);
	return vec2(c * p.x - s * p.y, s * p.x + c * p.y);
}

float hatch(vec2 uv, float angle, float scale) {
	vec2 p = rotate2d(uv * scale, radians(angle));
	float line = abs(fract(p.x) - 0.5);
	return 1.0 - smoothstep(0.0, hatch_softness, line);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec3 col = texture(screen_texture, uv).rgb;

	float red_mask = step(red_threshold, col.r - max(col.g, col.b));

	vec3 out_col;

	if (red_mask > 0.5) {
		float g = luma(col);
		out_col = mix(vec3(g), red_keep_color, red_keep_strength);
	} else {
		float gray = luma(col);
		gray = (gray - 0.5) * contrast + 0.5;
		gray = clamp(gray, 0.0, 1.0);

		float dark = 1.0 - smoothstep(black_level, white_level, gray);

		float h1 = hatch(uv, hatch_angle, hatch_scale);
		float h2 = hatch(uv + vec2(0.003, 0.002), hatch_angle + 90.0, hatch_scale * 0.75);
		float lines = max(h1, h2 * 0.8);

		float ink = dark * mix(0.25, 1.0, lines);
		out_col = vec3(1.0 - ink);
	}

	COLOR = vec4(out_col, 1.0);
}