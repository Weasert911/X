shader_type canvas_item;
render_mode blend_mix;
uniform int bands : hint_range(2, 6) = 4;
uniform float brightness : hint_range(0.0, 2.0) = 1.0;
uniform float contrast : hint_range(0.0, 2.0) = 1.0;
uniform float saturation : hint_range(0.0, 2.0) = 1.0;
uniform float outline_thickness : hint_range(0.0, 5.0) = 1.0;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_intensity : hint_range(0.0, 1.0) = 1.0;
uniform float color_threshold : hint_range(0.0, 1.0) = 0.1;
uniform float depth_threshold : hint_range(0.0, 1.0) = 0.01;
uniform float edge_darkening : hint_range(0.0, 1.0) = 0.0;
uniform float depth_influence : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D DEPTH_TEXTURE;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
float get_luminance(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}
float linearize_depth(float depth) {
    float near = 0.1;
    float far = 1000.0;
    return (2.0 * near) / (far + near - depth * (far - near));
}
vec3 apply_brightness_contrast(vec3 color, float brightness_param, float contrast_param) {
    vec3 result = color * brightness_param;
    result = (result - 0.5) * contrast_param + 0.5;
    return result;
}
vec3 apply_saturation(vec3 color, float saturation_param) {
    float luminance = get_luminance(color);
    return mix(vec3(luminance), color, saturation_param);
}
float quantize_luminance(float luminance, int band_count) {
    float band_size = 1.0 / float(band_count);
    float band = floor(luminance / band_size);
    float quantized = (band + 0.5) * band_size;
    return clamp(quantized, 0.0, 1.0);
}
vec3 apply_toon_shading(vec3 color, int band_count) {
    float luminance = get_luminance(color);
    float quantized_luminance = quantize_luminance(luminance, band_count);
    vec3 result = color * (quantized_luminance / (luminance + 0.0001));
    return result;
}
void fragment() {
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    float depth = texture(DEPTH_TEXTURE, SCREEN_UV).r;
    float linear_depth = linearize_depth(depth);
    vec3 toon_color = apply_toon_shading(screen_color.rgb, bands);
    toon_color = apply_brightness_contrast(toon_color, brightness, contrast);
    toon_color = apply_saturation(toon_color, saturation);
    float depth_factor = mix(1.0, linear_depth, depth_influence);
    float offset = outline_thickness * SCREEN_PIXEL_SIZE.x * depth_factor;
    offset = clamp(offset, 0.0, 0.01);
    vec2 uv_tl = SCREEN_UV + vec2(-offset, -offset); 
    vec2 uv_tc = SCREEN_UV + vec2(0.0, -offset);     
    vec2 uv_tr = SCREEN_UV + vec2(offset, -offset);  
    vec2 uv_cl = SCREEN_UV + vec2(-offset, 0.0);     
    vec2 uv_cr = SCREEN_UV + vec2(offset, 0.0);      
    vec2 uv_bl = SCREEN_UV + vec2(-offset, offset);  
    vec2 uv_bc = SCREEN_UV + vec2(0.0, offset);      
    vec2 uv_br = SCREEN_UV + vec2(offset, offset);   
    float depth_tl = texture(DEPTH_TEXTURE, uv_tl).r;
    float depth_tc = texture(DEPTH_TEXTURE, uv_tc).r;
    float depth_tr = texture(DEPTH_TEXTURE, uv_tr).r;
    float depth_cl = texture(DEPTH_TEXTURE, uv_cl).r;
    float depth_cr = texture(DEPTH_TEXTURE, uv_cr).r;
    float depth_bl = texture(DEPTH_TEXTURE, uv_bl).r;
    float depth_bc = texture(DEPTH_TEXTURE, uv_bc).r;
    float depth_br = texture(DEPTH_TEXTURE, uv_br).r;
    vec3 color_tl = texture(SCREEN_TEXTURE, uv_tl).rgb;
    vec3 color_tc = texture(SCREEN_TEXTURE, uv_tc).rgb;
    vec3 color_tr = texture(SCREEN_TEXTURE, uv_tr).rgb;
    vec3 color_cl = texture(SCREEN_TEXTURE, uv_cl).rgb;
    vec3 color_cr = texture(SCREEN_TEXTURE, uv_cr).rgb;
    vec3 color_bl = texture(SCREEN_TEXTURE, uv_bl).rgb;
    vec3 color_bc = texture(SCREEN_TEXTURE, uv_bc).rgb;
    vec3 color_br = texture(SCREEN_TEXTURE, uv_br).rgb;
    float lum_tl = get_luminance(color_tl);
    float lum_tc = get_luminance(color_tc);
    float lum_tr = get_luminance(color_tr);
    float lum_cl = get_luminance(color_cl);
    float lum_cr = get_luminance(color_cr);
    float lum_bl = get_luminance(color_bl);
    float lum_bc = get_luminance(color_bc);
    float lum_br = get_luminance(color_br);
    float depth_sobel_x = (-depth_tl) + (depth_tr) + (-2.0 * depth_cl) + (2.0 * depth_cr) + (-depth_bl) + (depth_br);
    float depth_sobel_y = (-depth_tl) + (-2.0 * depth_tc) + (-depth_tr) + (depth_bl) + (2.0 * depth_bc) + (depth_br);
    float depth_edge = sqrt(depth_sobel_x * depth_sobel_x + depth_sobel_y * depth_sobel_y);
    float color_sobel_x = (-lum_tl) + (lum_tr) + (-2.0 * lum_cl) + (2.0 * lum_cr) + (-lum_bl) + (lum_br);
    float color_sobel_y = (-lum_tl) + (-2.0 * lum_tc) + (-lum_tr) + (lum_bl) + (2.0 * lum_bc) + (lum_br);
    float color_edge = sqrt(color_sobel_x * color_sobel_x + color_sobel_y * color_sobel_y);
    float depth_edge_smooth = smoothstep(depth_threshold * 0.5, depth_threshold, depth_edge);
    float color_edge_smooth = smoothstep(color_threshold * 0.5, color_threshold, color_edge);
    float combined_edge = max(depth_edge_smooth, color_edge_smooth);
    float is_sky = smoothstep(0.99, 1.0, depth);
    combined_edge *= (1.0 - is_sky * 0.8);
    float edge_factor = combined_edge * outline_intensity;
    vec3 darkened_toon = toon_color * (1.0 - edge_factor * edge_darkening);
    vec3 final_color = mix(darkened_toon, outline_color.rgb, edge_factor * outline_color.a);
    COLOR = vec4(final_color, screen_color.a);
}