# Shader Documentation

This document describes the custom shaders used in the Little Nightmares Prototype project. All shaders are implemented as CanvasItem shaders (screen‑space post‑processing) and are managed by the `shaders.tscn` scene and the `PostProcessingController.gd` script.

## Overview

The project uses three main shaders:

1. **ChaosFXEnhanced** – Combines color grading with dynamic chaos effects (distortion, shake, vignette, color shift).
2. **CombinedOutline** – Performs edge detection and renders black outlines around objects.
3. **ToonShadingEnhanced** – Applies color adjustment, posterization, and edge darkening for a stylized cartoon look.

Each shader is attached to a `ColorRect` inside a `CanvasLayer` (`shaders.tscn`). The `PostProcessingController` script enables/disables and tweaks shader parameters at runtime.

## Shader Details

### ChaosFXEnhanced

**File:** `res://shader/ChaosFXEnhanced.gdshader`

**Purpose:**  
Adds cinematic color grading and chaotic screen effects that intensify with a `chaos_level` parameter. Suitable for stress moments, boss fights, or environmental hazards.

**Uniforms (Shader Parameters):**

| Uniform | Type | Range (hint) | Default | Description |
|---------|------|--------------|---------|-------------|
| `warmth` | `float` | 0.0 – 2.0 | 1.2 | Strength of warm (yellow‑orange) tint in highlights. |
| `cool_shadows` | `float` | 0.0 – 1.0 | 0.3 | Strength of cool (blue‑cyan) tint in shadows. |
| `contrast` | `float` | 0.5 – 2.0 | 1.4 | Overall contrast adjustment. |
| `saturation` | `float` | 0.0 – 2.0 | 1.1 | Base saturation multiplier. |
| `vibrance` | `float` | 0.0 – 2.0 | 1.3 | Extra saturation boost for less‑saturated colors. |
| `chaos_level` | `float` | 0.0 – 1.0 | 0.0 | Master intensity of chaos effects (distortion, shake, etc.). |
| `vignette_strength` | `float` | 0.0 – 1.0 | 0.3 | Darkness strength at screen edges. |
| `distortion_strength` | `float` | 0.0 – 0.1 | 0.02 | Radial distortion (barrel/pincushion) amount. |
| `shake_intensity` | `float` | 0.0 – 0.05 | 0.01 | Screen shake magnitude. |
| `chaos_color_shift` | `float` | 0.0 – 0.1 | 0.03 | Red/blue channel separation at high chaos. |

**Implementation Highlights:**

- **Color grading:** Applies contrast, saturation, vibrance, and split‑toning (warm highlights, cool shadows).
- **Screen shake:** Uses a 2D noise function driven by `TIME` to offset UV coordinates.
- **Radial distortion:** Distorts UVs based on distance from screen center.
- **Dynamic vignette:** Darkens edges, intensity scales with `chaos_level`.
- **Color shift:** At `chaos_level > 0.5`, red and blue channels are slightly displaced.
- **Brightness boost:** Slight brightness increase at high chaos.

**Usage Example:**  
```gdscript
# In PostProcessingController.gd
$Shaders/ChaosFX.material.set_shader_parameter("chaos_level", 0.8)
```

---

### CombinedOutline

**File:** `res://shader/CombinedOutline.gdshader`

**Purpose:**
Detects edges in the screen image and draws a configurable black outline around objects. Useful for emphasizing silhouettes or creating a comic‑book style.

**Uniforms (Shader Parameters):**

| Uniform             | Type    | Range (hint) | Default          | Description                                           |
| ------------------- | ------- | ------------ | ---------------- | ----------------------------------------------------- |
| `outline_thickness` | `float` | 1.0 – 50.0   | 1.5              | Thickness of the outline in pixels.                   |
| `edge_threshold`    | `float` | 0.0 – 0.5    | 0.2              | Sensitivity of edge detection (higher = fewer edges). |
| `outline_color`     | `vec4`  | –            | `Color(0,0,0,1)` | Color of the outline (RGBA).                          |
| `outline_intensity` | `float` | 0.0 – 1.0    | 1.0              | Blend strength between scene color and outline color. |

**Implementation Highlights:**

- **Fast edge detection:** Uses 4‑direction color difference (4 texture samples) instead of heavy Sobel (9 samples) and dilation loops.
- **Pixel‑based thickness:** Outline thickness scales with `SCREEN_PIXEL_SIZE`; no need for expensive dilation loops.
- **Smooth threshold:** Applies `smoothstep` for soft edges.
- **Performance‑oriented:** Designed to run efficiently even on low‑end GPUs.

**Known Issues & Fixes:**

- **Black screen bug:** Originally the shader computed `pixel_size` as `1.0 / SCREEN_PIXEL_SIZE`, which caused sampling offsets to be thousands of pixels wide, resulting in a fully black output. Fixed by using `pixel_size = SCREEN_PIXEL_SIZE` (the correct UV‑per‑pixel size).
- **Heavy Sobel removed:** The previous version used a 3×3 Sobel operator followed by a dilation loop, which caused severe performance drops. Replaced with a lightweight color‑difference approach.

