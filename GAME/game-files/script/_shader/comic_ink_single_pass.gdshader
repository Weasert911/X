// ============================================================
//  HASHING SHADOWS — CanvasItem (Full-Screen Post-Process)
//  Apply on a ColorRect (CanvasLayer, Full Rect)
//  This handles: hatching, B&W posterization, grunge, vignette
// ============================================================
shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture, filter_linear_mipmap;

// === STYLE ===
uniform float crush              : hint_range(0.0, 1.0)   = 0.55;
uniform float contrast           : hint_range(0.5, 5.0)   = 2.20;
uniform float highlight          : hint_range(0.0, 1.0)   = 0.75;

// === HATCHING ===
uniform float light_direction    : hint_range(0.0, 360.0) = 135.0;
uniform float hatch_density      : hint_range(0.1, 4.0)   = 0.85;
uniform float hatch_angle_bias   : hint_range(-1.0, 1.0)  = 0.20;

// === OUTLINE ===
uniform float outline_thickness  : hint_range(0.0, 5.0)   = 1.5;
uniform float edge_threshold     : hint_range(0.0, 1.0)   = 0.08;

// === EXTRAS ===
uniform float grunge_amount      : hint_range(0.0, 1.0)   = 0.15;
uniform float vignette_strength  : hint_range(0.0, 2.0)   = 0.40;

// ─── Helpers ─────────────────────────────────────────────────

float luminance(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

float hash21(vec2 p) {
    p = fract(p * vec2(127.1, 311.7));
    p += dot(p, p + 43.13);
    return fract(p.x * p.y);
}

float vnoise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    return mix(
        mix(hash21(i), hash21(i + vec2(1,0)), f.x),
        mix(hash21(i + vec2(0,1)), hash21(i + vec2(1,1)), f.x),
        f.y
    );
}

float edge_detect(vec2 uv, vec2 px) {
    vec3 c  = texture(screen_tex, uv).rgb;
    vec3 cx = texture(screen_tex, uv + vec2(px.x, 0.0)).rgb;
    vec3 cy = texture(screen_tex, uv + vec2(0.0, px.y)).rgb;
    vec3 cxy= texture(screen_tex, uv + vec2(px.x, px.y)).rgb;
    vec3 cnx= texture(screen_tex, uv + vec2(-px.x, px.y)).rgb;
    float dx = length(c - cx);
    float dy = length(c - cy);
    float dd = length(c - cxy);
    float dn = length(c - cnx);
    return step(edge_threshold, dx + dy + dd * 0.5 + dn * 0.5);
}

// 4-layer directional hatch — screen UV based
float hatch(vec2 uv, float lum) {
    float ang = radians(light_direction + hatch_angle_bias * 45.0);
    float s = sin(ang), c2 = cos(ang);

    // Scale UV to pixel-density hatch space
    vec2 huv = uv * vec2(textureSize(screen_tex, 0));
    vec2 ruv = vec2(c2 * huv.x - s * huv.y,
                    s * huv.x + c2 * huv.y) / (200.0 / hatch_density);

    float ink = 0.0;

    // Layer 1 — light shadow
    if (lum < crush)
        ink = max(ink, step(fract(ruv.y), 0.45));

    // Layer 2 — cross hatch
    vec2 ruv2 = vec2(c2 * huv.y + s * huv.x,
                    -s * huv.y + c2 * huv.x) / (200.0 / (hatch_density * 0.95));
    if (lum < crush * 0.65)
        ink = max(ink, step(fract(ruv2.y), 0.45));

    // Layer 3 — deep diagonal
    if (lum < crush * 0.35)
        ink = max(ink, step(fract((ruv.y + ruv.x) * 1.3), 0.35));

    // Layer 4 — pure black fill
    if (lum < crush * 0.12) ink = 1.0;

    return ink;
}

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 px = SCREEN_PIXEL_SIZE * outline_thickness;

    vec3 orig = texture(screen_tex, uv).rgb;

    // Contrast
    vec3 col = clamp((orig - 0.5) * contrast + 0.5, 0.0, 1.0);
    float lum = luminance(col);

    // Hatch → B&W
    float ink   = hatch(uv, lum);
    float paper = (lum >= highlight) ? 1.0 : (1.0 - ink);

    // Grunge overlay
    float grain = vnoise(uv * 800.0) * 2.0 - 1.0;
    paper = step(0.45, clamp(paper + grain * grunge_amount * 0.3, 0.0, 1.0));

    vec3 final_col = vec3(paper);

    // Preserve red-tagged pixels (spatial shader writes them before this pass)
    // We detect them by checking if original is strongly red-dominant
    float red_mask = step(0.30, orig.r - max(orig.g, orig.b));
    float red_sat  = smoothstep(0.1, 0.3, length(orig - vec3(luminance(orig))));
    red_mask *= red_sat;
    // Pass red through unchanged — don't B&W crush it
    final_col = mix(final_col, orig, red_mask);

    // Edge outline
    float edge = edge_detect(uv, px);
    final_col  = mix(final_col, vec3(0.0), edge * (1.0 - red_mask));

    // Vignette
    vec2  vc  = uv - 0.5;
    float vig = clamp(1.0 - dot(vc, vc) * vignette_strength * 4.0, 0.0, 1.0);
    final_col *= vig;

    COLOR = vec4(final_col, 1.0);
}
