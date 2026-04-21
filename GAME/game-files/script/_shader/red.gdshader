shader_type spatial;

uniform vec3 tint_color : source_color = vec3(1.0, 0.0, 0.0);
uniform float roughness_val : hint_range(0.0, 1.0) = 0.55;

void fragment() {
	ALBEDO = tint_color;
	ROUGHNESS = roughness_val;
	SPECULAR = 0.2;
}

void light() {
	float ndotl = max(dot(NORMAL, LIGHT), 0.0);
	DIFFUSE_LIGHT += ALBEDO * LIGHT_COLOR * ATTENUATION * ndotl;
}