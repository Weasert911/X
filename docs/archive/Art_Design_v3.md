# Art & Audio Design: YOU MUST EAT

*Part of the Game Design Document*

**Version:** 3.0  
**Last Updated:** 2026-04-26  
**Source:** Single-player Narrative FPS

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

### Core Style: High-Contrast Black, White, and Red (Hashing Shadows)

**Visual Philosophy:**
- **Hashing Shadows Aesthetic:** The world is rendered as a raw, brutal sketch. Deep blacks, stark whites, and jarring reds.
- **Abstraction over Realism:** Avoid realistic textures. Use high-contrast shading to create a mood of oppressive systemic horror.
- **The Color Red:** Used sparingly and purposefully—only for danger, blood, and critical narrative elements.
- **High Contrast:** Strong silhouettes for immediate recognition; characters and props bleed into the shadows or pop against stark white backgrounds.
- **Lighting:** Lighting is used as a gameplay mechanic. Light represents exposure and danger; shadows represent safety and the "merge" mechanic.

**Color Palette:**
- **Deep Black:** Shadows, danger, the unknown, and the "Merging" state.
- **Stark White:** Harsh lights, exposed areas, and hope/innocence.
- **Blood Red:** Critical warnings, enemy indicators, and trauma.
- **Grey/Tones:** Used minimally for environmental depth.

**Atmosphere:**
- Dense, claustrophobic, and oppressive.
- The world should feel like a graphite drawing coming to life, with "hashing" lines creating texture and movement.
- Environmental storytelling through high-contrast visual cues (e.g., a single red toy in a white room).

---

## Camera System

### First-Person Perspective

**Core Camera Design:**
- First-person view for visceral immersion.
- Standard FPS field of view (90-100 degrees).
- Subtle head bob to simulate the fatigue and tension of the protagonist.
- Camera effects for feedback: recoil, screen-shake on impact, and FOV shifts during sprinting.

**Camera Effects:**
- **Shadow Blend:** Subtle visual distortion when Arjun merges with shadows.
- **Damage:** Vignette of red pulsing on the screen edges when injured.
- **Crouching/Hiding:** Camera adjusts to provide a peek-around-corner view.
- **Death:** A sharp fade to black, simulating the "silence" of the city.

**Cinematic Moments:**
- Limited third-person cutscenes for key narrative beats.
- High-contrast, stylized angles focusing on emotion and scale.

---

## Characters

### Player Character: Arjun Kale

**First-Person Representation:**
- Hands and arms visible, reflecting the grit of the environment (worn clothing, scarred hands).
- Weapon models integrate seamlessly with the black-white-red aesthetic.

**Third-Person Representation (Cutscenes):**
- 34-year-old Indian male.
- Ex-Crime Branch detective: Tired eyes, stubble, a build that was once athletic but is now worn down by alcoholism and grief.
- Clothing: Simple, practical, dark-toned clothing that blends into the shadows.
- Rendered in the Hashing Shadows style—sharp outlines and high-contrast shading.

### NPCs

**Core NPC Design:**
- Stylized models with strong silhouettes.
- Outlines are a key part of the visual identity, ensuring characters are readable against complex backgrounds.
- Flat shading with high contrast; no complex gradients.

**NPC Types:**

**Slum Residents:**
- Diverse, exhausted appearances reflecting a community in survival mode.
- Clothing is tattered and blends into the grey/white of the environment.

**The Scouts & Fixers (Syndicate):**
- Menacing silhouettes.
- Often seen partially obscured by shadows to maintain an air of mystery.
- Distinctive "Caterer" markers (e.g., a specific red accessory or symbol) to identify them as enemies.

**The Upper Tier (Bosses):**
- Imposing, refined, and stark.
- Their visual design contrasts the slum; they wear clean, sharp lines that stand out against the raw sketch style of the world.

---

## Environment

### Core Environment Design

