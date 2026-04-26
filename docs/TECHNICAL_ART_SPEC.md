# TECHNICAL & ART SPECIFICATION: YOU MUST EAT

## 1. Document Information
- **Version:** 3.0
- **Last Updated:** 2026-04-26
- **Scope:** Visual identity, audio direction, shader implementation, and technical roadmap.

---

## 2. Visual Direction: "Hashing Shadows"

### 2.1 Core Aesthetic
The world is rendered as a raw, brutal sketch. It eschews realism for an oppressive, high-contrast atmosphere that reflects the protagonist's mental state and the systemic horror of the setting.

**The Color Palette:**
- **Deep Black:** Represents shadows, danger, the unknown, and the "Merging" state.
- **Stark White:** Represents harsh lights, exposure, and innocence.
- **Blood Red:** Used sparingly for critical warnings, enemy indicators, and trauma.
- **Greys:** Minimal tones used only for basic environmental depth.

### 2.2 Visual Philosophy
- **Abstraction over Realism:** Use of high-contrast shading and bold outlines to create a mood of systemic oppression.
- **Lighting as Gameplay:** Light is a hazard (exposure); shadows are a sanctuary (the Merge mechanic).
- **Silhouette Priority:** Characters and props must have strong, readable silhouettes to be identifiable against high-contrast backgrounds.

---

## 3. Technical Shader Implementation

### 3.1 Post-Process Toon Pipeline
The game utilizes a screen-space shader applied as a full-screen `CanvasLayer` effect. This ensures a consistent art style regardless of scene complexity.

#### `toon_outline_postprocess.gdshader`
The primary shader responsible for the "Hashing Shadows" look.

**Fragment Shader Flow:**
1. **Sample Screen Color:** Captures the rendered 3D scene.
2. **Edge Detection:** Samples neighboring pixels to find high-contrast edges and creates an outline mask.
3. **Color Correction:** Applies brightness, contrast, and saturation.
4. **Toon Banding:** Posterizes the luminance into discrete steps (default 4-6 bands) to create a flat, cell-shaded look.
5. **Edge Darkening:** Subtly darkens the detected edges to add depth.
6. **Outline Mixing:** Blends the final toon color with the `outline_color` (typically Black).

#### Other Specialized Shaders:
- **`comic_ink_single_pass.gdshader`:** Applied to specific materials for an ink-like effect on environmental elements.
- **`ouliner.gdshader`:** Per-object outlines to ensure characters remain distinct from the background.
- **`red.gdshader`:** Pulsing red effects used for damage indicators and combat feedback.

---

## 4. Audio Direction

### 4.1 Soundscape Design
The audio is designed to heighten the tension of the "Silent City."

- **The City Hum:** A constant, low-frequency background noise of Mumbai that creates a sense of urban claustrophobia.
- **Dynamic Contrast:** Sharp shifts between the loud, chaotic noise of the markets and the ringing, oppressive silence of a safe house.
- **Combat Audio:** Heavy, impactful gunshots and the sounds of metal on tin, emphasizing the brutality of the environment.

### 4.2 Voice & Music
- **Voice Style:** A naturalistic mix of Hindi and English. Focus on the weight of words and the importance of silence.
- **Score:** A minimalist, tension-driven soundtrack. Uses distorted Indian classical instruments (e.g., Sarangi) to evoke a feeling of unease and longing.

---

## 5. Technical Plan & Requirements

### 5.1 Core Specifications
- **Engine:** Godot 4.x
- **Target Frame Rate:** 60 FPS on mid-range hardware.
- **Build Size Target:** < 500 MB.
- **Platform:** Windows (Primary), Linux.

### 5.2 System Requirements (Target)
| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **CPU** | Intel i5-4460 / AMD FX-6300 | Intel i7-8700 / AMD Ryzen 5 3600 |
| **RAM** | 8 GB | 16 GB |
| **GPU** | NVIDIA GTX 960 / AMD R9 280 | NVIDIA GTX 1060 / AMD RX 580 |
| **OS** | Windows 10/11 | Windows 10/11 |

### 5.3 Development Roadmap
1. **Phase 1: Core Foundation (Complete):** FPS controller, toon shader pipeline.
2. **Phase 2: Core Mechanics (Complete):** Movement, attack/interaction, basic weapon system.
3. **Phase 3: Stage 1 Implementation (Current):** Slum environments, basic enemy AI, dialogue system.
4. **Phase 4: Weapons & Combat:** Implementation of all weapon types and advanced AI.
5. **Phase 5: Stages 2-4 Implementation:** Environment building and mini-bosses.
6. **Phase 6: Stage 5 & Final Boss:** The "Feast" complex and final confrontation.
7. **Phase 7: Polish & Optimization:** Performance tuning and size reduction.

---

## 6. Optimization Strategies

### 6.1 Rendering Optimization
- **LOD (Level of Detail):** Automatic switching of models based on distance.
- **Culling:** Frustum and occlusion culling to reduce draw calls.
- **Batching:** Static batching for environment objects; instanced rendering for repeated slum assets (e.g., tin sheets).

### 6.2 Memory & Size Optimization
- **Asset Compression:** 
  - Textures: ASTC/BC7 compression.
  - Audio: OGG Vorbis.
  - Models: GLTF with Draco compression.
- **Asset Reuse:** Heavy reuse of modular environment pieces and texture atlases to keep the footprint under 500 MB.

### 6.3 Performance Profiling
- Continuous monitoring of frame times and memory usage.
- Optimization of "hot" code paths in the `fps_player_controller` and `WeaponManager`.

---

## 7. Asset Pipeline
- **3D Modeling:** Blender $\rightarrow$ GLTF/FBX $\rightarrow$ Godot.
- **2D Art:** Krita/GIMP for high-contrast, flat-colored textures.
- **Audio:** Audacity for editing $\rightarrow$ OGG for export.
- **Version Control:** Git.
