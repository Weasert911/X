shader_type spatial;
render_mode unshaded;

uniform vec3 tint_color : source_color = vec3(1.0, 0.0, 0.0);
uniform float tint_strength : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	ALBEDO = tint_color;
	ALPHA = 1.0;
}