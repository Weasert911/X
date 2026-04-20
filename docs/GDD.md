# Game Design Document

## Version
2.0 - Single-Player FPS Narrative Game

## Table of Contents
1. [Overview](#overview)
2. [Story](#story)
3. [Game Mechanics](#game-mechanics)
4. [Weapons](#weapons)
5. [Game Structure](#game-structure)
6. [Art & Audio Overview](#art--audio-overview)
7. [Technical Overview](#technical-overview)
8. [Document Structure](#document-structure)
9. [Revision History](#revision-history)

---

## Overview

### Core Idea

A single-player First Person Shooter (FPS) narrative game about an Indian boy (age 25-27) who was preparing for UPSC but failed. After being hit by a truck, he wakes up in an unfamiliar slum and witnesses child trafficking. He decides to fulfill his childhood dream of being a hero by fighting against the traffickers.

### Target Experience

**Not:** Multiplayer competitive shooter or open-world RPG

**But:** A focused, 1-hour narrative FPS experience with 5 stages, tight gameplay mechanics, and an emotional story about redemption and heroism

### Player Fantasy

- **Be a Hero** – Fulfill the childhood dream of saving others
- **Fight Injustice** – Take down child traffickers and their henchmen
- **Solve Mysteries** – Uncover the truth through dialogue and investigation
- **Protect the Innocent** – Save children from trafficking
- **Experience Redemption** – A story about finding purpose after failure

---

## Story

### Prologue

The protagonist is a 25-27 year old Indian boy who was preparing for UPSC exams but failed. His parents and relatives were calling him, but he wasn't answering their calls. While crossing the road, lost in thought, a truck hit him.

### The Dream

He opens his eyes in an unfamiliar place - a slum. Confused and disoriented, he searches for a way out. While exploring, he witnesses someone dragging children into a truck. He immediately understands it's child trafficking and decides to stop them, fulfilling his childhood dream to be a hero.

### The Journey

He solves mysteries, uncovers the truth by talking to people, fights with henchmen, defeats their trusted men, and finally defeats the main boss. Throughout his journey, he discovers the depth of the trafficking operation and the people behind it.

### The Climax

In the final confrontation, he dies protecting a child from a bullet - a true hero's sacrifice.

### The Revelation

When he wakes up, he finds out he was in a coma for 10 years after the truck hit him and ran - he was dreaming the entire scenario. The dream was his subconscious processing his failure and his desire to be a hero.

---

## Game Mechanics

### Core Movement

- **Run:** Sprint for faster movement, limited by stamina
- **Walk:** Normal movement speed, stealthy approach
- **Jump:** Navigate obstacles and reach higher areas
- **Hide:** Take cover behind objects to avoid detection
- **Crouch:** Move silently, reduce profile, access low areas

### Combat & Interaction

- **Attack:** Use weapons to fight enemies
- **Interact:** Talk to NPCs, investigate clues, use objects

### Design Philosophy

The mechanics are designed to support the narrative experience. Combat is challenging but fair, encouraging strategic thinking and use of the environment. Stealth options allow for different approaches to encounters.

---

## Weapons

### Throwable Weapons

- **Petrol Bomb:** Area-of-effect fire damage, creates temporary fire zones

### Explosive Weapons

- **Grenades:** Standard fragmentation grenades for area damage

### Ranged Weapons

- **Rifle:** Primary weapon, good range and damage
- **Handgun:** Secondary weapon, reliable backup

### Melee Weapons

- **Knife:** Silent takedowns, close-quarters combat
- **Other Melee:** Improvised weapons found in the slum environment

### Weapon Balance

Weapons are balanced to encourage different playstyles. Players can choose stealth (knife, handgun), aggressive (rifle, grenades), or tactical (petrol bombs for crowd control) approaches.

---

## Game Structure

### Duration

Total gameplay time: Approximately 1 hour

### Size

Target size: Less than 500 MB

### Stage Structure

The game consists of 5 stages, each focusing on different aspects of world building, enemies, and mysteries:

#### Stage 1: Awakening
- Introduction to the slum environment
- Witnessing the child trafficking incident
- Learning basic mechanics
- First combat encounters with low-level henchmen

#### Stage 2: Investigation
- Exploring the slum, talking to residents
- Gathering information about the trafficking operation
- Solving environmental puzzles
- Fighting mid-level enemies

#### Stage 3: The Trail
- Following leads to the traffickers' hideout
- More challenging combat encounters
- Introduction to tougher enemy types
- Uncovering the scope of the operation

#### Stage 4: The Stronghold
- Infiltrating the main trafficking base
- Intense combat sequences
- Boss fight with the trusted lieutenant
- Rescuing children

#### Stage 5: The Final Confrontation
- Confronting the main boss
- The climactic battle
- The sacrifice (protecting a child)
- The awakening (coma revelation)

### Narrative Delivery

Major plot points are told through:
- Environmental storytelling (clues, documents, scene composition)
- Dialogue with NPCs
- Cutscenes for key moments
- Player actions and choices

---

## Art & Audio Overview

*Detailed documentation: [Art-Design.md](Art%20Design.md)*

### Visual Style

- **3D Stylized Toon Art** with bold outlines, flat colors, and strong silhouettes
- **First-Person Perspective** for immersive gameplay
- **Indian Slum Setting:** Dense, atmospheric environments that tell a story

### Environment

Modular 3D kits recreating Indian slums with stylized geometry and toon-shaded materials. Environments are designed to be both navigable and visually rich, supporting both combat and exploration.

### Animation

Keyframe 3D animation with snappy, exaggerated motions. First-person weapon animations and third-person character animations for NPCs.

### UI

Toon-styled UI with bold outlines, flat colors, and clear information display. Minimalist design that doesn't distract from the immersive experience.

### Audio

- **Voice:** Natural Indian dialogue with emotional delivery
- **Sound Design:** Atmospheric slum sounds, clear combat cues, impactful weapon sounds
- **Music:** Emotional score that enhances narrative moments

---

## Technical Overview

*Detailed documentation: [Technical-Plan.md](Technical%20Plan.md)*

### Technical Goals

- **Size:** Less than 500 MB total
- **Performance:** 60 FPS on mid-range hardware
- **Duration:** 1 hour of gameplay
- **Structure:** 5 distinct stages

### Technical Stack

- **Engine:** Godot (already in use, supports 3D FPS and toon shaders)
- **Asset Pipeline:** Blender → FBX/GLTF with toon shader & outline setup
- **Shader:** Custom toon-outline shader (`toon_outline.gdshader`) – see [Shaders.md](Shaders.md)
- **Platforms:** PC primary

### Performance Considerations

- Optimized asset loading for small size
- Efficient level streaming for 5 stages
- Streamlined audio assets
- Compressed textures without quality loss

---

## Document Structure

This GDD serves as the master overview. Detailed specifications are split into focused documents:

| Document | Purpose |
|----------|---------|
| **[Gameplay-Core.md](Gameplay%20Core.md)** | Core gameplay mechanics, movement, combat, and interaction details |
| **[Art-Design.md](Art%20Design.md)** | Visual style, audio direction, and art technical constraints |
| **[Technical-Plan.md](Technical%20Plan.md)** | Technical requirements, size optimization, and implementation plan |
| **[Shaders.md](Shaders.md)** | Technical shader implementation details (toon-outline, post-process) |

**Total documents:** 4 (including this master GDD)

---

## Revision History

- **2026-04-19:** Complete redesign to single-player FPS narrative game; removed all multiplayer and gang content
- **Previous:** Multiplayer gang warfare game (archived)
