shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

// Controls (All hints that work 100% in Godot 4.x)
uniform float contrast : hint_range(0.0, 5.0) = 2.8;
uniform float hatch_scale : hint_range(100.0, 1000.0) = 450.0;
uniform float hatch_softness : hint_range(0.0, 0.2) = 0.04;
uniform float scene_hardness : hint_range(0.1, 1.0) = 0.4; 
uniform vec3 accent_color : source_color = vec3(0.7, 0.0, 0.0);
uniform float red_threshold : hint_range(0.0, 1.0) = 0.18;

// NEW CONTROLS YOU REQUESTED:
uniform float outline_thickness : hint_range(0.5, 5.0) = 1.5;
uniform float outline_threshold : hint_range(0.05, 0.5) = 0.1;
uniform float deep_shadow_threshold : hint_range(0.0, 0.3) = 0.15;
uniform vec3 paper_color : source_color = vec3(0.4);

float luma(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

float get_hatch(vec2 uv, float angle, float scale, float thickness) {
    float s = sin(angle);
    float c = cos(angle);
    vec2 p = vec2(c * uv.x - s * uv.y, s * uv.x + c * uv.y) * scale;
    float line = abs(fract(p.x) - 0.5);
    return 1.0 - smoothstep(thickness - hatch_softness, thickness + hatch_softness, line);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    vec3 col = texture(screen_texture, uv).rgb;
    
    // 1. Red Pass Logic
    float red_diff = col.r - max(col.g, col.b);
    bool is_red = red_diff > red_threshold;

    // 2. Aggressive Dark Tone Mapping
    float gray = luma(col);
    gray = clamp(gray, 0.0, scene_hardness); 
    gray = pow(gray, 1.4);
    gray = (gray - 0.5) * contrast + 0.5;
    gray = clamp(gray, 0.0, 1.0);

    // 3. Multi-Layer Hatching
    float h1 = get_hatch(uv, 0.78, hatch_scale, 0.12);
    float d1 = smoothstep(1.0, 0.7, gray); 
    
    float h2 = get_hatch(uv, -0.78, hatch_scale * 0.8, 0.2);
    float d2 = smoothstep(0.7, 0.4, gray);
    
    float h3 = get_hatch(uv, 1.57, hatch_scale * 1.1, 0.35);
    float d3 = smoothstep(0.4, 0.0, gray);

    float ink = (h1 * d1) + (h2 * d2) + (h3 * d3);
    
    // NEW: Configurable deep shadow cutoff
    if (gray < deep_shadow_threshold) ink = 1.0;
    ink = clamp(ink, 0.0, 1.0);

    // 4. Output with Custom Paper Color
    vec3 ink_black = vec3(0.0);
    vec3 final_bw = mix(paper_color, ink_black, ink);

    // Apply Red Accent
    vec3 final_output = is_red ? accent_color * 1.5 : final_bw;

    // 5. Improved Edge Detection (Configurable)
    vec2 px = outline_thickness / vec2(textureSize(screen_texture, 0));
    float e = luma(texture(screen_texture, uv + px).rgb) - luma(texture(screen_texture, uv - px).rgb);
    if (abs(e) > outline_threshold && !is_red) final_output = vec3(0.0);

    COLOR = vec4(final_output, 1.0);
}