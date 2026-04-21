shader_type canvas_item;

// Uniforms for artistic control
uniform float contrast = 1.8;
uniform int bands = 3;

// Screen texture uniform (required in Godot 4)
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform float outline_thickness = 1.2;
uniform float edge_threshold = 0.12;
uniform float outline_intensity = 1.2;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform float edge_darkening = 0.3;
uniform float ink_variation = 0.05;

// Luminance calculation function
float calculate_luminance(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}

// Posterization function - reduces to discrete bands
vec3 posterize(vec3 color, int band_count) {
    float lum = calculate_luminance(color);
    float step = 1.0 / float(band_count - 1);
    float band = floor(lum * float(band_count - 1) + 0.5) * step;
    
    // Maintain original color ratios while quantizing luminance
    return color * (band / max(lum, 0.0001));
}

// Contrast enhancement
vec3 apply_contrast(vec3 color, float contrast_amount) {
    // Contrast centered around 0.5
    return (color - 0.5) * contrast_amount + 0.5;
}

// Edge detection using 4-direction sampling
float detect_edges(vec2 uv, float base_lum) {
    // Calculate pixel size from screen texture dimensions
    vec2 pixel_size = (1.0 / vec2(textureSize(SCREEN_TEXTURE, 0))) * outline_thickness;
    
    // Get current fragment color
    vec3 current_color = texture(SCREEN_TEXTURE, uv).rgb;
    
    // Sample neighbors in 4 directions
    vec3 up = texture(SCREEN_TEXTURE, uv + vec2(0.0, pixel_size.y)).rgb;
    vec3 down = texture(SCREEN_TEXTURE, uv - vec2(0.0, pixel_size.y)).rgb;
    vec3 left = texture(SCREEN_TEXTURE, uv - vec2(pixel_size.x, 0.0)).rgb;
    vec3 right = texture(SCREEN_TEXTURE, uv + vec2(pixel_size.x, 0.0)).rgb;
    
    // Calculate luminance differences
    float diff_up = abs(base_lum - calculate_luminance(up));
    float diff_down = abs(base_lum - calculate_luminance(down));
    float diff_left = abs(base_lum - calculate_luminance(left));
    float diff_right = abs(base_lum - calculate_luminance(right));
    
    // Calculate color differences
    vec3 diff_up_color = abs(current_color - up);
    vec3 diff_down_color = abs(current_color - down);
    vec3 diff_left_color = abs(current_color - left);
    vec3 diff_right_color = abs(current_color - right);
    
    // Combine luminance and color differences
    float lum_diff = max(max(diff_up, diff_down), max(diff_left, diff_right));
    float color_diff = max(
        max(max(diff_up_color.r, diff_up_color.g), max(diff_up_color.b, diff_down_color.r)),
        max(max(diff_down_color.g, diff_down_color.b), max(diff_left_color.r, diff_left_color.g))
    );
    float edge = max(lum_diff, color_diff);
    
    return smoothstep(edge_threshold - 0.02, edge_threshold + 0.02, edge);
}

// Subtle ink imperfection using screen-space noise
float ink_noise(vec2 uv) {
    // Low-frequency noise with subtle variation
    vec2 noise_uv = uv * 0.5;
    float noise1 = fract(sin(dot(noise_uv, vec2(12.9898, 78.233))) * 43758.5453);
    float noise2 = fract(sin(dot(noise_uv.yx, vec2(12.9898, 78.233))) * 43758.5453);
    vec2 noise = vec2(noise1, noise2);
    
    // Scale by variation amount
    return mix(1.0 - ink_variation, 1.0 + ink_variation, noise.x);
}

void fragment() {
    // 1. Sample base color
    vec4 base_color = texture(SCREEN_TEXTURE, UV);
    
    // 2. Detect edges (using original color)
    float edge = detect_edges(UV, calculate_luminance(base_color.rgb));
    
    // 3. Apply contrast
    vec3 processed_color = apply_contrast(base_color.rgb, contrast);
    
    // 4. Apply posterization
    processed_color = posterize(processed_color, bands);
    
    // 5. Apply edge darkening
    processed_color *= (1.0 - edge * edge_darkening);
    
    // 6. Apply outline blending
    vec4 final_color = vec4(processed_color, base_color.a);
    float outline_strength = edge * outline_intensity;
    final_color = mix(final_color, outline_color, outline_strength);
    
    // 7. Apply subtle ink variation
    final_color.rgb *= ink_noise(UV);
    
    // Output final color
    COLOR = final_color;
}