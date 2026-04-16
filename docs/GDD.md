# Gali Chaos - Game Design Document

## Version
1.1 - Updated for 3D Stylized Toon Art & Top-Down Angled Camera

## Table of Contents
1. [Overview](#overview)
2. [Core Pillars](#core-pillars)
3. [Gameplay Mechanics](#gameplay-mechanics)
4. [Multiplayer Systems](#multiplayer-systems)
5. [Art & Audio Style](#art--audio-style)
6. [Prototype Plan](#prototype-plan)
7. [Technical Considerations](#technical-considerations)

---

## Overview

### Core Idea
A fast-paced multiplayer chaos survival game set in dense Indian environments where players use improvised "jugaad" tools, create noise, and trigger unpredictable world reactions.

### Target Experience
**Not:** Structured competitive battle royale  
**But:** Loud, funny, unpredictable survival where anything can go wrong

### Player Fantasy
- Outsmart chaos
- Troll friends
- Survive ridiculous situations
- Create "clip-worthy" moments

---

## Core Pillars

### 1. Chaos Over Skill
Unpredictability drives fun. Players win through clever decisions, timing, and sometimes pure luck.

### 2. Social Gameplay First
Helping, trolling, and betrayal are core mechanics, not side effects.

### 3. Short Matches
Sessions last 5–8 minutes for high replayability.

### 4. Indian Identity
Gameplay systems (not just visuals) reflect Indian environments and behavior.

---

## Gameplay Mechanics

### Core Loop
Spawn → Loot → Create Chaos → World Reacts → Survive / Betray → Score

### Chaos (Noise) System
- **Overview:** All player actions contribute to a shared Chaos Meter.
- **Chaos Levels:**
  - Low: Light threats (zombies)
  - Medium: Police, dogs, crowds
  - High: Riots, explosions, blackout
- **Chaos Sources:**
  - Weapons
  - Explosions
  - Vehicles (honking)
  - Signals (voice)
  - Environmental destruction
- **Design Goal:** Force players to balance action vs stealth.

### Jugaad System
- **Overview:** Players use improvised items instead of fixed abilities.
- **Item Categories:**
  - Throwable (chappal, bricks)
  - Explosive (gas cylinder, cooker)
  - Utility (rickshaw, water tank)
  - Melee (bat, danda)
- **Examples:**
  - Cooker → timed explosion
  - Gas cylinder → knockback blast
  - Rickshaw → mobile cover
  - Chappal → stun
- **Design Goal:** Encourage creativity and emergent gameplay.

### Desi Signal System
- **Overview:** A radial communication system using expressive Indian voice lines.
- **Features:**
  - 6–8 signals
  - Each includes audio, animation, and gameplay meaning
- **Example Signals:**
  - "Bhaag!" → danger
  - "Dawa de!" → heal request
  - "Maaro!" → attack
  - "Tu gaya 😏" → troll
- **Twist:** Signals generate noise and increase chaos.

### Social Chaos Mechanics
- Item stealing
- Action interruption
- Vehicle hijacking
- Fake signaling
- **Goal:** Encourage interaction beyond combat.

---

## Multiplayer Systems

### Modes
- **Free For All (FFA):** Every player for themselves
- **Squad Mode:** 2–4 players per team

### Match Structure
- Duration: 5–8 minutes
- Objective: Survive longest or score highest

### Scoring
- Survival time
- Chaos contribution
- Player interactions

### Player Interaction Systems
- **Cooperative:**
  - Reviving teammates
  - Sharing items
- **Competitive:**
  - Stealing items
  - Blocking paths
  - Triggering chaos

### Networking Considerations
- Server authoritative model
- Minimal physics sync
- Event-based updates for chaos system

### Key Requirement
Multiplayer must feel:
- Fast
- Responsive
- Unpredictable

---

## Art & Audio Style

### Visual Direction: 3D Stylized Toon Art with Bold Outlines
- **3D stylized art** using toon shading with consistent bold outlines for all characters and props
- **Strong silhouettes** for immediate recognition in chaotic scenes
- **Flat color shading** with minimal gradients, high contrast color palette inspired by Indian streets (bright, saturated, readable)
- **Avoid realism completely** – prioritize clarity over detail
- **No pixel-art rendering or pixel shaders** – all assets are modular 3D models
- **Materials** designed for visual consistency and readability
- **Lighting** enhances shape readability, not realism; uses directional light with subtle rim lighting

### Camera System: Top-Down Angled (Megabonk / Among Us Style)
- **Camera tilt:** ~30–45 degrees for optimal gameplay visibility
- **Wide field of view** to keep multiple players visible at once
- **Supports chaos readability** – camera designed to maintain clarity during dense action
- **Player interaction awareness** – camera angle ensures players can see each other’s actions and environmental reactions
- **Avoids obstruction** in dense environments through careful level design and camera positioning
- **Avoids first-person and third-person over-the-shoulder** perspectives

### Characters
- **Modular 3D models** with stylized low-poly to mid-poly geometry
- **Expressive toon-shaded animation** with smooth keyframe animation (not frame-by-frame pixel)
- **Strong silhouettes** maintained through bold outlines and shape language
- **Clothing and details** reflect Indian urban culture using simple, bold shapes
- **Facial expressions** conveyed through exaggerated but clean 3D morphs or texture changes
- **Proportional stylization** – slightly exaggerated features for readability and humor

### Environment
- **Modular 3D environments** built from reusable kits (walls, roofs, props)
- **Dense Indian streets** (gali, markets, rooftops) recreated with stylized geometry
- **Layered depth** through parallax scrolling or multi-plane camera (optional)
- **Top-down perspective** optimized for camera angle
- **Toon-shaded materials** with flat colors and outlines matching character style
- **Key elements** as 3D models: rickshaws, bikes, auto-rickshaws, small houses, street props (crates, carts, water tanks, vendors)

### Animation Style
- **Keyframe 3D animation** with snappy, exaggerated motions
- **Squash & stretch** applied within 3D deformation for impact
- **Humor-driven motion** with precise timing and cartoon physics
- **Limited animation cycles** for efficiency (walk: 4–6 keyframes, run: 6–8 keyframes, idle: 2–3 keyframes)
- **Outline consistency** – outlines remain stable during deformation

### UI Style
- **Toon-styled UI** with bold outlines and flat colors matching the 3D art
- **Clean, simple icons** designed as 2D vector art that complements the 3D look
- **Minimal text, more intuitive symbols** using stylized representations
- **Color coding** for quick recognition within the high-contrast palette
- **No pixel fonts** – use clean, readable sans-serif fonts with slight stylization

### Audio Direction

#### Voice Style
- Natural Indian slang (not forced memes)
- Short, punchy lines with comedic delivery
- Slight variations to avoid repetition
- Voice acting with mature but playful tone
- **No chip-tune voice effects** – clean, modern voice processing that matches the 3D style

#### Sound Design
- Environmental chaos (crowds, dogs, horns, street sounds) with stylized audio treatments
- Comedic timing for effects with exaggerated pitch and timing
- Clear audio cues for gameplay actions using distinct sound signatures
- Layered audio for depth while maintaining clarity

### Technical Constraints & Guidelines
1. **Outline Rendering:** Consistent outline thickness across all assets via post-process or geometry shader
2. **Color Palette:** High-contrast, saturated colors with flat shading; avoid gradients and noisy textures
3. **Animation Budget:** Max 8 keyframes per character action, 4 for environment objects
4. **Model Complexity:** Low-poly to mid-poly counts optimized for multiplayer performance
5. **Camera:** Fixed top-down angled camera with no rotation; level design must account for visibility
6. **Asset Pipeline:** 3D models in FBX/GLTF format; materials use toon shader with outline parameter

### Key Principle
**Clarity over detail.**  
Chaos must be readable at all times through shape language, outlines, and strong silhouettes.  
Humor through clever design and exaggerated motion, not through childish exaggeration.  
**Every shape intentional.**

---

## Prototype Plan (MVP)

### Goal
Build a playable version that proves:
- Chaos is fun
- Multiplayer works
- Core loop is engaging

### Phase 1: Core Setup
- Player movement
- Basic map (gali layout)
- Camera (top-down angled)

### Phase 2: Core Mechanics
- **Chaos System:**
  - Basic meter
  - 2 levels (Low, High)
- **Jugaad Items:**
  - 1 throwable (chappal)
  - 1 explosive (cooker)
  - 1 vehicle (rickshaw)

### Phase 3: Multiplayer
- 4–8 players
- Basic sync (movement + actions)

### Phase 4: Events
- Police spawn
- Basic enemy AI

### Phase 5: Signals (Basic)
- 3 signals
- Radial menu

### Playtest Checklist
- Do players laugh?
- Do players troll each other?
- Does chaos feel fair?

### Success Criteria
- Matches feel different each time
- Players create their own fun
- No major confusion during chaos

### Do NOT Build Yet
- Cosmetics
- Progression
- Store/monetization
- Advanced UI

### Next Step After MVP
Expand:
- Items
- Chaos events
- Maps

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
- Detailed documentation is available in [06 - Shaders.md](06%20-%20Shaders.md).
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

## Revision History
- **2026-04-16:** Updated visual style to 3D stylized toon art with top-down angled camera
- **2026-04-12:** Updated visual style to 32x32 pixel art, consolidated GDD
- **Previous:** Initial documentation split across multiple files