**Performance Recommendations:**

- Keep `outline_thickness` between 1.0 and 2.0 for best visual quality and performance.
- Disable the outline shader when not needed (set `visible = false` on the `CombinedOutline` ColorRect).
- Consider using depth‑based edges for more accurate silhouettes (requires depth texture).

**Usage Example:**
```gdscript
$Shaders/CombinedOutline.material.set_shader_parameter("outline_thickness", 1.5)
$Shaders/CombinedOutline.material.set_shader_parameter("edge_threshold", 0.15)
```

---

### ToonShadingEnhanced

**File:** `res://shader/ToonShadingEnhanced.gdshader`

**Purpose:**  
Combines basic color correction (contrast, saturation, brightness) with posterization (banding) and edge darkening to achieve a stylized toon/cel‑shaded look.

**Uniforms (Shader Parameters):**

| Uniform | Type | Range (hint) | Default | Description |
|---------|------|--------------|---------|-------------|
| `contrast` | `float` | 0.5 – 2.0 | 1.2 | Contrast multiplier. |
| `saturation` | `float` | 0.0 – 3.0 | 1.3 | Saturation multiplier. |
| `brightness` | `float` | 0.5 – 1.5 | 1.0 | Brightness multiplier. |
| `bands` | `int` | 2 – 8 | 4 | Number of luminance steps (posterization). |
| `edge_threshold` | `float` | 0.0 – 0.5 | 0.1 | Luminance difference threshold for edge darkening. |
| `brightness_floor` | `float` | 0.0 – 1.0 | 0.3 | Minimum luminance after posterization. |

**Implementation Highlights:**

- **Color adjustment:** Applies brightness, contrast, and saturation in that order.
- **Posterization:** Quantizes luminance into `bands` discrete levels.
- **Edge darkening:** Compares luminance with four direct neighbors; if the average difference exceeds `edge_threshold`, the posterized luminance is darkened by 30%.
- **Minimum brightness:** Ensures no pixel becomes darker than `brightness_floor`.

**Known Issues & Fixes:**

- **Pixel size bug:** Same as CombinedOutline – used `1.0 / SCREEN_PIXEL_SIZE` incorrectly. Fixed to `SCREEN_PIXEL_SIZE`.

**Usage Example:**  
```gdscript
$Shaders/ToonShadingEnhanced.material.set_shader_parameter("bands", 6)
$Shaders/ToonShadingEnhanced.material.set_shader_parameter("edge_threshold", 0.15)
```

---

## Scene Integration

### shaders.tscn

A `CanvasLayer` containing three `ColorRect` nodes, each with a `ShaderMaterial` referencing one of the above shaders.

- **ChaosFX** – Always visible, parameters driven by game events.
- **CombinedOutline** – Initially `visible = false`; can be enabled for outline effects.
- **ToonShadingEnhanced** – Always visible, provides the core artistic style.

All `ColorRect`s are anchored to fill the entire screen, with `grow` flags set to accommodate window resizing.

### PostProcessingController.gd

Script attached to the `CanvasLayer` that provides an interface to:

- Toggle shaders on/off.
- Adjust shader parameters in real‑time (e.g., increase `chaos_level` during combat).
- Blend between different shader configurations.

Example function:
```gdscript
func enable_outline(thickness: float = 2.5):
    $CombinedOutline.visible = true
    $CombinedOutline.material.set_shader_parameter("outline_thickness", thickness)
```

---

## Performance Considerations

- All shaders are screen‑space and run at the viewport’s resolution.
- **CombinedOutline** now uses a lightweight 4‑sample color‑difference method (replacing the expensive Sobel + dilation). Performance is greatly improved; keep `outline_thickness` between 1.0 and 2.0 for optimal balance.
- **ChaosFX**’s noise and distortion are cheap on modern GPUs but should be disabled when `chaos_level` is zero to save cycles (consider setting `visible = false` on the ChaosFX ColorRect).
- **ToonShadingEnhanced** is relatively cheap but can be optimized by reducing `bands` and disabling edge darkening when not needed.
- For further gains, consider rendering post‑processing at half resolution (using a SubViewport) and upscaling.

---

## Future Improvements

- Add a **noise/grain** shader for filmic texture.
- Implement **depth‑based outlines** for more accurate edge detection.
- Allow **dynamic parameter animation** via curves or tweening.
- Create a **shader‑parameter preset system** for different game moods (e.g., “calm”, “tense”, “chaotic”).

---

## Changelog

- **2026‑04‑16** – Fixed `pixel_size` calculation in `CombinedOutline` and `ToonShadingEnhanced` shaders (was `1.0 / SCREEN_PIXEL_SIZE`, now `SCREEN_PIXEL_SIZE`). This resolved the black‑screen issue when the CombinedOutline shader was enabled.
- **2026‑04‑16** – Added world environment with procedural sky to `game.tscn` (dark gradient sky matching project’s aesthetic).