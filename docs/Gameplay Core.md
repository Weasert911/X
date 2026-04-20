# Gameplay Core Systems

*Part of the Game Design Document*

**Version:** 2.0  
**Last Updated:** 2026-04-19  
**Source:** Single-player FPS narrative game

---

## Table of Contents

1. [Movement Mechanics](#movement-mechanics)
2. [Combat Mechanics](#combat-mechanics)
3. [Interaction Mechanics](#interaction-mechanics)
4. [Stealth Mechanics](#stealth-mechanics)
5. [Weapon Systems](#weapon-systems)
6. [Enemy AI](#enemy-ai)
7. [Progression Systems](#progression-systems)

---

## Movement Mechanics

### Run

**Overview:** Sprint for faster movement, limited by stamina

**Mechanics:**
- Hold sprint button to run at increased speed (1.5x walk speed)
- Stamina depletes while running
- Stamina regenerates when not running
- Cannot run while crouching or hiding
- Running generates noise that can alert enemies

**Stamina System:**
- Full stamina: 5-8 seconds of continuous running
- Stamina regenerates over 3-5 seconds when walking
- Stamina regenerates faster when standing still
- Visual indicator: Stamina bar on HUD

**Design Goal:** Encourage tactical use of running - use it to close distance or escape, but manage stamina carefully

### Walk

**Overview:** Normal movement speed, stealthy approach

**Mechanics:**
- Default movement state
- Moderate speed (balanced for exploration and combat)
- Minimal noise generation
- Can transition to run, crouch, or hide at any time
- No stamina cost

**Design Goal:** The baseline movement for most gameplay situations - balanced between speed and stealth

### Jump

**Overview:** Navigate obstacles and reach higher areas

**Mechanics:**
- Press jump button to leap
- Can jump while walking or running
- Cannot jump while crouching
- Jump height: Standard FPS jump (enough to clear waist-high obstacles)
- Can grab ledges for climbing (optional advanced mechanic)
- Landing has slight recovery time

**Design Goal:** Enable vertical exploration and navigation without becoming a platformer

### Hide

**Overview:** Take cover behind objects to avoid detection and incoming fire

**Mechanics:**
- Press hide button near cover objects (walls, crates, vehicles)
- Player snaps to cover position
- First-person camera adjusts to show over/around cover
- Reduces player profile significantly
- Provides protection from enemy fire
- Can peek out to shoot or observe
- Enemies may lose track of player while hiding

**Cover Types:**
- Low cover: Can crouch behind, peek over
- High cover: Full protection, must peek around sides
- Partial cover: Some protection, not complete

**Design Goal:** Add tactical depth to combat - use cover strategically to survive encounters

### Crouch

**Overview:** Move silently, reduce profile, access low areas

**Mechanics:**
- Hold crouch button to lower stance
- Movement speed reduced (0.6x walk speed)
- Significantly reduced noise generation
- Can fit under low obstacles
- Can crouch behind low cover
- Can transition to prone (optional)
- More accurate shooting while crouched

**Design Goal:** Enable stealth approaches and access to hidden areas

---

## Combat Mechanics

### Attack

**Overview:** Use weapons to fight enemies

**Mechanics:**
- Primary attack: Fire equipped weapon
- Secondary attack: Melee attack with equipped weapon or fists
- Aim down sights for improved accuracy (ranged weapons)
- Recoil affects accuracy during sustained fire
- Headshots deal bonus damage
- Different weapons have different attack patterns

**Combat Flow:**
1. Detect enemy (visual or audio)
2. Choose engagement approach (stealth, aggressive, tactical)
3. Use appropriate weapon and tactics
4. Manage ammo and health
5. Adapt to enemy behavior

**Design Goal:** Combat should be challenging but fair, encouraging strategic thinking and use of the environment

### Damage System

**Player Health:**
- Health bar displayed on HUD
- Damage varies by weapon type and hit location
- Health regenerates slowly after taking no damage for 10 seconds
- Medkits can be found in the environment for instant healing

**Enemy Health:**
- Different enemy types have different health values
- Weak points (head) deal bonus damage
- Some enemies have armor that reduces damage

**Design Goal:** Clear damage feedback with meaningful consequences for player actions

---

## Interaction Mechanics

### Interact

**Overview:** Talk to NPCs, investigate clues, use objects

**Mechanics:**
- Press interact button when near interactive objects
- Interaction prompt appears when object is in range
- Different interaction types:
  - Dialogue: Talk to NPCs to gather information
  - Investigation: Examine clues and documents
  - Object Use: Open doors, activate switches, use items
  - Pickup: Collect weapons, ammo, health items

**Dialogue System:**
- Branching conversations with NPCs
- Choices can affect information received
- Some dialogue is mandatory for story progression
- Optional dialogue provides lore and world-building

**Investigation System:**
- Clues are highlighted when nearby
- Examining clues provides narrative information
- Some clues unlock new dialogue options
- Investigation progress tracked in journal

**Design Goal:** Interaction drives the narrative forward and rewards exploration

---

## Stealth Mechanics

### Detection System

**Overview:** Enemies can detect the player through sight and sound

**Mechanics:**
- Visual detection: Enemies see player within line of sight
- Audio detection: Enemies hear player actions (running, shooting)
- Detection states: Unaware → Suspicious → Alerted → Combat
- Detection meter shows current alert level
- Player can break line of sight to avoid detection

**Stealth Actions:**
- Crouch walking reduces noise
- Hiding behind cover breaks line of sight
- Silent takedowns with melee weapons
- Distractions (throwing objects) can redirect enemy attention

**Design Goal:** Provide stealth as a viable alternative to direct combat

---

## Weapon Systems

### Weapon Categories

**Throwable:**
- Petrol Bomb: Area-of-effect fire damage, creates temporary fire zones

**Explosive:**
- Grenades: Standard fragmentation grenades for area damage

**Ranged:**
- Rifle: Primary weapon, good range and damage, semi-automatic or burst fire
- Handgun: Secondary weapon, reliable backup, lower damage but higher accuracy

**Melee:**
- Knife: Silent takedowns, close-quarters combat
- Other Melee: Improvised weapons found in the slum environment

### Weapon Mechanics

**Ammunition:**
- Limited ammo for all weapons
- Ammo pickups found in the environment
- Different weapons use different ammo types
- Ammo count displayed on HUD

**Reloading:**
- Manual reload required when magazine is empty
- Reload time varies by weapon
- Can interrupt reload to switch weapons
- Reload animation plays in first-person view

**Weapon Switching:**
- Quick switch between equipped weapons
- Weapon wheel for easy access
- Can carry limited number of weapons (2-3)

**Design Goal:** Weapons offer different tactical options - no single weapon is optimal for all situations

---

## Enemy AI

### Enemy Types

**Henchmen:**
- Basic enemies, low health
- Use basic weapons (handguns, melee)
- Simple AI patterns
- Appear in groups

**Trusted Men:**
- Mid-boss enemies, higher health
- Better weapons (rifles)
- More intelligent AI
- Appear as mini-bosses in stages

**Main Boss:**
- Final enemy, highest health
- Multiple attack patterns
- Intelligent AI with special abilities
- Appears in final stage

### AI Behavior

**Patrol:**
- Enemies patrol designated areas
- Follow set routes or random paths
- React to sounds and visual cues

**Investigate:**
- When suspicious, enemies investigate the source
- Move toward last known player position
- Alert nearby enemies

**Combat:**
- Engage player when detected
- Use cover and flanking tactics
- Call for reinforcements
- Adapt to player tactics

**Design Goal:** Enemies provide meaningful challenge without being unfair - predictable but not easily exploited

---

## Progression Systems

### Stage Progression

**Linear Progression:**
- 5 stages played in sequence
- Each stage unlocks after completing the previous one
- Stage completion criteria:
  - Complete main objectives
  - Defeat required enemies
  - Reach the exit point

**Optional Objectives:**
- Side quests in each stage
- Finding all clues
- Stealth completion (no alerts)
- Time challenges

**Design Goal:** Clear progression path with optional content for completionists

### Skill Progression

**No RPG Elements:**
- Player skills do not improve over time
- Progression comes from player learning and mastery
- Weapons and items are found, not unlocked
- Focus on player skill, not character stats

**Design Goal:** Keep the experience focused on narrative and gameplay mastery

---

**Related Documents:**
- [GDD.md](GDD.md) – Master overview document
- [Art-Design.md](Art%20Design.md) – Visual and audio design
- [Technical-Plan.md](Technical%20Plan.md) – Technical implementation
- [Shaders.md](Shaders.md) – Shader technical documentation
