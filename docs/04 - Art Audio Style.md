# Art & Audio Style

## Visual Direction: 3D Stylized Toon Art with Bold Outlines

### Core Style

- **3D stylized art** using toon shading with consistent bold outlines for all characters and props
- **Strong silhouettes** for immediate recognition in chaotic scenes
- **Flat color shading** with minimal gradients, high contrast color palette inspired by Indian streets (bright, saturated, readable)
- **Avoid realism completely** – prioritize clarity over detail
- **No pixel-art rendering or pixel shaders** – all assets are modular 3D models
- **Materials** designed for visual consistency and readability
- **Lighting** enhances shape readability, not realism; uses directional light with subtle rim lighting

### Camera System: Top-Down Angled (Megabonk / Among Us Style)

- **Camera tilt:** ~30–45 degrees for optimal gameplay visibility
- **Wide field of view** to keep multiple players visible at once
- **Supports chaos readability** – camera designed to maintain clarity during dense action
- **Player interaction awareness** – camera angle ensures players can see each other's actions and environmental reactions
- **Avoids obstruction** in dense environments through careful level design and camera positioning
- **Avoids first-person and third-person over-the-shoulder** perspectives

---

## Characters

### Core Character Design

- **Modular 3D models** with stylized low-poly to mid-poly geometry
- **Expressive toon-shaded animation** with smooth keyframe animation (not frame-by-frame pixel)
- **Strong silhouettes** maintained through bold outlines and shape language
- **Proportional stylization** – slightly exaggerated features for readability and humor
- **Flat colors** with no gradients or complex shading
- **Clean, readable shapes** that work at various scales

### Gang Identity in Characters

Each gang archetype has distinct visual identity that makes them instantly recognizable:

- **Silhouette Differences:** Each gang has unique body shape and posture
- **Outfit Identity:** Clothing reflects the gang's personality and background
- **Color Palette:** Each gang has a primary color that appears on their outfit and UI elements
- **Accessories:** Gang-specific props and items that reinforce their identity

**Example Visual Directions:**

- **IAS Aspirant:** Glasses, formal shirt (slightly rumpled), books, pens, tired posture
- **Corporate Majdur:** Laptop bag, ID card, slightly disheveled office wear, coffee cup
- **Tapori Gunda:** Tank top, sunglasses, chain, confident swagger
- **Gym Bro:** Tank top, wristbands, muscular build, always flexing
- **Tech Bro:** Hoodie, headphones, gadgets, slightly hunched posture

### Facial Expressions

- Conveyed through exaggerated but clean 3D morphs or texture changes
- Gang-specific personality in expressions (IAS Aspirant looks stressed, Tapori looks confident)
- Clear emotional states for gameplay feedback (panic, triumph, betrayal)

---

## Environment

### Core Environment Design

- **Modular 3D environments** built from reusable kits (walls, roofs, props)
- **Dense Indian streets** (gali, markets, rooftops) recreated with stylized geometry
- **Layered depth** through parallax scrolling or multi-plane camera (optional)
- **Top-down perspective** optimized for camera angle
- **Toon-shaded materials** with flat colors and outlines matching character style
- **Clean, readable environments** that don't compete with characters

### Key Elements (3D Stylized Versions)

- Rickshaws, bikes, auto-rickshaws (simplified iconic shapes with bold outlines)
- Small houses with accessible interiors (clear, simple doorways)
- Street props (crates, carts, water tanks, street vendors) as simple, bold 3D shapes
- Graffiti and wall art as stylized decals or texture work

### Gang Territory Markers

- Subtle visual cues indicating which gang controls which area
- Color-coded zones that match gang palettes
- Temporary ownership markers that appear and disappear

---

## Animation Style

### Core Animation Principles

- **Keyframe 3D animation** with snappy, exaggerated motions
- **Squash & stretch** applied within 3D deformation for impact
- **Humor-driven motion** with precise timing and cartoon physics
- **Limited animation cycles** for efficiency (walk: 4–6 keyframes, run: 6–8 keyframes, idle: 2–3 keyframes)
- **Outline consistency** – outlines remain stable during deformation
- **Flat colors** consistent across all animation frames

