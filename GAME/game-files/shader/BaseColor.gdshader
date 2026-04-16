shader_type canvas_item;
render_mode blend_mix;

// Base color adjustment shader
// Pass-through with contrast and saturation boost

uniform float contrast : hint_range(0.5, 2.0, 0.01) = 1.2;
uniform float saturation : hint_range(0.0, 3.0, 0.01) = 1.3;
uniform float brightness : hint_range(0.5, 1.5, 0.01) = 1.0;

void fragment() {
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	// Apply brightness
	vec3 color = screen_color.rgb * brightness;
	
	// Apply contrast
	color = (color - 0.5) * contrast + 0.5;
	
	// Apply saturation
	float luminance = dot(color, vec3(0.299, 0.587, 0.114));
	color = mix(vec3(luminance), color, saturation);
	
	COLOR = vec4(color, screen_color.a);
}