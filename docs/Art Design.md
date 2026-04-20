# Art & Audio Design

*Part of the Game Design Document*

**Version:** 2.0  
**Last Updated:** 2026-04-19  
**Source:** Single-player FPS narrative game

---

## Table of Contents

1. [Visual Direction](#visual-direction)
2. [Camera System](#camera-system)
3. [Characters](#characters)
4. [Environment](#environment)
5. [Animation Style](#animation-style)
6. [UI Style](#ui-style)
7. [Audio Direction](#audio-direction)
8. [Technical Constraints & Guidelines](#technical-constraints--guidelines)
9. [Key Principle](#key-principle)

---

## Visual Direction

### Core Style: 3D Stylized Toon Art with Bold Outlines

**Visual Philosophy:**
- 3D stylized art using toon shading with consistent bold outlines for all characters and props
- Strong silhouettes for immediate recognition in gameplay
- Flat color shading with minimal gradients, high contrast color palette inspired by Indian slums
- Avoid realism completely – prioritize clarity and emotional impact over detail
- Materials designed for visual consistency and readability
- Lighting enhances mood and atmosphere, not realism; uses directional light with subtle rim lighting

**Color Palette:**
- Warm, earthy tones for slum environments (browns, oranges, muted yellows)
- Vibrant accent colors for key elements (red for danger, blue for clues, green for health)
- High contrast between foreground and background elements
- Consistent color coding for gameplay elements (weapons, interactables, enemies)

**Atmosphere:**
- Dense, cluttered environments that feel lived-in
- Atmospheric lighting (golden hour, harsh midday sun, dim interiors)
- Environmental storytelling through visual details (posters, graffiti, personal items)

---

## Camera System

### First-Person Perspective

**Core Camera Design:**
- First-person view for immersive gameplay experience
- Standard FPS field of view (90-100 degrees)
- Smooth camera movement with subtle head bob for natural feel
- Camera effects for gameplay feedback (recoil, damage, sprinting)

**Camera Effects:**
- **Recoil:** Weapon kick affects camera position
- **Damage:** Screen flash and slight camera shake when hit
- **Sprinting:** Subtle head bob and FOV increase
- **Crouching:** Camera lowers to reflect stance
- **Hiding:** Camera adjusts to show over/around cover
- **Death:** Dramatic camera movement and fade to black

**Cinematic Moments:**
- Third-person cutscenes for key narrative moments
- Camera angles chosen for emotional impact
- Smooth transitions between gameplay and cinematics

---

## Characters

### Player Character

**First-Person Representation:**
- Player character is not directly visible in first-person view
- Arms and hands visible during gameplay
- Weapon models and animations in first-person
- Reflections in mirrors/water show full character (optional)

**Third-Person Representation (Cutscenes):**
- 25-27 year old Indian male
- Average build, relatable appearance
- Simple, practical clothing (t-shirt, jeans)
- Expressive face for emotional moments
- Stylized toon-shaded model with outlines

### NPCs

**Core NPC Design:**
- Modular 3D models with stylized low-poly to mid-poly geometry
- Expressive toon-shaded animation with smooth keyframe animation
- Strong silhouettes maintained through bold outlines and shape language
- Proportional stylization – slightly exaggerated features for readability and emotion
- Flat colors with no gradients or complex shading

**NPC Types:**

**Slum Residents:**
- Diverse cast of characters representing slum community
- Different ages, genders, and backgrounds
- Clothing reflects their circumstances and personality
- Expressive faces for dialogue and emotional moments

**Henchmen:**
- Generic thugs with slight variations
- Intimidating but not overly threatening appearance
- Clothing suggests their role (casual but rough)
- Distinct from civilians to avoid confusion

**Trusted Men (Mini-Bosses):**
- More detailed and imposing than henchmen
- Unique visual identity for each
- Clothing and accessories suggest their importance
- More expressive faces for dialogue

**Main Boss:**
- Most detailed and imposing character
- Unique design that stands out from all others
- Clothing and accessories reflect their power and role
- Highly expressive face for dramatic moments

**Facial Expressions:**
- Conveyed through exaggerated but clean 3D morphs or texture changes
- Clear emotional states for gameplay feedback (fear, anger, determination)
- Lip-sync for dialogue
- Eyes are expressive and convey emotion

---

## Environment

### Core Environment Design

**Indian Slum Setting:**
- Modular 3D environments built from reusable kits (walls, roofs, props)
- Dense, claustrophobic layouts that feel authentic
- Layered depth through careful composition
- Toon-shaded materials with flat colors and outlines matching character style
- Clean, readable environments that don't compete with gameplay

**Stage-Specific Environments:**

**Stage 1: Awakening - The Slum Streets**
- Narrow alleys and pathways
- Small houses and shacks
- Street vendors and daily life elements
- Introduction to the slum atmosphere

**Stage 2: Investigation - Residential Areas**
- More detailed residential spaces
- Interiors of homes
- Community spaces (temples, gathering areas)
- Environmental clues and story elements

**Stage 3: The Trail - Industrial Areas**
- Abandoned warehouses and factories
- More open spaces for combat
- Evidence of trafficking operations
- Transition to more dangerous areas

**Stage 4: The Stronghold - Trafficker Base**
- Fortified compound
- Multiple buildings and courtyards
- Holding areas for children
- Intense combat environments

**Stage 5: The Final Confrontation - Boss Arena**
- Dramatic final location
- Vertical elements and cover
- Environmental hazards
- Cinematic setting for the climax

**Key Environmental Elements:**
- Rickshaws, bikes, and other vehicles
- Small houses with accessible interiors
- Street props (crates, carts, water tanks, street vendors)
- Graffiti and wall art as environmental storytelling
- Lighting that creates mood and atmosphere
- Weather effects (rain, dust, heat haze)

**Environmental Storytelling:**
- Clues and documents scattered throughout
- Personal items that tell stories
- Visual evidence of the trafficking operation
- Environmental changes as the story progresses

---

## Animation Style

### Core Animation Principles

**First-Person Animations:**
- Smooth, responsive weapon animations
- Idle animations for weapons
- Reload animations with clear visual feedback
- Melee attack animations with impact
- Transition animations between states

**Third-Person Animations (NPCs):**
- Keyframe 3D animation with snappy, exaggerated motions
- Squash & stretch applied within 3D deformation for impact
- Emotion-driven animation for dramatic moments
- Limited animation cycles for efficiency
- Outline consistency – outlines remain stable during deformation
- Flat colors consistent across all animation frames

**Animation Categories:**

**Movement:**
- Walk, run, crouch animations
- Idle animations with personality
- Transition animations between states
- Jump and landing animations

**Combat:**
- Attack animations for different weapons
- Hit reactions and death animations
- Cover and peek animations
- Reload and weapon switch animations

**Dialogue:**
- Lip-sync for all dialogue
- Expressive facial animations
- Gesture animations that complement dialogue
- Idle animations during dialogue

**Cinematic:**
- Dramatic animations for key moments
- Emotional expressions for story beats
- Choreographed action sequences

---

## UI Style

### Core UI Design

**Toon-Styled UI:**
- Toon-styled UI with bold outlines and flat colors matching the 3D art
- Clean, simple icons designed as 2D vector art
- Minimal text, more intuitive symbols
- Color coding for quick recognition
- Flat design with no gradients or complex effects
- Consistent with game art style for cohesive visual experience
- Clean, readable sans-serif fonts

**HUD Elements:**

**Health Display:**
- Health bar with clear visual feedback
- Damage flash on screen edges
- Low health warning (red pulse)

**Ammo Display:**
- Current ammo count
- Reserve ammo count
- Weapon icon
- Reload indicator

**Stamina Display:**
- Stamina bar for sprinting
- Visual feedback when stamina is low

**Interaction Prompts:**
- Context-sensitive prompts
- Clear visual indicators for interactive objects
- Button prompts for actions

**Objective Display:**
- Current objective displayed
- Progress indicators for multi-step objectives
- Optional objectives listed separately

**Minimap (Optional):**
- Top-down view of immediate area
- Player position
- Objective markers
- Enemy positions (when detected)

**Menu UI:**

**Main Menu:**
- Clean, simple design
- Clear navigation
- Background shows game environment

**Pause Menu:**
- Resume, settings, quit options
- Clear visual hierarchy

**Settings Menu:**
- Graphics, audio, controls options
- Clear labels and descriptions

---

## Audio Direction

### Voice Style

**Natural Indian Dialogue:**
- Natural Indian dialogue (Hindi/English mix or regional language)
- Emotional delivery that matches the story
- Clear pronunciation for subtitles
- Varied voices for different characters
- No forced memes or caricatures

**Character Voices:**

**Player Character:**
- Relatable, everyman voice
- Emotional range from confusion to determination
- Internal monologue for key moments

**Slum Residents:**
- Diverse voices reflecting different backgrounds
- Emotional delivery for story moments
- Casual, natural dialogue

**Henchmen:**
- Rough, intimidating voices
- Combat shouts and reactions
- Minimal dialogue

**Trusted Men:**
- More refined but still threatening
- Dialogue reveals story information
- Confident, arrogant tone

**Main Boss:**
- Distinctive, memorable voice
- Powerful, commanding presence
- Emotional range for dramatic moments

**Contextual Reactions:**
Voice lines change based on game situation:
- Combat: Shouts, warnings, reactions
- Dialogue: Story-relevant conversations
- Discovery: Reactions to clues and revelations
- Climax: Emotional delivery for key moments

### Sound Design

**Environmental Audio:**
- Authentic slum atmosphere (crowds, animals, street sounds)
- Layered audio for depth and immersion
- Dynamic audio that responds to gameplay
- Weather effects (rain, wind, heat)

**Combat Audio:**
- Clear, impactful weapon sounds
- Distinct sounds for different weapons
- Enemy reactions and death sounds
- Environmental destruction sounds

**UI Audio:**
- Clear feedback sounds for interactions
- Subtle sounds for menu navigation
- Warning sounds for low health/ammo

**Music:**
- Emotional score that enhances narrative moments
- Dynamic music that responds to gameplay
- Cultural elements in the music (Indian instruments, scales)
- Themes for different characters and locations

**Audio Technical:**
- High-quality audio within size constraints
- Compressed audio formats for optimization
- Spatial audio for immersion
- Clear audio cues for gameplay feedback

---

## Technical Constraints & Guidelines

1. **Outline Rendering:** Consistent outline thickness across all assets via post-process or geometry shader
2. **Color Palette:** High-contrast, saturated colors with flat shading; avoid gradients and noisy textures
3. **Animation Budget:** Max 8 keyframes per character action, 4 for environment objects
4. **Model Complexity:** Low-poly to mid-poly counts optimized for performance
5. **Camera:** First-person perspective with smooth movement and effects
6. **Asset Pipeline:** 3D models in FBX/GLTF format; materials use toon shader with outline parameter
7. **Size Optimization:** Compressed textures, optimized audio, efficient asset reuse
8. **Performance:** 60 FPS on mid-range hardware

---

## Key Principle

**Clarity and emotional impact over detail.**
The art style must support the narrative experience - environments should tell stories, characters should convey emotion, and the visual style should enhance the player's connection to the story.
The toon style allows for expressive characters and environments without the uncanny valley of realism.
**Every visual element serves the story.**

---

**Related Documents:**
- [GDD.md](GDD.md) – Master overview document
- [Gameplay-Core.md](Gameplay%20Core.md) – Core gameplay mechanics
- [Technical-Plan.md](Technical%20Plan.md) – Technical implementation
- [Shaders.md](Shaders.md) – Shader technical documentation
