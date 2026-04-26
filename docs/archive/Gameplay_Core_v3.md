# Gameplay Core Systems: YOU MUST EAT

*Part of the Game Design Document*

**Version:** 3.0
**Last Updated:** 2026-04-26
**Source:** Single-player Narrative FPS

---

## Table of Contents

1. [Movement Mechanics](#movement-mechanics)
2. [Combat Mechanics](#combat-mechanics)
3. [Interaction Mechanics](#interaction-mechanics)
4. [Stealth & Shadow Mechanics](#stealth--shadow-mechanics)
5. [Weapon Systems](#weapon-systems)
6. [Enemy AI](#enemy-ai)
7. [Progression Systems](#progression-systems)

---

## Movement Mechanics

### Sprint
**Overview:** High-speed movement used for closing distances or escaping, limited by physical and mental fatigue.

**Mechanics:**
- Hold sprint button to increase speed (1.5x walk speed).
- Stamina depletes rapidly while sprinting.
- Stamina regenerates when walking or standing still.
- Sprinting generates significant noise, alerting nearby Syndicate members.

**Design Goal:** Running is a risk. It allows for fast movement but leaves Arjun vulnerable and exposed.

### Walk
**Overview:** The default movement state, balanced for exploration and tactical positioning.

**Mechanics:**
- Moderate speed.
- Minimal noise generation.
- baseline state for transitioning to stealth or combat.

### Jump & Navigation
**Overview:** Basic traversal of the vertical and cluttered environments of Dharavi.

**Mechanics:**
- Standard FPS leap to clear waist-high obstacles.
- Interaction with ledges to climb into higher "rooktops" (tin roofs).
- Landing from heights has a slight recovery time, potentially alerting enemies.

### Hide & Cover
**Overview:** Utilizing the oppressive environment to break line-of-sight and survive gunfights.

**Mechanics:**
- Press hide button near cover (walls, corrugated steel, debris).
- Camera adjusts to show over/around cover.
- Significantly reduces the player's profile.
- Provides protection from direct fire.
- Allows "peeking" to observe enemy patterns.

### Crouch
**Overview:** Low-profile movement for silent infiltration.

**Mechanics:**
- Reduced movement speed (0.6x walk speed).
- Minimal noise generation.
- Necessary for accessing low-clearance vents or hiding under structures.
- Increased accuracy for ranged weapons.

---

## Combat Mechanics

### Attack
**Overview:** Purposeful, weighted combat. Arjun is a professional, but he is fighting against a system.

**Mechanics:**
- **Primary Attack:** Fire equipped weapon.
- **Secondary Attack:** Tactical melee strike (improvised weapons or fists).
- **Aim Down Sights (ADS):** Necessary for precision shots; reduces movement speed.
- **Recoil:** Significant weapon kick that requires control during sustained fire.
- **Critical Hits:** Headshots deal massive damage, reflecting Arjun's tactical training.

### Damage System
**Player Health:**
- Health bar displayed on HUD.
- Damage is high; Arjun cannot survive prolonged open fire.
- Health regenerates very slowly only after a significant period of safety.
- Limited medical supplies found in the environment.

**Enemy Health:**
- Varies by rank (Scouts $\rightarrow$ Fixers $\rightarrow$ Upper Tier).
- Weak points (head/neck) are highly effective.
- Some high-tier enemies wear concealed armor, requiring tactical flanking.

---

## Interaction Mechanics

### Interact
**Overview:** Gathering evidence and negotiating with the survivors of Dharavi.

**Mechanics:**
- Press interact button to engage with the world.
- **Dialogue:** Branching conversations with residents and informants. Choices reflect Arjun's "Broken Good" alignment.
- **Investigation:** Searching for "The Ledger" and other clues. This unlocks new locations and dialogue options.
- **Object Use:** Opening locked doors, bypassing security, and manipulating the environment.
- **Pickup:** Scavenging for limited ammo and improvised weapons.

---

## Stealth & Shadow Mechanics

### Shadow Merge (Hashing Shadows)
**Overview:** The core tactical mechanic. Arjun utilizes the extreme contrast of the environment to vanish.

**Mechanics:**
- When standing in "Deep Black" areas, Arjun can enter a "Merge" state.
- While merged, he is nearly invisible to enemies unless they are extremely close.
- **Shadow Meter:** Merging consumes a resource that regenerates when in light or when stationary.
- Moving while merged reduces the effectiveness and increases the risk of detection.

### Detection System
**Overview:** A high-tension system based on sight and sound.

**Mechanics:**
- **Visual Detection:** Line-of-sight based. Red highlight on enemies when they are actively searching for the player.
- **Audio Detection:** Noise from sprinting, shooting, or knocking over objects creates "sound ripples" that attract enemies.
- **Detection States:** Unaware $\rightarrow$ Suspicious (Investigating) $\rightarrow$ Alerted $\rightarrow$ Combat.
- **Breaking Line-of-Sight:** Merging into shadows or using cover to reset the detection meter.

---

## Weapon Systems

### Weapon Categories

**Improvised Melee:**
- Rusted pipes, knives, and scrap metal. Used for silent takedowns and desperate close-quarters fighting.

**Ranged Weapons:**
- **Handgun:** Precise, reliable, and quiet. The primary tool for tactical strikes.
- **Rifle/Shotgun:** High impact, used for breaching "nests" and dealing with groups of Fixers.

**Tactical Gear:**
- Distraction items used to manipulate enemy patrol paths.

### Weapon Mechanics
- **Limited Ammunition:** Ammo is scarce, forcing the player to rely on stealth and melee.
- **Manual Reloading:** Tactical pauses in combat that create tension.
- **Weapon Switching:** Limited slots (2-3 weapons) to prevent the player from becoming an "army of one."

---

## Enemy AI

### Enemy Hierarchy

**1. Scouts:**
- Low health, high numbers.
- Basic patrol patterns.
- Alert other enemies quickly when they spot the player.

**2. Fixers:**
- Moderate health, better weaponry (rifles).
- Use cover and flanking tactics.
- More aggressive and likely to hunt the player once alerted.

**3. The Upper Tier (Bosses):**
- High health, specialized gear.
- Intelligent AI: They set traps, use the environment, and coordinate their attacks.
- High psychological pressure through dialogue during combat.

### AI Behavior
- **Patrol:** Routine movement that can be learned and exploited.
- **Investigate:** Systematic searching of the last known player position.
- **Combat:** Coordinated flanking and suppression fire.

---

## Progression Systems

### Narrative Progression
**Act-Based Structure:**
The game progresses through 5 distinct Acts. Each Act concludes with a major narrative revelation and a tactical climax.
- **Act 1 $\rightarrow$ Act 2 $\rightarrow$ Act 3 $\rightarrow$ Act 4 $\rightarrow$ Act 5**

### Player Mastery
- **No RPG Stats:** There are no experience points or skill trees.
- **Learning Curve:** Progression is based on the player mastering the "Shadow Merge" and understanding enemy patterns.
- **Gear Acquisition:** New weapons are found in the environment, not unlocked via menus.

---

**Related Documents:**
- [GDD.md](GDD.md) – Master overview document
- [Art-Design.md](Art%20Design.md) – Visual and audio design
- [Technical-Plan.md](Technical%20Plan.md) – Technical implementation
- [Shaders.md](Shaders.md) – Shader technical documentation
