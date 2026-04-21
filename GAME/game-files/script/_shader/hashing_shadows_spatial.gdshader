// ============================================================
//  HASHING SHADOWS — Spatial (Per-Object)
//  Apply on any MeshInstance3D you want to accent
//  Handles: red accent isolation, per-object hatch boost,
//           rim outline, object-level contrast
//  The CanvasItem shader above then processes the final frame.
// ============================================================
shader_type spatial;
render_mode unshaded, cull_back;

// === ALBEDO ===
uniform sampler2D albedo_tex    : source_color, hint_default_white;
uniform vec4  albedo_tint       : source_color = vec4(1.0);

// === RED ACCENT ===
uniform vec4  accent_color      : source_color = vec4(0.85, 0.05, 0.05, 1.0);
uniform float accent_threshold  : hint_range(0.0, 1.0)  = 0.35;
uniform float accent_boost      : hint_range(1.0, 8.0)  = 4.0;
uniform float accent_isolation  : hint_range(0.0, 1.0)  = 0.80;

// === OBJECT HATCH ===
// Per-object hatch runs on top of — and independent from — the screen pass.
// Useful for self-shadowed details on the mesh surface.
uniform float obj_hatch_enable  : hint_range(0.0, 1.0)  = 1.0; // 0 = off
uniform float obj_crush         : hint_range(0.0, 1.0)  = 0.55;
uniform float obj_contrast      : hint_range(0.5, 5.0)  = 2.5;
uniform float obj_highlight     : hint_range(0.0, 1.0)  = 0.75;
uniform float obj_hatch_scale   : hint_range(1.0, 300.0)= 80.0;
uniform float obj_light_dir     : hint_range(0.0, 360.0)= 135.0;
uniform float obj_hatch_bias    : hint_range(-1.0, 1.0) = 0.20;

// === RIM OUTLINE ===
uniform float rim_width         : hint_range(0.0, 1.0)  = 0.35;
uniform float rim_sharpness     : hint_range(1.0, 32.0) = 10.0;

// ─── Helpers ─────────────────────────────────────────────────

float luminance(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

float hash21(vec2 p) {
    p = fract(p * vec2(127.1, 311.7));
    p += dot(p, p + 43.13);
    return fract(p.x * p.y);
}

// Object-space hatch using world XZ + Y blend (triplanar-lite)
float obj_hatch(vec3 world_pos, vec3 world_normal, float lum) {
    float ang = radians(obj_light_dir + obj_hatch_bias * 45.0);
    float s = sin(ang), c2 = cos(ang);

    // Blend XZ and XY planes based on normal
    vec2 uvXZ = world_pos.xz * obj_hatch_scale * 0.01;
    vec2 uvXY = world_pos.xy * obj_hatch_scale * 0.01;
    float blend = abs(world_normal.y); // 1 on floors, 0 on walls

    vec2 uv = mix(uvXY, uvXZ, blend);

    vec2 ruv = vec2(c2 * uv.x - s * uv.y,
                    s * uv.x + c2 * uv.y);

    float ink = 0.0;
    if (lum < obj_crush)
        ink = max(ink, step(fract(ruv.y), 0.45));

    vec2 ruv2 = vec2(c2 * uv.y + s * uv.x,
                    -s * uv.y + c2 * uv.x) * 0.95;
    if (lum < obj_crush * 0.65)
        ink = max(ink, step(fract(ruv2.y), 0.45));

    if (lum < obj_crush * 0.35)
        ink = max(ink, step(fract((ruv.y + ruv.x) * 1.3), 0.35));

    if (lum < obj_crush * 0.12) ink = 1.0;

    return ink;
}

void fragment() {
    vec3 orig = texture(albedo_tex, UV).rgb * albedo_tint.rgb;

    // ── Light direction in view space ────────────────────────
    vec3 light_ws = normalize(vec3(
        cos(radians(obj_light_dir)), 0.6, sin(radians(obj_light_dir))
    ));
    vec3 light_vs = normalize((VIEW_MATRIX * vec4(light_ws, 0.0)).xyz);
    float ndotl   = clamp(dot(normalize(NORMAL), light_vs), 0.0, 1.0);

    // ── Luminance with shading ────────────────────────────────
    float base_lum = luminance(orig) * (ndotl * 0.8 + 0.2);
    float lum      = clamp((base_lum - 0.5) * obj_contrast + 0.5, 0.0, 1.0);

    // ── Object hatch (optional) ───────────────────────────────
    vec3 world_pos    = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    vec3 world_normal = normalize((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);

    float ink   = obj_hatch(world_pos, world_normal, lum) * obj_hatch_enable;
    float paper = (lum >= obj_highlight) ? 1.0 : (1.0 - ink);
    vec3  bw    = vec3(paper);

    // ── Accent colour isolation ───────────────────────────────
    // How close is this pixel's hue to the accent colour?
    float orig_lum  = luminance(orig);
    float acc_lum   = luminance(accent_color.rgb);
    vec3  norm_orig = (orig_lum  > 0.001) ? orig / orig_lum               : vec3(0.0);
    vec3  norm_acc  = (acc_lum   > 0.001) ? accent_color.rgb / acc_lum    : vec3(0.0);
    float hue_dist  = length(norm_orig - norm_acc);
    float is_accent = smoothstep(accent_isolation * 2.0, 0.0, hue_dist);

    // Also require saturation (don't tint grey pixels red)
    float sat = length(orig - vec3(orig_lum));
    is_accent *= smoothstep(0.05, 0.25, sat);

    // Boosted accent output — pure vivid red bleeding through B&W
    vec3 acc_out = accent_color.rgb * accent_boost;
    acc_out      = clamp(acc_out, 0.0, 1.0);

    // ── Combine B&W + Accent ──────────────────────────────────
    vec3 final_col = mix(bw, acc_out, is_accent);

    // ── Rim outline ───────────────────────────────────────────
    vec3  view_dir = normalize(-VERTEX);
    float rim = 1.0 - clamp(dot(normalize(NORMAL), view_dir), 0.0, 1.0);
    rim = pow(rim, rim_sharpness);
    rim = step(1.0 - rim_width, rim);
    // Don't draw rim over accent pixels — keep red clean
    final_col = mix(final_col, vec3(0.0), rim * (1.0 - is_accent));

    ALBEDO = final_col;
}
