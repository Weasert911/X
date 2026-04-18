# Gameplay Core Systems

*Part of the Gali Chaos Game Design Document*

**Version:** 1.2  
**Last Updated:** 2026-04-16  
**Source:** Extracted from GDD.md sections "Gameplay Mechanics" and "Multiplayer Systems"

---

## Table of Contents

1. [Gameplay Mechanics](#gameplay-mechanics)
   - [Core Loop](#core-loop)
   - [Chaos (Noise) System](#chaos-noise-system)
   - [Gang System](#gang-system)
   - [Territory / Zone Control](#territory--zone-control-light-system)
   - [Jugaad System](#jugaad-system)
   - [Desi Signal System](#desi-signal-system)
   - [Social Chaos Mechanics](#social-chaos-mechanics)
2. [Multiplayer Systems](#multiplayer-systems)
   - [Modes](#modes)
   - [Match Structure](#match-structure)
   - [Scoring](#scoring)
   - [Player Interaction Systems](#player-interaction-systems)
   - [Networking Considerations](#networking-considerations)
   - [Key Requirement](#key-requirement)
   - [Gang Visibility](#gang-visibility)

---

## Gameplay Mechanics

### Core Loop

Spawn → Join/Represent Gang → Loot → Create Chaos → Rival Gangs React → World Reacts → Control / Survive / Betray → Score

### Chaos (Noise) System

**Overview:** All player actions contribute to a shared Chaos Meter. Chaos affects everyone equally—smart gangs use this to their advantage by triggering chaos when rivals are vulnerable.

**Chaos Levels:**
- Low: Light threats (zombies, stray dogs)
- Medium: Police patrolling, angry crowds, street fights
- High: Full riots, explosions, blackout, total chaos

**Chaos Sources:**
- Weapons and jugaad items
- Explosions and environmental destruction
- Vehicles (honking, crashing)
- Signals (voice communication)
- Gang conflicts (multiple gangs fighting in same area)

**Design Goal:** Force players to balance action vs stealth. Gangs must decide when to escalate chaos and when to lay low. Chaos is a weapon—use it wisely.

### Gang System

**Overview:** Gangs are social identities that players choose before or during a match. They provide personality, visual flair, and very light gameplay flavor—NOT hard classes or ability systems.

**Gang Selection:**
- Pre-match selection in Gang vs Gang Mode
- Cosmetic identity in Loose Gang Chaos (FFA)
- Gangs are visible through outfit, silhouette, and voice lines

**What Each Gang Has:**
- Visual Identity: Distinct outfit, color palette, silhouette
- Voice Lines: Personality-driven reactions and taunts
- Minor Passive: VERY LIGHT, non-meta breaking bonus

**Example Gang Passives:**
- IAS Aspirant: Slightly better map awareness (can see chaos indicators from farther)
- Corporate Majdur: Slight stamina/endurance boost (can sprint a bit longer)
- Tapori Gunda: Slightly faster movement in narrow spaces (galis)
- Gym Bro: Slightly stronger melee knockback
- Tech Bro: Slightly faster interaction with gadgets/vehicles

**Design Goal:** Gangs are about identity and personality, not power. The chaos system must remain dominant. Passives are subtle flavor, not game-changing abilities.

### Territory / Zone Control (LIGHT SYSTEM)

**Overview:** Temporary control zones appear randomly on the map. Gangs can hold these zones for points, but zones shift and disappear—keeping things chaotic and dynamic.

**How It Works:**
- Zones appear at random locations
- Standing in a zone starts capturing it for your gang
- First gang to fully capture gets ownership
- Owned zones generate points over time
- Rival gangs can contest and steal zones

**Zone Types:**
- Street Corner: Basic control point, appears frequently
- Roof Top: High-value zone, harder to reach
- Market Area: Large zone, requires multiple players to hold

**Design Goal:** Add a light territorial element without turning the game into a domination mode. Zones create conflict points where gangs naturally meet and fight.

### Jugaad System

**Overview:** Players use improvised items instead of fixed abilities. Jugaad items are the great equalizer—any gang can use any item, and creativity beats power.

**Item Categories:**
- Throwable: Chappal, bricks, empty bottles
- Explosive: Gas cylinder, cooker, firecrackers
- Utility: Rickshaw, water tank, ladders
- Melee: Bat, danda, hockey stick

**Examples:**
- Cooker: Timed explosion—set it and run
- Gas cylinder: Knockback blast—push enemies into chaos
- Rickshaw: Mobile cover—drive it or hide behind it
- Chappal: Stun—humiliating but effective

**Design Goal:** Encourage creativity and emergent gameplay. The best jugaad user wins, not the best shooter.

### Desi Signal System

**Overview:** A radial communication system using expressive Indian voice lines. Signals are how gangs coordinate, taunt, and betray each other.

**Features:**
- 6–8 signals per gang
- Each includes audio, animation, and gameplay meaning
- Gang-specific voice variations (same signal, different personality)

**Example Signals:**
- "Bhaag!" → Danger warning
- "Dawa de!" → Heal request
- "Maaro!" → Attack call
- "Tu gaya 😏" → Troll taunt
- "Alliance?" → Propose temporary gang alliance
- "Sorry bro!" → Fake apology before betrayal

**Twist:** Signals generate noise and increase chaos. Using signals strategically is part of the game—too much talking attracts police and other threats.

### Social Chaos Mechanics

**Overview:** Social interactions are as important as combat. Gangs can help, hurt, or betray each other in countless ways.

**Mechanics:**
- Item Stealing: Snatch items from rival gang members
- Action Interruption: Stop enemies from using items or capturing zones
- Vehicle Hijacking: Steal rickshaws and other vehicles mid-use
- Fake Signaling: Pretend to help, then betray
- Gang Betrayal: Switch alliances mid-match, backstab your temporary partners
- Fake Alliances: Propose alliance, use it to get close, then attack
- Group Fights: Multiple gangs fighting in the same area—chaos compounds

**Gang-Specific Social Moves:**
Each gang has unique social interactions based on their personality:
- IAS Aspirant: Can "lecture" enemies (stuns them briefly with boredom)
- Corporate Majdur: Can "delegate" tasks (force enemy to drop item)
- Tapori Gunda: Can "intimidate" (enemies move slower nearby)
- Gym Bro: Can "flex" (distracts enemies briefly)
- Tech Bro: Can "pitch startup" (confuses enemies with jargon)

**Design Goal:** Encourage interaction beyond combat. The most memorable moments come from betrayal, not shooting.

---

## Multiplayer Systems

### Modes

**Loose Gang Chaos (formerly Free For All):**
- Every player for themselves, but temporary gang alliances are possible
- Players can form and break alliances mid-match
- Gang identity is cosmetic—choose your archetype for personality, not power
- Perfect for casual play and chaotic social dynamics

**Gang vs Gang (formerly Squad Mode):**
- Pre-selected gangs fight each other
- 2–4 players per gang
- True gang warfare—your crew vs theirs
- Gang scoring and territory control matter here

**Dynamic Alliances (New):**
- Non-forced, player-driven alliance system
- Players can propose alliances using the signal system
- Alliances are temporary—can be broken at any time
- Betrayal is a core mechanic—backstab your partners when it benefits you
- Creates emergent social gameplay: 2v2 becomes 3v1 becomes everyone for themselves

### Match Structure

- Duration: 5–8 minutes
- Objective: Survive longest, score highest, or control most territory
- Gang Scoring: Points awarded for gang actions, not just individual performance

### Scoring

**Individual Scoring:**
- Survival time
- Personal chaos contribution
- Player interactions (kills, assists, betrayals)

**Gang Scoring (New):**
- Gang Contribution: Points for actions that benefit your gang
- Zone Control: Points for holding territory zones
- Chaos Impact: Points for causing chaos that affects rival gangs
- Alliance Bonus: Temporary points for successful alliances (lost if betrayed)
- Betrayal Bonus: Points for successfully backstabbing allies (high risk, high reward)

**Winning Conditions:**
- Loose Gang Chaos: Highest individual score OR last survivor
- Gang vs Gang: Highest gang score OR last surviving gang
- Dynamic Alliances: Most points when match ends—whether through cooperation or betrayal

### Player Interaction Systems

**Cooperative:**
- Reviving gang members
- Sharing items and jugaad tools
- Coordinating attacks on rival gangs
- Holding zones together

**Competitive:**
- Stealing items from rival gangs
- Blocking paths and trapping enemies
- Triggering chaos near rival gang positions
- Betraying temporary allies
- Contesting and stealing territory zones

**Gang-Specific Interactions:**
Each gang has unique ways to interact with others:
- IAS Aspirant: Can "mentor" allies (small temporary boost)
- Corporate Majdur: Can "outsource" tasks (share item cooldowns)
- Tapori Gunda: Can "call backup" (summon AI street dogs to harass enemies)
- Gym Bro: Can "spot" allies (help them recover faster)
- Tech Bro: Can "share WiFi" (reveal nearby items to allies)

### Networking Considerations

- Server authoritative model
- Minimal physics sync
- Event-based updates for chaos system
- Gang state synchronization (who's in which gang, current alliances)
- Zone control state sync (who owns which zone)

### Key Requirement

Multiplayer must feel:
- Fast: Instant response to actions
- Responsive: No lag during chaotic moments
- Unpredictable: Anything can happen at any time
- Social: Players constantly interact, cooperate, and betray

### Gang Visibility

- Gang indicators above players (color-coded by gang)
- Alliance indicators (show who's allied with whom)
- Zone ownership markers on the map
- Chaos contribution per gang (visible in UI)

---

**Related Documents:**
- [GDD.md](../GDD.md) – Master overview document
- [Art-Design.md](Art%20Design.md) – Visual and audio design
- [Technical-Plan.md](Technical%20Plan.md) – Prototype and technical implementation
- [06 - Shaders.md](Shaders.md) – Shader technical documentation