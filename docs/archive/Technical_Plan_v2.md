# Technical Plan & Implementation

*Part of the Game Design Document*

**Version:** 2.0  
**Last Updated:** 2026-04-19  
**Source:** Single-player FPS narrative game

---

## Table of Contents

1. [Technical Requirements](#technical-requirements)
2. [Development Phases](#development-phases)
3. [Engine & Tools](#engine--tools)
4. [Asset Pipeline](#asset-pipeline)
5. [Shader Implementation](#shader-implementation)
6. [Performance Optimization](#performance-optimization)
7. [Size Optimization](#size-optimization)
8. [Platform Targets](#platform-targets)

---

## Technical Requirements

### Core Specifications

- **Game Type:** Single-player First Person Shooter (FPS)
- **Total Size:** Less than 500 MB
- **Gameplay Duration:** Approximately 1 hour
- **Number of Stages:** 5 distinct stages
- **Target Frame Rate:** 60 FPS on mid-range hardware
- **Resolution:** 1080p minimum, scalable to 4K

### System Requirements (Target)

**Minimum:**
- OS: Windows 10/11
- CPU: Intel i5-4460 / AMD FX-6300
- RAM: 8 GB
- GPU: NVIDIA GTX 960 / AMD R9 280
- Storage: 1 GB available space

**Recommended:**
- OS: Windows 10/11
- CPU: Intel i7-8700 / AMD Ryzen 5 3600
- RAM: 16 GB
- GPU: NVIDIA GTX 1060 / AMD RX 580
- Storage: 1 GB available space

---

## Development Phases

### Phase 1: Core Foundation (Completed)

**Objectives:**
- Set up Godot project with FPS template
- Implement basic player controller (movement, camera)
- Create basic test environment
- Set up toon shader pipeline

**Deliverables:**
- [x] Working FPS controller with run, walk, jump, crouch (`fps_player_controller.gd`)
- [x] First-person camera with controller (`fps_camera_controller.gd`)
- [x] Simple test environment (`game.tscn`)
- [x] Toon outline shader implementation (`toon_outline_postprocess.gdshader`)

### Phase 2: Core Mechanics (Completed)

**Objectives:**
- Implement all movement mechanics (run, walk, jump, hide, crouch)
- Implement attack and interaction systems
- Create basic weapon system
- Implement stealth mechanics

**Deliverables:**
- [x] Complete movement system with stamina (`fps_player_controller.gd`)
- [x] Attack system with hit detection (`Weapon.gd`, `WeaponManager.gd`)
- [x] Interaction system for objects (`pickable.gd`, `interaction_prompt.tscn`)
- [x] Basic weapon system (SMG implemented: `smg.tscn`, `smg_01.tres`)
- [ ] Stealth detection system (in progress)

### Phase 3: Stage 1 Implementation

**Objectives:**
- Build Stage 1 environment (slum streets)
- Implement basic enemy AI
- Create dialogue system
- Implement investigation mechanics

**Deliverables:**
- Complete Stage 1 level
- Basic enemy AI (henchmen)
- Dialogue system with branching conversations
- Investigation system with clues
- Stage 1 playable from start to finish

### Phase 4: Weapons & Combat

**Objectives:**
- Implement all weapon types
- Create combat AI behaviors
- Implement cover system
- Add combat feedback systems

**Deliverables:**
- All weapons (petrol bomb, grenades, rifle, handgun, knife)
- Advanced enemy AI (trusted men)
- Cover system with hiding mechanics
- Combat feedback (damage, recoil, effects)

### Phase 5: Stages 2-4 Implementation

**Objectives:**
- Build Stages 2, 3, and 4 environments
- Implement stage-specific mechanics
- Create mini-boss encounters
- Add environmental storytelling

**Deliverables:**
- Complete Stages 2, 3, and 4 levels
- Stage-specific gameplay elements
- Mini-boss fights (trusted men)
- Environmental clues and storytelling

### Phase 6: Stage 5 & Boss Fight

**Objectives:**
- Build Stage 5 environment (boss arena)
- Implement main boss AI
- Create boss fight mechanics
- Implement death sequence and awakening

**Deliverables:**
- Complete Stage 5 level
- Main boss with advanced AI
- Boss fight mechanics
- Death sequence and awakening cutscene

### Phase 7: Polish & Optimization

**Objectives:**
- Optimize performance to 60 FPS
- Reduce size to under 500 MB
- Polish visuals and audio
- Fix bugs and balance gameplay

**Deliverables:**
- Performance optimized build
- Size under 500 MB
- Polished visuals and audio
- Bug-free, balanced gameplay

---

## Engine & Tools

### Engine: Godot 4.x

**Why Godot:**
- Already in use in the project
- Excellent 3D FPS support
- Built-in toon shader capabilities
- Lightweight and efficient
- Free and open-source
- Good export options for multiple platforms

**Key Godot Features Used:**
- 3D rendering pipeline
- GDScript for game logic
- Shader language for custom effects
- Animation system for characters
- Audio system for sound and music
- UI system for HUD and menus

### Development Tools

**3D Modeling:**
- Blender (free, open-source)
- FBX/GLTF export pipeline

**2D Art:**
- Krita or GIMP for textures
- Inkscape for UI icons

**Audio:**
- Audacity for audio editing
- Free sound libraries (Freesound, etc.)

**Version Control:**
- Git for source control

---

## Asset Pipeline

### 3D Assets

**Creation:**
- Models created in Blender
- Low-poly to mid-poly geometry
- Clean topology for animation
- UV unwrapping for textures

**Export:**
- Export as FBX or GLTF
- Consistent scale (1 unit = 1 meter)
- Proper pivot points
- Include animation data

**Import to Godot:**
- Import with proper settings
- Apply toon materials
- Set up outline parameters
- Configure animation tracks

### Textures

**Creation:**
- Flat colors with minimal detail
- High contrast for readability
- Optimized size (512x512 or 1024x1024 max)
- PNG format with compression

**Optimization:**
- Use texture atlases where possible
- Compress textures for size reduction
- Reuse textures across assets
- Minimal texture variety

### Audio

**Creation:**
- High-quality source audio
- Clear, distinct sounds
- Emotional voice acting
- Atmospheric music

**Optimization:**
- Compress audio files (OGG format)
- Loop background music
- Short, efficient sound effects
- Minimal audio variety

---

## Shader Implementation

### Toon Outline Shader

**Current Implementation:**
- Custom screen-space toon-outline shader (`toon_outline_postprocess.gdshader`)
- Applied as full-screen post-process effect via `shader.tscn`
- Provides color controls, posterization, and edge detection

### Additional Shaders Implemented:
- Comic ink single-pass shader (`comic_ink_single_pass.gdshader`)
- Ouliner shader (`ouliner.gdshader`)
- Red shader (`red.gdshader`)

**Shader Features:**
- Adjustable outline thickness
- Color posterization for toon effect
- Edge detection for outlines
- Performance-optimized implementation

**Usage:**
- Applied via `CanvasLayer` (`scene/shader.tscn`)
- Consistent across all assets
- Configurable parameters for different effects

**Documentation:**
- Detailed shader documentation in [Shaders.md](Shaders.md)

---

## Performance Optimization

### Rendering Optimization

**Level of Detail (LOD):**
- Multiple LOD levels for distant objects
- Automatic LOD switching based on distance
- Reduced polygon count for distant objects

**Culling:**
- Frustum culling for off-screen objects
- Occlusion culling for hidden objects
- Portal culling for indoor areas

**Batching:**
- Static batching for environment objects
- Dynamic batching for similar objects
- Instanced rendering for repeated objects

### Memory Optimization

**Asset Streaming:**
- Load assets per stage
- Unload unused assets
- Efficient memory management

**Texture Optimization:**
- Compressed texture formats
- Texture atlases to reduce draw calls
- Mipmaps for distant objects

**Audio Optimization:**
- Compressed audio formats
- Streaming for long audio files
- Pooling for frequently used sounds

### Code Optimization

**Efficient Algorithms:**
- Optimized collision detection
- Efficient AI pathfinding
- Minimal garbage collection

**Profiling:**
- Regular performance profiling
- Identify and fix bottlenecks
- Optimize hot code paths

---

## Size Optimization

### Target: Less than 500 MB

**Asset Compression:**
- Compressed textures (ASTC, ETC2, or BC7)
- Compressed audio (OGG Vorbis)
- Compressed models (GLTF with Draco compression)

**Asset Reuse:**
- Reuse textures across multiple objects
- Reuse models with variations
- Reuse audio clips where possible

**Minimal Assets:**
- Only essential assets included
- No unused assets in final build
- Optimized asset count

**Code Optimization:**
- Strip unused code
- Minimize script size
- Efficient data structures

**Build Optimization:**
- Exclude debug symbols
- Optimize build settings
- Use efficient compression for final package

### Size Breakdown (Estimated)

- Engine and code: ~50 MB
- Textures: ~150 MB
- Models: ~100 MB
- Audio: ~150 MB
- Other assets: ~50 MB
- **Total: ~500 MB**

---

## Platform Targets

### Primary Platform: PC (Windows)

**Requirements:**
- Windows 10/11
- DirectX 11 or 12
- Keyboard and mouse support
- Controller support (implemented in `input_setup.gd`)

**Distribution:**
- Steam (primary)
- Itch.io (alternative)
- Direct download (website)

### New Platform Target: Linux
- Added due to Godot's excellent Linux support
- Same system requirements as Windows version

### Future Platforms (Post-Release)

**Consoles:**
- PlayStation 4/5
- Xbox One/Series X|S
- Nintendo Switch (performance considerations)

**Mobile:**
- Android (performance and control considerations)
- iOS (performance and control considerations)

**Note:** Console and mobile ports require additional optimization and control scheme adjustments. Linux support is now confirmed.

---

## Testing & Quality Assurance

### Performance Testing

- Frame rate monitoring (target 60 FPS)
- Memory usage monitoring
- Load time testing
- Stress testing with maximum activity

### Compatibility Testing

- Different hardware configurations
- Different screen resolutions
- Different graphics settings
- Different input devices

### Gameplay Testing

- Playthrough of all 5 stages
- Combat balance testing
- Stealth mechanics testing
- Dialogue and story testing

### Bug Testing

- Regression testing
- Edge case testing
- User acceptance testing
- Beta testing

---

## Success Criteria

### Technical Success

- Game runs at 60 FPS on target hardware
- Total size under 500 MB
- All 5 stages complete and playable
- No critical bugs
- Smooth performance throughout

### User Experience Success

- 1-hour gameplay experience
- Engaging story and gameplay
- Intuitive controls
- Clear visual and audio feedback
- Immersive first-person experience

---

**Related Documents:**
- [GDD.md](GDD.md) – Master overview document
- [Gameplay-Core.md](Gameplay%20Core.md) – Core gameplay mechanics
- [Art-Design.md](Art%20Design.md) – Visual and audio design
- [Shaders.md](Shaders.md) – Shader technical documentation
