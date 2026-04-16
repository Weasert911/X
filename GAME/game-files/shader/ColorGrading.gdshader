shader_type canvas_item;
render_mode blend_mix;

// Color grading with Indian street vibe
// Warm highlights, cool shadows, high contrast midtones

uniform float warmth : hint_range(0.0, 2.0, 0.01) = 1.2;
uniform float cool_shadows : hint_range(0.0, 1.0, 0.01) = 0.3;
uniform float contrast : hint_range(0.5, 2.0, 0.01) = 1.4;
uniform float saturation : hint_range(0.0, 2.0, 0.01) = 1.1;
uniform float vibrance : hint_range(0.0, 2.0, 0.01) = 1.3;

void fragment() {
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec3 color = screen_color.rgb;
	
	// Apply contrast
	color = (color - 0.5) * contrast + 0.5;
	
	// Apply saturation with vibrance (boost less saturated colors more)
	float lum = dot(color, vec3(0.299, 0.587, 0.114));
	vec3 diff = color - lum;
	float sat = length(diff);
	float sat_boost = 1.0 + (vibrance - 1.0) * (1.0 - sat);
	color = lum + diff * saturation * sat_boost;
	
	// Split‑toning: warm highlights, cool shadows
	float highlight_mask = smoothstep(0.6, 0.9, lum);
	float shadow_mask = smoothstep(0.1, 0.4, lum);
	
	// Warm tint (yellow‑orange)
	vec3 warm_tint = vec3(1.0, 0.85, 0.6);
	// Cool tint (blue‑cyan)
	vec3 cool_tint = vec3(0.6, 0.8, 1.0);
	
	color = mix(color, color * warm_tint, highlight_mask * warmth);
	color = mix(color, color * cool_tint, (1.0 - shadow_mask) * cool_shadows);
	
	// Clamp to avoid overshoot
	color = clamp(color, 0.0, 1.0);
	
	COLOR = vec4(color, screen_color.a);
}