**Indian Slum Setting (Dharavi):**
- Modular 3D environments utilizing the Hashing Shadows shader.
- Dense, claustrophobic layouts: narrow alleys, overlapping tin roofs, and decaying concrete.
- Environments are designed around the concept of "The Nest"—holding cells and hideouts that feel like traps.

**Stage-Specific Environments:**

**Act 1: The Return - The Veins**
- Narrow, winding alleyways and rain-slicked pavements.
- Focus on verticality (tin rooftops) and deep shadows.

**Act 2: The Scout - The Market**
- Crowded, chaotic spaces with stark white lighting and deep black gaps.
- Contrast between the bustle of the market and the sterile silence of the godown.

**Act 3: The Safe House - The Textile Unit**
- Industrial decay. Large, empty spaces with rhythmic patterns of machinery.
- Heavy use of red lighting in holding areas.

**Act 4: The Descent - The Contrast**
- Transition from the slum to the luxury of Mumbai's elite.
- The visual style shifts from "raw sketch" to "sharp, sterile lines," though still maintaining the black-white-red palette.

**Act 5: The Feast - The Final Nest**
- A subterranean complex beneath a luxury hotel.
- A mixture of extreme opulence and brutalist concrete.
- High-contrast lighting used to create a sense of disorientation and dread.

---

## Animation Style

### Core Animation Principles

**First-Person Animations:**
- Responsive, tactical weapon handling.
- Heavy, weighted movements reflecting Arjun's physical and mental state.
- Impactful melee animations with visual "hit-stops" to emphasize power.

**Third-Person Animations (NPCs):**
- Snappy, purposeful motions.
- Use of "staccato" movement for enemies to make them feel unpredictable and predatory.
- Emotion-driven animations for civilians, conveying fear and complicity.

---

## UI Style

### Core UI Design

**The "Silent" UI:**
- Minimalist HUD to prevent breaking immersion.
- Palette: Strictly Black, White, and Red.
- Flat, 2D vector icons with bold outlines.

**HUD Elements:**
- **Health:** A simple, stark white bar that pulses red as it depletes.
- **Ammo:** Minimalist numbers in the corner; turns red when nearly empty.
- **Shadow Meter:** A visual indicator of Arjun's "Merge" capacity.
- **Interaction:** A small, white circular prompt that appears over interactable objects.

---

## Audio Direction

### Voice Style

**Naturalism and Tension:**
- Dialogue is a mix of Hindi and English, delivered in a natural, unforced manner.
- Focus on the "weight" of words; long silences are as important as the dialogue.

**Character Voices:**
- **Arjun:** A gravelly, tired voice. Monologues are delivered as tired reflections rather than exposition.
- **The Syndicate:** Calm, predatory, and detached. They speak with the confidence of those who own the city.

### Sound Design

**Environmental Audio:**
- The "City Hum": A constant, low-frequency background noise of Mumbai.
- Dynamic audio that shifts from the loud chaos of the market to the ringing silence of a safe house.

**Combat Audio:**
- Heavy, impactful gunshots.
- The sound of metal on metal, footsteps on tin, and the breath of the protagonist.

**Music:**
- Minimalist, tension-driven score.
- Use of Indian classical instruments (e.g., Sarangi) distorted to create a sense of unease and longing.
- Silence is used as a musical tool to heighten tension.

---

## Technical Constraints & Guidelines

1. **Hashing Shader:** All assets must be compatible with the high-contrast post-process shader.
2. **Palette Lock:** No colors allowed other than Black, White, and Red (and minimal greys).
3. **Silhouette Priority:** Character and prop silhouettes must be readable from a distance.
4. **Animation Budget:** Prioritize responsive transitions over complex cycles.
5. **Performance:** Optimized for 60 FPS to ensure the "Shadow Merge" mechanic feels seamless.

---

## Key Principle

**The horror is in the silence.**
Every visual and audio element must serve the theme of systemic complicity. The art style should not just be a "look," but a representation of how Arjun sees the world: a brutal, high-contrast place where you are either the hunter or the meal.
