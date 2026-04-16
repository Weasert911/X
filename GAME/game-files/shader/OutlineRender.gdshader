shader_type canvas_item;
render_mode blend_mix;

// Outline render: creates thick black outlines from edge mask
// Expects edge mask in screen_texture (white = edges)

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float outline_thickness : hint_range(0.0, 10.0) = 2.0;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_intensity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 pixel_size = 1.0 / SCREEN_PIXEL_SIZE;
	
	// Sample edge mask at current pixel
	float center = texture(screen_texture, uv).r;
	
	// Dilate by sampling neighbors within thickness radius
	float max_dist = outline_thickness;
	float outline = center;
	
	for (float dx = -max_dist; dx <= max_dist; dx += 1.0) {
		for (float dy = -max_dist; dy <= max_dist; dy += 1.0) {
			// Skip center
			if (dx == 0.0 && dy == 0.0) continue;
			vec2 offset = vec2(dx, dy) * pixel_size;
			float sample = texture(screen_texture, uv + offset).r;
			outline = max(outline, sample);
		}
	}
	
	// Combine with original scene (assuming screen_texture contains the scene)
	// In a real pipeline you'd sample the scene from another texture,
	// but for simplicity we'll assume screen_texture is the scene.
	// We'll need to separate edge mask from scene; we'll assume we have a separate pass.
	// For now, we'll just output outline color where outline > 0.
	
	// For demonstration, we output outline mask as black overlay
	vec4 scene_color = texture(screen_texture, uv);
	vec4 final_color = mix(scene_color, outline_color, outline * outline_intensity);
	
	COLOR = final_color;
}