### Gang-Specific Animation

Each gang has unique animation flavor that reflects their personality:

- **IAS Aspirant:** Slightly stiff, tired movements, always checking watch
- **Corporate Majdur:** Rushed, stressed movements, constantly checking phone
- **Tapori Gunda:** Confident, swaggering movements, casual stance
- **Gym Bro:** Exaggerated flexing, powerful movements, always showing off
- **Tech Bro:** Hunched posture, quick tapping motions, gadget-focused

---

## UI Style

### Core UI Design

- **Toon-styled UI** with bold outlines and flat colors matching the 3D art
- **Clean, simple icons** designed as 2D vector art that complements the 3D look
- **Minimal text, more intuitive symbols** using stylized representations
- **Color coding** for quick recognition within the high-contrast palette
- **Flat design** with no gradients or complex effects
- **Consistent with game art style** for cohesive visual experience
- **No pixel fonts** – use clean, readable sans-serif fonts with slight stylization

### Gang UI Elements

- **Gang Selection Screen:** Visual preview of each gang archetype
- **Gang Indicators:** Color-coded icons above players showing their gang
- **Alliance Indicators:** Visual lines or icons showing current alliances
- **Zone Control UI:** Territory ownership markers with gang colors
- **Gang Scoreboard:** Shows gang scores alongside individual scores

---

## Audio Direction

### Voice Style

- Natural Indian slang (not forced memes)
- Short, punchy lines with comedic delivery
- Slight variations to avoid repetition
- Voice acting with mature but playful tone
- **No chip-tune voice effects** – clean, modern voice processing that matches the 3D style

### Gang-Based Voice Variations

Each gang has unique voice personality that reflects their archetype:

- **IAS Aspirant:** Stressed, slightly formal, always talking about exams or "strategy"
- **Corporate Majdur:** Burned out, corporate jargon, complaining about deadlines
- **Tapori Gunda:** Confident, street slang, casual and relaxed
- **Gym Bro:** Energetic, motivational, always talking about gains
- **Tech Bro:** Tech jargon, startup talk, slightly nerdy

### Contextual Reactions

Voice lines change based on game situation:

- **Panic:** Different panic reactions per gang (IAS Aspirant: "Mera exam kharab!", Tapori: "Arre yaar!")
- **Ego:** Taunts and boasts when winning (Corporate Majdur: "I'm crushing it!", Gym Bro: "Too easy!")
- **Trolling:** Humorous insults and reactions (Tech Bro: "Your code is buggy!")
- **Betrayal:** Dramatic reactions when alliances break

### Sound Design

- Environmental chaos (crowds, dogs, horns, street sounds) with stylized audio treatments
- Comedic timing for effects with exaggerated pitch and timing
- Clear audio cues for gameplay actions using distinct sound signatures
- Layered audio for depth while maintaining clarity
- Gang-specific sound effects for their unique abilities and interactions

---

## Technical Constraints & Guidelines

1. **Outline Rendering:** Consistent outline thickness across all assets via post-process or geometry shader
2. **Color Palette:** High-contrast, saturated colors with flat shading; avoid gradients and noisy textures
3. **Animation Budget:** Max 8 keyframes per character action, 4 for environment objects
4. **Model Complexity:** Low-poly to mid-poly counts optimized for multiplayer performance
5. **Camera:** Fixed top-down angled camera with no rotation; level design must account for visibility
6. **Asset Pipeline:** 3D models in FBX/GLTF format; materials use toon shader with outline parameter
7. **Gang Visibility:** Gang colors and silhouettes must be readable at a glance during chaos

---

## Key Principle

**Clarity over detail.**  
Chaos must be readable at all times through shape language, outlines, and strong silhouettes.  
Gang identity must be instantly recognizable—silhouette, color, and movement should tell you who someone is before you even see their face.  
Humor through clever design and exaggerated motion, not through childish exaggeration.  
**Every shape intentional.**
