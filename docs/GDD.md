# Gali Chaos - Game Design Document

## Version
1.2 - Updated for Gang-Based Gameplay and Identity

## Table of Contents
1. [Overview](#overview)
2. [Core Pillars](#core-pillars)
3. [Gameplay Mechanics](#gameplay-mechanics)
4. [Multiplayer Systems](#multiplayer-systems)
5. [Art & Audio Style](#art--audio-style)
6. [Gang Archetypes](#gang-archetypes)
7. [Prototype Plan](#prototype-plan)
8. [Technical Considerations](#technical-considerations)

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

## Art & Audio Style

### Visual Direction: 3D Stylized Toon Art with Bold Outlines

**Core Style:**
- 3D stylized art using toon shading with consistent bold outlines for all characters and props
- Strong silhouettes for immediate recognition in chaotic scenes
- Flat color shading with minimal gradients, high contrast color palette inspired by Indian streets (bright, saturated, readable)
- Avoid realism completely – prioritize clarity over detail
- No pixel-art rendering or pixel shaders – all assets are modular 3D models
- Materials designed for visual consistency and readability
- Lighting enhances shape readability, not realism; uses directional light with subtle rim lighting

### Camera System: Top-Down Angled (Megabonk / Among Us Style)

- Camera tilt: ~30–45 degrees for optimal gameplay visibility
- Wide field of view to keep multiple players visible at once
- Supports chaos readability – camera designed to maintain clarity during dense action
- Player interaction awareness – camera angle ensures players can see each other's actions and environmental reactions
- Avoids obstruction in dense environments through careful level design and camera positioning
- Avoids first-person and third-person over-the-shoulder perspectives

### Characters

**Core Character Design:**
- Modular 3D models with stylized low-poly to mid-poly geometry
- Expressive toon-shaded animation with smooth keyframe animation (not frame-by-frame pixel)
- Strong silhouettes maintained through bold outlines and shape language
- Proportional stylization – slightly exaggerated features for readability and humor
- Flat colors with no gradients or complex shading
- Clean, readable shapes that work at various scales

**Gang Identity in Characters:**
Each gang archetype has distinct visual identity that makes them instantly recognizable:
- Silhouette Differences: Each gang has unique body shape and posture
- Outfit Identity: Clothing reflects the gang's personality and background
- Color Palette: Each gang has a primary color that appears on their outfit and UI elements
- Accessories: Gang-specific props and items that reinforce their identity

**Example Visual Directions:**
- IAS Aspirant: Glasses, formal shirt (slightly rumpled), books, pens, tired posture
- Corporate Majdur: Laptop bag, ID card, slightly disheveled office wear, coffee cup
- Tapori Gunda: Tank top, sunglasses, chain, confident swagger
- Gym Bro: Tank top, wristbands, muscular build, always flexing
- Tech Bro: Hoodie, headphones, gadgets, slightly hunched posture

**Facial Expressions:**
- Conveyed through exaggerated but clean 3D morphs or texture changes
- Gang-specific personality in expressions (IAS Aspirant looks stressed, Tapori looks confident)
- Clear emotional states for gameplay feedback (panic, triumph, betrayal)

### Environment

**Core Environment Design:**
- Modular 3D environments built from reusable kits (walls, roofs, props)
- Dense Indian streets (gali, markets, rooftops) recreated with stylized geometry
- Layered depth through parallax scrolling or multi-plane camera (optional)
- Top-down perspective optimized for camera angle
- Toon-shaded materials with flat colors and outlines matching character style
- Clean, readable environments that don't compete with characters

**Key Elements (3D Stylized Versions):**
- Rickshaws, bikes, auto-rickshaws (simplified iconic shapes with bold outlines)
- Small houses with accessible interiors (clear, simple doorways)
- Street props (crates, carts, water tanks, street vendors) as simple, bold 3D shapes
- Graffiti and wall art as stylized decals or texture work

**Gang Territory Markers:**
- Subtle visual cues indicating which gang controls which area
- Color-coded zones that match gang palettes
- Temporary ownership markers that appear and disappear

### Animation Style

**Core Animation Principles:**
- Keyframe 3D animation with snappy, exaggerated motions
- Squash & stretch applied within 3D deformation for impact
- Humor-driven motion with precise timing and cartoon physics
- Limited animation cycles for efficiency (walk: 4–6 keyframes, run: 6–8 keyframes, idle: 2–3 keyframes)
- Outline consistency – outlines remain stable during deformation
- Flat colors consistent across all animation frames

**Gang-Specific Animation:**
Each gang has unique animation flavor that reflects their personality:
- IAS Aspirant: Slightly stiff, tired movements, always checking watch
- Corporate Majdur: Rushed, stressed movements, constantly checking phone
- Tapori Gunda: Confident, swaggering movements, casual stance
- Gym Bro: Exaggerated flexing, powerful movements, always showing off
- Tech Bro: Hunched posture, quick tapping motions, gadget-focused

### UI Style

**Core UI Design:**
- Toon-styled UI with bold outlines and flat colors matching the 3D art
- Clean, simple icons designed as 2D vector art that complements the 3D look
- Minimal text, more intuitive symbols using stylized representations
- Color coding for quick recognition within the high-contrast palette
- Flat design with no gradients or complex effects
- Consistent with game art style for cohesive visual experience
- No pixel fonts – use clean, readable sans-serif fonts with slight stylization

**Gang UI Elements:**
- Gang Selection Screen: Visual preview of each gang archetype
- Gang Indicators: Color-coded icons above players showing their gang
- Alliance Indicators: Visual lines or icons showing current alliances
- Zone Control UI: Territory ownership markers with gang colors
- Gang Scoreboard: Shows gang scores alongside individual scores

### Audio Direction

**Voice Style:**
- Natural Indian slang (not forced memes)
- Short, punchy lines with comedic delivery
- Slight variations to avoid repetition
- Voice acting with mature but playful tone
- No chip-tune voice effects – clean, modern voice processing that matches the 3D style

**Gang-Based Voice Variations:**
Each gang has unique voice personality that reflects their archetype:
- IAS Aspirant: Stressed, slightly formal, always talking about exams or "strategy"
- Corporate Majdur: Burned out, corporate jargon, complaining about deadlines
- Tapori Gunda: Confident, street slang, casual and relaxed
- Gym Bro: Energetic, motivational, always talking about gains
- Tech Bro: Tech jargon, startup talk, slightly nerdy

**Contextual Reactions:**
Voice lines change based on game situation:
- Panic: Different panic reactions per gang (IAS Aspirant: "Mera exam kharab!", Tapori: "Arre yaar!")
- Ego: Taunts and boasts when winning (Corporate Majdur: "I'm crushing it!", Gym Bro: "Too easy!")
- Trolling: Humorous insults and reactions (Tech Bro: "Your code is buggy!")
- Betrayal: Dramatic reactions when alliances break

**Sound Design:**
- Environmental chaos (crowds, dogs, horns, street sounds) with stylized audio treatments
- Comedic timing for effects with exaggerated pitch and timing
- Clear audio cues for gameplay actions using distinct sound signatures
- Layered audio for depth while maintaining clarity
- Gang-specific sound effects for their unique abilities and interactions

### Technical Constraints & Guidelines

1. Outline Rendering: Consistent outline thickness across all assets via post-process or geometry shader
2. Color Palette: High-contrast, saturated colors with flat shading; avoid gradients and noisy textures
3. Animation Budget: Max 8 keyframes per character action, 4 for environment objects
4. Model Complexity: Low-poly to mid-poly counts optimized for multiplayer performance
5. Camera: Fixed top-down angled camera with no rotation; level design must account for visibility
6. Asset Pipeline: 3D models in FBX/GLTF format; materials use toon shader with outline parameter
7. Gang Visibility: Gang colors and silhouettes must be readable at a glance during chaos

### Key Principle

**Clarity over detail.**
Chaos must be readable at all times through shape language, outlines, and strong silhouettes.
Gang identity must be instantly recognizable—silhouette, color, and movement should tell you who someone is before you even see their face.
Humor through clever design and exaggerated motion, not through childish exaggeration.
**Every shape intentional.**

---

## Gang Archetypes

### Overview

Gangs in Gali Chaos are social identities that players choose before or during a match. Each gang represents a grounded Indian urban archetype—people you might actually meet in any Indian city. Gangs provide personality, visual flair, and very light gameplay flavor. They are NOT hard classes or ability systems.

### Design Principles

- Identity First: Gangs are about who you are, not what you can do
- Light Passives: Minor bonuses that add flavor without breaking balance
- Personality Driven: Voice lines, animations, and visual style reflect the archetype
- Grounded Reality: Based on real Indian urban life, not fantasy
- Equal Opportunity: Any gang can win using jugaad and chaos

### Initial Gang Archetypes

#### 1. IAS Aspirant

**Description:** Failed UPSC dreamer who's still "studying" but actually spends all time causing chaos in the gali. Always has a strategy (that never works).

**Personality:** Stressed, slightly formal, always talking about exams or "strategy". Overthinks everything, panics under pressure. Lectures others on "proper conduct" while breaking all rules. Secretly enjoys the chaos more than studying.

**Visual Identity:** Glasses (slightly crooked), rumpled formal shirt (half-tucked), always carrying books or notes, tired posture, constantly checking watch. Color palette: Muted blues and grays (stressed academic vibe).

**Example Voice Lines:**
- "Mera exam kharab ho gaya!" (My exam is ruined!)
- "Strategic retreat!" (Running away)
- "According to my analysis..." (Before doing something stupid)
- "Beta, thoda dhyan se" (Be careful, kid)
- "This is not in the syllabus!" (When chaos happens)

**Minor Passive:** Map Awareness – Can see chaos indicators and zone markers from slightly farther away (10-15% increase in vision range for UI elements).

#### 2. Corporate Majdur

**Description:** Burnout corporate slave who escaped the office but brought the stress along. Uses office supplies as weapons and complains about deadlines while fighting.

**Personality:** Burned out, speaks in corporate jargon. Always rushing, stressed about "deliverables". Treats chaos like a "project" that needs "management". Secretly relieved to be away from the office.

**Visual Identity:** Laptop bag (always on shoulder), ID card hanging around neck, slightly disheveled office wear (tie loose, shirt untucked), coffee cup in hand (or nearby). Color palette: Corporate grays with accent colors (blue, orange).

**Example Voice Lines:**
- "I'm crushing it!" (After doing something mediocre)
- "Let's circle back on this" (Retreating)
- "Can we schedule a sync?" (Asking for alliance)
- "This is not in my KPI!" (When things go wrong)
- "Deadline approaching!" (Panic mode)

**Minor Passive:** Stamina Boost – Can sprint for slightly longer duration (10-15% increase in sprint stamina).

#### 3. Tapori Gunda

**Description:** Street-smart local who knows every shortcut in the gali. Born and raised in chaos, treats it like just another Tuesday.

**Personality:** Confident, relaxed, speaks in casual street slang. Knows everyone and everything happening in the gali. Treats fights like friendly banter. Never takes anything too seriously.

**Visual Identity:** Tank top or casual shirt, sunglasses (even indoors), gold chain (fake but shiny), confident swagger in movement. Color palette: Bright oranges and yellows (energetic street vibe).

**Example Voice Lines:**
- "Arre yaar, chill kar" (Relax, bro)
- "Aaja, party karte hain" (Let's party)
- "Tu jaanta nahi main kaun hoon" (You don't know who I am)
- "Gali ka king hoon main" (I'm the king of this street)
- "Maza aa gaya!" (That was fun!)

**Minor Passive:** Narrow Space Bonus – Moves slightly faster in narrow spaces and galis (10-15% speed boost in tight areas).

#### 4. Gym Bro

**Description:** Fitness-obsessed who treats the gali like their personal gym. Uses gym equipment as weapons and constantly talks about "gains."

**Personality:** Energetic, motivational, always flexing. Treats chaos like a workout. Gives unsolicited fitness advice. Competitively friendly—wants to win but wants you to "do your best".

**Visual Identity:** Tank top (showing muscles), wristbands and headband, always in a flexing pose, muscular build (exaggerated for toon style). Color palette: Bright reds and blacks (energetic gym vibe).

**Example Voice Lines:**
- "Light weight, baby!" (Picking up anything)
- "No pain, no gain!" (Getting hurt)
- "Let's get those gains!" (Attacking)
- "Protein shake time!" (After surviving)
- "You can do it, bro!" (Encouraging allies)

**Minor Passive:** Melee Knockback – Slightly stronger melee attacks (10-15% increase in knockback force).

#### 5. Tech Bro

**Description:** Startup founder wannabe who treats the gali like a "disruptive market opportunity." Uses gadgets and speaks in tech jargon nobody understands.

**Personality:** Nerdy but confident, speaks in startup buzzwords. Treats chaos like a "pivot opportunity". Always pitching ideas (even mid-fight). Thinks they're smarter than everyone (usually wrong).

**Visual Identity:** Hoodie (startup uniform), headphones around neck, always holding some gadget, slightly hunched posture (from too much coding). Color palette: Tech blues and purples (modern startup vibe).

**Example Voice Lines:**
- "Let's disrupt this market!" (Entering a fight)
- "Pivoting to Plan B!" (Running away)
- "Your code is buggy!" (Insulting enemies)
- "Scaling up!" (Getting more items)
- "This is a feature, not a bug!" (When things go wrong)

**Minor Passive:** Gadget Speed – Interacts slightly faster with gadgets, vehicles, and utility items (10-15% faster interaction speed).

### Gang Selection Flow

**Pre-Match Selection (Gang vs Gang Mode):**
1. Players choose their gang archetype
2. Gangs are balanced (equal numbers per gang if possible)
3. Visual preview shows outfit and passive
4. Voice line preview plays

**Cosmetic Selection (Loose Gang Chaos Mode):**
1. Players choose gang for personality only
2. No balancing required
3. Gang identity is purely cosmetic
4. Passives disabled or equalized

### Future Gang Archetypes (Post-MVP)

Potential additions after MVP:
- Bhaiyya: UP migrant who treats everyone like family
- Aunty Ji: Neighborhood gossip who knows everyone's secrets
- College Student: Always broke, always looking for free food
- Auto Driver: Knows every shortcut, treats passengers like family
- Chai Wala: Serves chai and gossip in equal measure

### Balance Notes

- All passives are intentionally light (10-15% modifiers)
- Chaos system remains dominant over gang abilities
- Jugaad items are the great equalizer—any gang can use any item
- Skill and creativity matter more than gang choice
- Gangs are about identity and personality, not power

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

- **2026-04-16:** Updated for gang-based gameplay and identity, added Gang Archetypes section
- **2026-04-16:** Updated visual style to 3D stylized toon art with top-down angled camera
- **2026-04-12:** Updated visual style to 32x32 pixel art, consolidated GDD
- **Previous:** Initial documentation split across multiple files
