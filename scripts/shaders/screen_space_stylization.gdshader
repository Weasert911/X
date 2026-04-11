shader_type canvas_item;
render_mode unshaded, blend_disabled;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float pixel_size : hint_range(1.0, 16.0, 0.5) = 4.0;

uniform float color_levels : hint_range(2.0, 32.0, 1.0) = 8.0;

uniform float dither_strength : hint_range(0.0, 1.0, 0.05) = 0.15;

uniform bool enable_dither = true;

float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

float bayer_dither(vec2 uv, float size) {
    int x = int(mod(uv.x * size, 4.0));
    int y = int(mod(uv.y * size, 4.0));
    
    float bayer_values[16] = float[](
        0.0/16.0, 8.0/16.0, 2.0/16.0, 10.0/16.0,
        12.0/16.0, 4.0/16.0, 14.0/16.0, 6.0/16.0,
        3.0/16.0, 11.0/16.0, 1.0/16.0, 9.0/16.0,
        15.0/16.0, 7.0/16.0, 13.0/16.0, 5.0/16.0
    );
    
    return bayer_values[y * 4 + x];
}

vec2 pixelate_uv(vec2 uv, float pixel_scale) {
    vec2 screen_size = vec2(textureSize(SCREEN_TEXTURE, 0));
    
    vec2 pixel_count = screen_size / pixel_scale;
    
    vec2 quantized_uv = floor(uv * pixel_count) / pixel_count;
    
    vec2 half_pixel = 0.5 / pixel_count;
    
    return quantized_uv + half_pixel;
}

vec3 quantize_color(vec3 color, float levels, float dither, vec2 uv) {
    float step = 1.0 / levels;
    
    float dither_offset = 0.0;
    if (enable_dither) {
        dither_offset = (bayer_dither(uv, 1.0) - 0.5) * dither * step;
    }
    
    vec3 quantized;
    quantized.r = floor((color.r + dither_offset) * levels) / levels;
    quantized.g = floor((color.g + dither_offset) * levels) / levels;
    quantized.b = floor((color.b + dither_offset) * levels) / levels;
    
    return clamp(quantized, 0.0, 1.0);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    
    vec2 pixelated_uv = pixelate_uv(uv, pixel_size);
    
    vec4 screen_color = texture(SCREEN_TEXTURE, pixelated_uv);
    
    vec3 stylized_color = quantize_color(
        screen_color.rgb,
        color_levels,
        dither_strength,
        pixelated_uv
    );
    
    COLOR = vec4(stylized_color, screen_color.a);
}
