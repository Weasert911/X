# Gali Chaos - Game Design Document

## Version
1.0 - Updated for 32x32 Pixel Art Style

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

### Visual Direction: 32x32 Pixel Art
- **32x32 pixel base** for characters and key objects, with environment tiles at same scale
- **Limited color palette** (16-32 colors) for cohesive retro feel
- **Clear pixel-level readability** with intentional aliasing and pixel-perfect edges
- **Vibrant but constrained colors** inspired by Indian street art and classic pixel art games
- **Balance between detail and simplicity** - each pixel counts for maximum expression
- **Retro aesthetic with modern polish** - crisp animations, smooth lighting effects

### Characters
- **Base sprite size:** 32x32 pixels (can be taller with multi-tile characters)
- **Expressive pixel animation** with limited frames (4-8 frames per action)
- **Strong silhouettes** for immediate recognition in chaotic scenes
- **Clothing and details** reflect Indian urban culture using minimal pixel representation
- **Facial expressions** conveyed through subtle pixel changes (eyebrow, mouth shifts)
- **Proportional stylization:** slightly exaggerated features for readability, not chibi

### Environment
- **Tile-based environments** with 32x32 pixel tiles
- **Dense Indian streets** (gali, markets, rooftops) recreated in pixel art detail
- **Layered parallax backgrounds** for depth (2-3 layers max)
- **Isometric or top-down perspective** depending on gameplay needs
- **Pixel art textures** with dithering and pattern techniques for visual interest

#### Key Elements (Pixel Art Versions)
- Rickshaws, bikes, auto-rickshaws (simplified iconic shapes)
- Small houses with accessible interiors (doorways as 2x2 pixel openings)
- Street props (crates, carts, water tanks, street vendors) as 16x16 or 32x32 sprites
- Graffiti and wall art as pixel art murals (8x8 or 16x16 tile patterns)

### Animation Style
- **Frame-by-frame pixel animation** with smooth interpolation
- **Snappy, exaggerated motions** within pixel grid constraints
- **Squash & stretch** using 1-2 pixel deformations for impact
- **Humor-driven motion** with precise timing (pixel-perfect transitions)
- **Limited animation cycles** (walk: 4 frames, run: 6 frames, idle: 2 frames)

### UI Style
- **Pixel font interface** (4x6 or 6x8 pixel fonts)
- **Clean pixel icons** with 16x16 or 24x24 dimensions
- **Minimal text, more intuitive symbols** using pixel art representations
- **Color coding** for quick recognition within limited palette
- **Retro-inspired menus** with scanlines or CRT filter options

### Audio Direction

#### Voice Style
- Natural Indian slang (not forced memes)
- Short, punchy lines with comedic delivery
- Slight variations to avoid repetition
- Voice acting with mature but playful tone
- **8-bit/16-bit chip tune style voice effects** optional for retro consistency

#### Sound Design
- Environmental chaos (crowds, dogs, horns, street sounds) with chiptune adaptations
- Comedic timing for effects with retro sound chip limitations (square waves, noise channels)
- Clear audio cues for gameplay actions using distinct frequency ranges
- Layered audio for depth while maintaining retro hardware constraints

### Technical Constraints & Guidelines
1. **Pixel Grid:** All assets align to 32x32 grid, sub-elements to 16x16 or 8x8
2. **Color Palette:** Primary palette of 16 colors, extended palette of 32 for accents
3. **Animation Budget:** Max 8 frames per character action, 4 frames for environment
4. **Memory Considerations:** Sprite sheets organized for efficient rendering
5. **Scaling:** Integer scaling only (2x, 3x, 4x) to preserve pixel perfection

### Key Principle
**Clarity over detail.**  
Chaos must be readable at all times, even at pixel level.  
Humor through clever pixel design, not through childish exaggeration.  
**Every pixel intentional.**

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
- Camera (top-down)

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
- Unity or Godot recommended for 2D pixel art and multiplayer support

### Asset Pipeline
- All art assets must be created at 1x scale (32x32 base)
- Export as sprite sheets with consistent naming conventions
- Use Aseprite or Pyxel Edit for pixel art creation

### Performance Targets
- 60 FPS on mid-range hardware
- Support for 8+ players with minimal lag
- Efficient netcode for chaotic real-time interactions

### Platform Targets
- PC (Steam) primary
- Consoles (Switch, PlayStation, Xbox) possible later
- Mobile considered but not priority due to control complexity

---

## Revision History
- **2026-04-12:** Updated visual style to 32x32 pixel art, consolidated GDD
- **Previous:** Initial documentation split across multiple files