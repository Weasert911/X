# Art & Audio Design

*Part of the Gali Chaos Game Design Document*

**Version:** 1.2  
**Last Updated:** 2026-04-16  
**Source:** Extracted from GDD.md sections "Art & Audio Style" and "Gang Archetypes"

---

## Table of Contents

1. [Art & Audio Style](#art--audio-style)
   - [Visual Direction](#visual-direction-3d-stylized-toon-art-with-bold-outlines)
   - [Camera System](#camera-system-top-down-angled-megabonk--among-us-style)
   - [Characters](#characters)
   - [Environment](#environment)
   - [Animation Style](#animation-style)
   - [UI Style](#ui-style)
   - [Audio Direction](#audio-direction)
   - [Technical Constraints & Guidelines](#technical-constraints--guidelines)
   - [Key Principle](#key-principle)
2. [Gang Archetypes](#gang-archetypes)
   - [Overview](#overview)
   - [Design Principles](#design-principles)
   - [Initial Gang Archetypes](#initial-gang-archetypes)
   - [Gang Selection Flow](#gang-selection-flow)
   - [Future Gang Archetypes (Post-MVP)](#future-gang-archetypes-post-mvp)
   - [Balance Notes](#balance-notes)

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

**Related Documents:**
- [GDD.md](../GDD.md) – Master overview document
- [Gameplay-Core.md](Gameplay%20Core.md) – Core gameplay mechanics and multiplayer systems
- [Technical-Plan.md](Technical%20Plan.md) – Prototype and technical implementation
- [06 - Shaders.md](Shaders.md) – Shader technical documentation