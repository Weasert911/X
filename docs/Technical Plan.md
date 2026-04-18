# Technical Plan & Implementation

*Part of the Gali Chaos Game Design Document*

**Version:** 1.2  
**Last Updated:** 2026-04-16  
**Source:** Extracted from GDD.md sections "Prototype Plan (MVP)" and "Technical Considerations"

---

## Table of Contents

1. [Prototype Plan (MVP)](#prototype-plan-mvp)
   - [Goal](#goal)
   - [Phase 1: Core Setup](#phase-1-core-setup)
   - [Phase 2: Core Mechanics](#phase-2-core-mechanics)
   - [Phase 3: Multiplayer](#phase-3-multiplayer)
   - [Phase 4: Events](#phase-4-events)
   - [Phase 5: Signals (Basic)](#phase-5-signals-basic)
   - [Phase 6: Territory Control (LIGHT)](#phase-6-territory-control-light)
   - [Playtest Checklist](#playtest-checklist)
   - [Success Criteria](#success-criteria)
   - [Do NOT Build Yet](#do-not-build-yet)
   - [Next Step After MVP](#next-step-after-mvp)
2. [Technical Considerations](#technical-considerations)
   - [Engine](#engine)
   - [Asset Pipeline](#asset-pipeline)
   - [Shader Implementation](#shader-implementation)
   - [Performance Targets](#performance-targets)
   - [Platform Targets](#platform-targets)

---

## Prototype Plan (MVP)

### Goal

Build a playable version that proves:
- Chaos is fun
- Multiplayer works
- Core loop is engaging
- Gang identity adds personality without breaking balance

### Phase 1: Core Setup

- Player movement
- Basic map (gali layout)
- Camera (top-down angled)

### Phase 2: Core Mechanics

**Chaos System:**
- Basic meter
- 2 levels (Low, High)

**Jugaad Items:**
- 1 throwable (chappal)
- 1 explosive (cooker)
- 1 vehicle (rickshaw)

**Gang System (NEW):**
- 2–3 gang archetypes (basic versions)
  - IAS Aspirant
  - Corporate Majdur
  - Tapori Gunda
- Basic gang selection UI
- Gang visual identity (simple outfit differences)
- Gang indicators above players
- Minor passives implemented (very light, non-meta breaking)

### Phase 3: Multiplayer

- 4–8 players
- Basic sync (movement + actions)
- Gang visibility in multiplayer
- Gang indicators synced across clients
- Basic gang scoring (points per gang)

### Phase 4: Events

- Police spawn
- Basic enemy AI
- Chaos events affect all gangs equally

### Phase 5: Signals (Basic)

- 3 signals
- Radial menu
- Gang-specific voice variations for signals

### Phase 6: Territory Control (LIGHT)

- Basic zone spawning
- Zone capture mechanic
- Gang ownership display
- Simple scoring for zone control

### Playtest Checklist

- Do players laugh?
- Do players troll each other?
- Does chaos feel fair?
- Are gangs recognizable at a glance?
- Do gang passives feel balanced (not overpowered)?
- Do players form and break alliances naturally?
- Does territory control add fun without dominating gameplay?

### Success Criteria

- Matches feel different each time
- Players create their own fun
- No major confusion during chaos
- Gang identity is clear and adds personality
- Social dynamics (alliances, betrayal) emerge naturally
- Chaos system remains dominant over gang abilities

### Do NOT Build Yet

- Advanced cosmetics
- Progression systems
- Store/monetization
- Advanced UI
- More than 3 gang archetypes
- Complex alliance UI (keep it signal-based)

### Next Step After MVP

Expand:
- More jugaad items
- More chaos events
- More maps
- Additional gang archetypes (up to 5 total)
- Refined territory control mechanics
- More social chaos interactions

---

## Technical Considerations

### Engine

- Unity or Godot recommended for 3D stylized rendering and multiplayer support

### Asset Pipeline

- All 3D assets created in Blender/Maya with toon shader and outline setup
- Export as FBX/GLTF with consistent scale and pivot
- Material definitions for flat colors and outline thickness

### Shader Implementation

- A custom screen‑space toon‑outline shader (`toon_outline.gdshader`) provides color controls, posterization, and edge detection.
- Detailed documentation is available in [06 - Shaders.md](Shaders.md).
- The shader is applied as a full‑screen post‑process effect via a `CanvasLayer` (`scene/shader.tscn`).

### Performance Targets

- 60 FPS on mid-range hardware
- Support for 8+ players with minimal lag
- Efficient netcode for chaotic real-time interactions
- Outline rendering optimized for multiplayer visibility

### Platform Targets

- PC (Steam) primary
- Consoles (Switch, PlayStation, Xbox) possible later
- Mobile considered but not priority due to control complexity

---

**Related Documents:**
- [GDD.md](../GDD.md) – Master overview document
- [Gameplay-Core.md](Gameplay%20Core.md) – Core gameplay mechanics and multiplayer systems
- [Art-Design.md](Art%20Design.md) – Visual and audio design
- [06 - Shaders.md](Shaders.md) – Shader technical documentation