# Shader Documentation

This document describes the custom shaders used in **Gali Chaos** to achieve the 3D stylized toon art with bold outlines.

## Overview

The game uses a post‑process screen‑space shader applied as a full‑screen `CanvasLayer` effect. The shader provides:

- **Toon banding** (posterization) for flat color shading
- **Edge detection** for bold outlines
- **Color controls** (brightness, contrast, saturation)
- **Subtle edge darkening** for depth

The shader is implemented in Godot’s shading language (`gdshader`) and is attached to a `ColorRect` that covers the entire viewport.

## Shader Files

| File                           | Purpose                                         | Status          |
| ------------------------------ | ----------------------------------------------- | --------------- |
| `shader/toon_outline.gdshader` | Main post‑process toon + outline shader         | ✅ Implemented   |


## `toon_outline.gdshader` – Reference

### Shader Type
`canvas_item` – runs in screen space after the 3D scene is rendered.

### Uniform Parameters

#### Color Control
| Uniform | Type | Hint / Range | Default | Description |
|---------|------|--------------|---------|-------------|
| `brightness` | `float` | `0.8 … 1.2` | `1.0` | Multiplies the RGB values. |
| `contrast`   | `float` | `0.8 … 1.5` | `1.1` | Adjusts contrast around 0.5. |
| `saturation` | `float` | `0.8 … 1.5` | `1.2` | Interpolates between luminance and original color. |

#### Toon Banding
| Uniform | Type | Hint / Range | Default | Description |
|---------|------|--------------|---------|-------------|
| `bands` | `int` | `2 … 6` | `4` | Number of discrete luminance steps (posterization). |

#### Outline
| Uniform | Type | Hint / Range | Default | Description |
|---------|------|--------------|---------|-------------|
| `outline_thickness` | `float` | `0.5 … 2.5` | `1.2` | Multiplier for the screen‑pixel offset used in edge detection. |
| `color_threshold`   | `float` | `0.05 … 0.3` | `0.15` | Sensitivity of edge detection; lower = more edges. |
| `outline_color`     | `vec4`  | `source_color` | `(0,0,0,1)` | Color of the outlines (RGBA). |
| `outline_intensity` | `float` | `0.0 … 1.5` | `1.0` | Strength of outline color mixing. |

#### Edge Darkening
| Uniform | Type | Hint / Range | Default | Description |
|---------|------|--------------|---------|-------------|
| `edge_darkening` | `float` | `0.0 … 0.4` | `0.15` | Subtly darkens detected edges (multiplies RGB). |

### Internal Functions

- `luminance(vec3 c)` – standard RGB luminance using `(0.299, 0.587, 0.114)`.
- `apply_color_controls(vec3 col)` – applies brightness, contrast, saturation in order.
- `apply_toon(vec3 col)` – posterizes the luminance and reconstructs color.
- `edge_detect(vec3 center, vec2 uv, vec2 px)` – samples four neighbouring pixels and returns an edge mask.

### Fragment Shader Flow

1. **Sample original screen color** (`SCREEN_TEXTURE` at `SCREEN_UV`).
2. **Edge detection** using the original color and `outline_thickness`.
3. **Color correction** (brightness, contrast, saturation).
4. **Toon banding** on the corrected color.
5. **Edge darkening** – multiply color by `(1.0 - edge * edge_darkening)`.
6. **Outline mixing** – blend between toon color and `outline_color` using `edge * outline_intensity`.
7. **Output** final RGB with alpha = 1.0.

## Usage in the Project

### Scene Setup
The shader is applied via a `CanvasLayer` node named `shaderPass` (see `scene/shader.tscn`). Inside it, a `ColorRect` named `Toon_outline` covers the whole screen and uses a `ShaderMaterial` that references `toon_outline.gdshader`.

### Default Parameters (in `shader.tscn`)
The material currently uses the following **maximum‑effect** values (for testing):

| Parameter | Value |
|-----------|-------|
| `brightness` | 1.2 |
| `contrast`   | 1.5 |
| `saturation` | 1.5 |
| `bands`      | 6 |
| `outline_thickness` | 2.5 |
| `color_threshold`   | 0.05 |
| `outline_color`     | Black (0,0,0,1) |
| `outline_intensity` | 1.5 |
| `edge_darkening`    | 0.4 |

These values can be adjusted in the Godot Inspector or via GDScript at runtime.

### Integration with 3D Assets
The shader works as a **post‑process** effect, meaning all 3D models should use simple, flat‑colored materials without their own complex shading. The outline detection relies on color differences between adjacent screen pixels, so high‑contrast edges in the scene will produce thicker outlines.

## Performance Considerations

- The shader samples the screen texture five times per pixel (center + four neighbours).
- All calculations are performed in screen space, independent of scene complexity.
- Should run efficiently on modern GPUs; however, keep `outline_thickness` moderate (≤ 2.5) to avoid sampling distant pixels.
- The `bands` integer loop is unrolled at compile time (max 6), so no dynamic branching cost.

## Art Direction Guidelines

### Recommended Values for Final Art
| Parameter | Recommended Value | Notes |
|-----------|-------------------|-------|
| `brightness` | 1.0 – 1.1 | Slightly bright to keep colors vibrant. |
| `contrast`   | 1.0 – 1.2 | Enough pop without crushing shadows. |
| `saturation` | 1.1 – 1.3 | Slightly oversaturated for a cartoon look. |
| `bands`      | 3 – 4 | Too many bands look realistic; too few look posterized. |
| `outline_thickness` | 1.0 – 1.5 | Thicker outlines reduce readability in dense scenes. |
| `color_threshold`   | 0.1 – 0.2 | Balance between missing edges and noise. |
| `outline_color`     | Black (0,0,0,1) | Classic cartoon outline. |
| `outline_intensity` | 1.0 | Full strength outlines. |
| `edge_darkening`    | 0.1 – 0.2 | Subtle darkening adds depth without being obvious. |

### Testing the Shader
Open `scene/shader.tscn` in the Godot editor and modify the `ShaderMaterial` parameters in the Inspector. The changes are visible in the editor viewport.
