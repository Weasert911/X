# Game Design Document: YOU MUST EAT

## Version
3.0 - Single-Player Narrative FPS

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

A single-player First Person Shooter (FPS) narrative game about Arjun Kale, a disgraced Ex-Crime Branch detective. After his niece, Priya, is kidnapped by a sophisticated trafficking ring known as "The Caterers" in the slums of Dharavi, Mumbai, Arjun returns to the only place he knows how to navigate. He must move through the shadows, fight the Syndicate, and dismantle the systemic corruption that destroyed his life and took his family.

### Target Experience

**Not:** Multiplayer competitive shooter or open-world RPG.

**But:** A focused, atmospheric narrative FPS experience with 5 acts, tight stealth/combat mechanics, and a grim story about systemic corruption, grief, and redemption.

### Player Fantasy

- **The Disgraced Professional** – Use professional detective skills and combat training in an illegal, lawless environment.
- **Fight Systemic Injustice** – Take down a network that operates with the complicity of the state.
- **Rescue the Innocent** – A desperate race against time to save Priya.
- **Navigate the Shadows** – Master the "Hashing Shadows" mechanic to survive against superior numbers.

---

## Story

### Prologue: The Fall
Arjun Kale was a decorated detective until he uncovered evidence linking a senior politician to a child trafficking ring. Within days, the evidence vanished, and Arjun was framed and dismissed from the force. He spent years in a spiral of alcoholism and isolation.

### The Catalyst
Arjun's niece, Priya (9), vanishes from Dharavi. The police ignore the case. The community remains silent. Arjun realizes the "Caterers" are back, and this time, it is personal.

### The Journey
Arjun returns to Dharavi. He moves from the lowest rungs of the Syndicate (the Scouts and Fixers) upward. He discovers that the trafficking ring is not just a criminal enterprise, but a tool of political leverage.

### The Climax
Arjun infiltrates the "Feast," the central hub of the Syndicate. He confronts the Cabinet Minister and the head of the Caterers in a final stand. He chooses to save Priya over his own professional redemption, but ensures the truth is leaked to the world, permanently breaking the silence of Dharavi.

---

## Game Mechanics

### Core Movement
- **Sprint:** Faster movement, limited by stamina.
- **Stealth Walk:** Slow, silent movement; essential for avoiding patrols.
- **Crouch/Cover:** Reduce profile, use environment to hide from sightlines.
- **Shadow Merge (Hashing Shadows):** A tactical mechanic allowing Arjun to blend into high-contrast shadows to avoid detection or ambush enemies.

### Combat & Interaction
- **Tactical Combat:** Weighted, purposeful gunplay. Every bullet counts.
- **Silent Takedowns:** Use melee weapons to neutralize enemies without alerting the area.
- **Investigation:** Interact with documents, logs, and NPCs to uncover the locations of the "nests."

### Design Philosophy
The gameplay emphasizes "The Hunter vs. The Hunted." Arjun is often outnumbered, making stealth and environmental awareness critical. Combat should feel brutal and impactful, reflecting the "Broken Good" alignment of the protagonist.

---

## Weapons

### Melee Weapons
- **Improvised Tools:** Rusted pipes, knives, and other slum-found items for silent kills and desperation combat.

### Ranged Weapons
- **Handgun:** Reliable, precise, used for tactical shots.
- **Rifle/Shotgun:** High impact, used for breaching and loud confrontations.

### Tactical Gear
- **Distractions:** Items to lure guards away from posts.
- **Limited Ammo:** Encourages stealth and strategic weapon use.

---

## Game Structure

### Duration
Total gameplay time: Approximately 2-3 hours.

### Stage Structure (The 5 Acts)

#### Act 1: The Return
- **Objective:** Navigate into Dharavi and locate an old informant.
- **Focus:** Tutorial, movement, and atmosphere.
- **Climax:** Finding the informant dead; realizing the Syndicate is waiting for him.

#### Act 2: The Scout
- **Objective:** Track the fixer "Munia" and find the ledger.
- **Focus:** Stealth in crowded environments and the first major firefight.
- **Climax:** Finding Priya's name in the ledger; confirmation of her abduction.

#### Act 3: The Safe House
- **Objective:** Breach the textile factory holding cell.
- **Focus:** Tactical room clearing and rescuing children.
- **Climax:** The phone call; the realization that Priya has been moved to the "Feast."

#### Act 4: The Descent
- **Objective:** Infiltrate the political circles of Mumbai to find the "Feast" location.
- **Focus:** High-stakes infiltration, contrasting luxury with the slum's grime.
- **Climax:** Identifying the Cabinet Minister as the head of the operation.

#### Act 5: The Feast
- **Objective:** Infiltrate the final complex and rescue Priya.
- **Focus:** Final boss confrontation and maximum intensity combat.
- **Climax:** The rescue of Priya and the systemic exposure of the Syndicate.

---

## Art & Audio Overview

*Detailed documentation: [Art Design.md](Art%20Design.md)*

### Visual Style
- **Black-White-Red Aesthetic:** High contrast palette. Shadows are deep black, highlights are stark white, and danger/importance is highlighted in red.
- **Hashing Shadows Shader:** A raw, sketch-like art style that abstracts detail and emphasizes atmosphere.
- **Perspective:** First-Person for maximum immersion in the oppressive environment of the slum.

### Environment
A dense, suffocating recreation of Dharavi. Narrow alleyways, corrugated tin walls, and claustrophobic interiors. The environment tells the story of the "missing" through discarded belongings and systemic decay.

### Audio
- **Atmospheric Soundscape:** The constant hum of the city, distant sirens, and the oppressive silence of the shadows.
- **Dialogue:** Gritty, realistic Indian English and Hindi, focusing on the tension of silence and complicity.
- **Score:** A minimalist, tense soundtrack that swells during combat and fades into unsettling silence during stealth.

---

## Technical Overview

*Detailed documentation: [Technical Plan.md](Technical%20Plan.md)*

### Technical Goals
- **Atmosphere:** Priority on the "Hashing Shadows" shader for visual identity.
- **Performance:** Smooth 60 FPS to maintain the fluidity of stealth and combat.
- **Size:** Optimized assets to keep the footprint low.

### Technical Stack
- **Engine:** Godot.
- **Shader:** Custom High-Contrast/Hashing shader for the black-white-red look.
- **Platform:** PC.

---

## Document Structure

This GDD serves as the master overview. Detailed specifications are split into focused documents:

| Document | Purpose |
|----------|---------|
| **[Gameplay Core.md](Gameplay%20Core.md)** | Core gameplay mechanics, movement, and combat details |
| **[Art Design.md](Art%20Design.md)** | Visual style, the Hashing Shadows aesthetic, and audio direction |
| **[Technical Plan.md](Technical%20Plan.md)** | Technical requirements and implementation plan |
| **[Shaders.md](Shaders.md)** | Technical implementation of the black-white-red visual style |

---

## Revision History

- **2026-04-26:** Complete pivot to "YOU MUST EAT" narrative; replaced UPSC student plot with Arjun Kale/Syndicate story; updated art style to Hashing Shadows.
- **2026-04-19:** Redesign to single-player FPS narrative game.
