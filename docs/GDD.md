# Gali Chaos - Game Design Document

## Version
1.2 - Updated for Gang-Based Gameplay and Identity

## Table of Contents
1. [Overview](#overview)
2. [Core Pillars](#core-pillars)
3. [Gameplay Systems Overview](#gameplay-systems-overview)
4. [Art & Audio Overview](#art--audio-overview)
5. [Technical & Prototype Overview](#technical--prototype-overview)
6. [Document Structure](#document-structure)
7. [Revision History](#revision-history)

---

## Overview

### Core Idea

A fast-paced multiplayer gang warfare game set in dense Indian environments where rival street gangs fight for dominance using improvised jugaad tools, creating chaos that triggers unpredictable world reactions.

In a cramped Indian gali where power cuts, loud fights, and street politics are part of daily life, small-time groups—failed dreamers, hustlers, and survivors—form chaotic street gangs trying to control the area for reputation, survival, and ego.

### Target Experience

**Not:** Structured competitive battle royale or esports shooter

**But:** Loud, funny, unpredictable gang warfare where anything can go wrong, alliances shift in seconds, and the last gang standing—or the one who caused the most chaos—wins

### Player Fantasy

- **Belong to a gang** – Choose your identity, represent your crew, fight for your territory
- **Outplay rival gangs** – Use chaos as a weapon, manipulate the world against your enemies
- **Create chaos for dominance** – Turn the gali into your playground, make your mark, become the most notorious gang on the street
- **Survive ridiculous situations** – Power cuts, police raids, riots—handle it all with jugaad and street smarts
- **Create "clip-worthy" moments** – Betrayals, explosions, last-minute escapes—moments worth sharing

---

## Core Pillars

### 1. Chaos Over Skill

Unpredictability drives fun. Players win through clever decisions, timing, and sometimes pure luck. Gangs that understand how to manipulate chaos—using it against rivals while protecting their own—gain the upper hand.

### 2. Social Gameplay First

Helping, trolling, and betrayal are core mechanics, not side effects. Alliances form and break between gangs in seconds. Trust is temporary, betrayal is inevitable.

### 3. Short Matches

Sessions last 5–8 minutes for high replayability. Quick, intense gang skirmishes that anyone can jump into.

### 4. Indian Identity

Gameplay systems (not just visuals) reflect Indian environments and behavior. Gang archetypes are grounded in real Indian urban life—IAS aspirants, corporate slaves, tapori locals—each with their own personality and style.

---

## Gameplay Systems Overview

*Detailed documentation: [Gameplay-Core.md](Gameplay%20Core.md)*

### Core Loop
Spawn → Join/Represent Gang → Loot → Create Chaos → Rival Gangs React → World Reacts → Control / Survive / Betray → Score

### Key Systems
- **Chaos (Noise) System:** Shared meter that escalates with player actions, triggering world reactions (police, riots, blackouts).
- **Gang System:** Social identities with light passives, visual flair, and personality-driven voice lines.
- **Jugaad System:** Improvised items (chappal, cooker, rickshaw) as the great equalizer.
- **Desi Signal System:** Radial communication using Indian voice lines that generate noise.
- **Social Chaos Mechanics:** Betrayal, alliances, item stealing, and gang‑specific social moves.
- **Territory Control:** Light zone‑capture system that creates dynamic conflict points.

### Multiplayer Modes
- **Loose Gang Chaos:** Free‑for‑all with temporary alliances.
- **Gang vs Gang:** Pre‑selected gang warfare.
- **Dynamic Alliances:** Player‑driven, betrayal‑focused emergent gameplay.

### Scoring & Winning
Individual and gang scoring based on survival, chaos contribution, zone control, alliances, and betrayals.

---

## Art & Audio Overview

*Detailed documentation: [Art-Design.md](Art%20Design.md)*

### Visual Style
- **3D Stylized Toon Art** with bold outlines, flat colors, and strong silhouettes.
- **Top‑Down Angled Camera** (~30–45°) for optimal visibility in chaotic scenes.
- **Gang‑Driven Identity:** Each archetype has distinct silhouette, outfit, color palette, and accessories.

### Environment
Modular 3D kits recreating dense Indian streets (gali, markets, rooftops) with stylized geometry and toon‑shaded materials.

### Animation
Keyframe 3D animation with snappy, exaggerated motions and gang‑specific movement flavors.

### UI
Toon‑styled UI with bold outlines, flat colors, and gang‑aware elements (gang indicators, alliance lines, zone markers).

### Audio
- **Voice:** Natural Indian slang with gang‑based personality variations.
- **Sound Design:** Stylized environmental chaos, comedic timing, clear gameplay cues.
- **Contextual Reactions:** Panic, ego, trolling, and betrayal voice lines.

### Gang Archetypes
Five grounded Indian urban archetypes:
1. **IAS Aspirant** – Stressed UPSC dreamer
2. **Corporate Majdur** – Burned‑out office worker
3. **Tapori Gunda** – Street‑smart local
4. **Gym Bro** – Fitness‑obsessed motivator
5. **Tech Bro** – Startup jargon‑speaking gadget lover

Each has visual identity, voice personality, and a very light passive (10–15% modifier).

---

## Technical & Prototype Overview

*Detailed documentation: [Technical-Plan.md](Technical%20Plan.md)*

### Prototype (MVP) Goal
Prove chaos is fun, multiplayer works, core loop engages, and gang identity adds personality without breaking balance.

### MVP Phases
1. **Core Setup:** Movement, map, camera
2. **Core Mechanics:** Chaos meter, jugaad items, gang system
3. **Multiplayer:** 4–8 players, sync, gang visibility
4. **Events:** Police spawn, enemy AI
5. **Signals:** Basic radial communication
6. **Territory Control:** Light zone capture

### Technical Stack
- **Engine:** Unity or Godot (3D stylized rendering + multiplayer support)
- **Asset Pipeline:** Blender/Maya → FBX/GLTF with toon shader & outline setup
- **Shader:** Custom screen‑space toon‑outline shader (`toon_outline.gdshader`) – see [06 - Shaders.md](Shaders.md)
- **Performance:** 60 FPS on mid‑range hardware, 8+ players with minimal lag
- **Platforms:** PC (Steam) primary, consoles possible later

### Success Criteria
- Matches feel different each time
- Players create their own fun
- No major confusion during chaos
- Gang identity clear and personality‑adding
- Social dynamics (alliances, betrayal) emerge naturally
- Chaos system remains dominant over gang abilities

---

## Document Structure

This GDD serves as the master overview. Detailed specifications are split into focused documents:

| Document | Purpose |
|----------|---------|
| **[Gameplay-Core.md](Gameplay%20Core.md)** | Core gameplay mechanics, multiplayer systems, scoring, and interaction details |
| **[Art-Design.md](Art%20Design.md)** | Visual style, audio direction, gang archetypes, and art technical constraints |
| **[Technical-Plan.md](Technical%20Plan.md)** | Prototype (MVP) plan, technical considerations, engine, and performance targets |
| **[06 - Shaders.md](Shaders.md)** | Technical shader implementation details (toon‑outline, post‑process) |

**Total documents:** 5 (including this master GDD)

### Consolidation Note
Originally 8 documents (01–07 + GDD) have been consolidated into 5 documents:
- GDD.md (overview/master)
- Gameplay‑Core.md (merged gameplay mechanics + multiplayer systems)
- Art‑Design.md (merged art/audio + gang archetypes)
- Technical‑Plan.md (merged prototype plan + technical considerations)
- 06 - Shaders.md (unchanged technical shader doc)

All original content is preserved; redundant files (01–05, 07) have been archived.

---

## Revision History

- **2026-04-17:** Consolidated 8 documents into 5; split GDD into overview + three detailed docs; updated references.
- **2026-04-16:** Updated for gang-based gameplay and identity, added Gang Archetypes section
- **2026-04-16:** Updated visual style to 3D stylized toon art with top-down angled camera
- **2026-04-12:** Updated visual style to 32x32 pixel art, consolidated GDD
- **Previous:** Initial documentation split across multiple files
