# DEMO DESIGN DOCUMENT: YOU MUST EAT

## 1. Purpose of the Demo
The primary purpose of this demo is to serve as a **Vertical Slice** for publisher showcases and internal player testing. It aims to prove the core gameplay loop—the tension between exposure and concealment—while demonstrating the unique "Hashing Shadows" visual identity.

**Target Audience & Expectations:**
- **Publishers/Investors:** Expectation of a polished, atmospheric experience that clearly communicates the game's unique selling points (USPs).
- **Playtesters:** Expectation of challenging but fair stealth mechanics and a compelling narrative hook.

## 2. Demo Type: Vertical Slice
This is a Vertical Slice demo, meaning it implements a small portion of the game's content but at a high level of polish across all disciplines (art, code, sound, narrative).

**Representation of Final Game:**
- **Mechanics:** Fully implements the core movement, Shadow Merge, and detection systems.
- **Narrative:** Showcases the "Broken Good" tone of Arjun's journey and the oppressive atmosphere of Dharavi.
- **Art Style:** Full implementation of the `toon_outline_postprocess.gdshader` pipeline, providing a definitive look at the final visual experience.

## 3. Scope & Content
The demo focuses on the opening sequence of **Act I: The Return**.

**Included Content:**
- **Narrative Beats:**
  - The "Day-One" introduction: Arjun drunk in the street, the confrontation with the local man, and the transition to night via sleep.
  - The "Call to Action": Waking up to the phone call.
  - The Infiltration: Navigating the narrow veins of Dharavi.
  - The Climax: Discovery of the informant's dead body.
- **Core Mechanics:**
  - **Movement:** Walk, Sprint, Crouch, and Rooftop traversal.
  - **Shadow Merge:** The ability to vanish in "Deep Black" areas.
  - **Stealth Detection:** Three-state AI (Unaware $\rightarrow$ Suspicious $\rightarrow$ Alerted).
  - **Combat:** Implementation of the **Tactical Handgun** and **Improvised Melee** for silent takedowns and desperation fighting.
  - **AI:** Basic "Scout" behavior (patrols and immediate alerting).

## 4. Gameplay Flow
**Estimated Playtime:** 15–20 minutes.

**Player Experience Sequence:**
1. **The Awakening (3 mins):** Cinematic start. Player controls Arjun in a disoriented state (drunk) in the street. Interaction with the man who kicks him. Transition to house $\rightarrow$ sleep $\rightarrow$ night wake-up.
2. **The Infiltration (7 mins):** Stealth traversal through the slum. Player must navigate from the house toward the informant's location.
3. **The Shadow Dance (5 mins):** Forced encounter with a Scout patrol. Player must use **Shadow Merge** to bypass guards and utilize rooftop navigation to avoid detection.
4. **The Confrontation (3 mins):** A short, high-tension sequence where the player can either stealthily neutralize a guard or engage in a brief, lethal firefight using the Tactical Handgun.
5. **The Reveal (2 mins):** Reaching the informant's hideout and discovering the body, ending the demo on a cliffhanger.

## 5. Technical Implementation
- **Engine:** Godot 4.x.
- **Shader Pipeline:** Implementation of the **Hashing Shadows** pipeline using the `toon_outline_postprocess.gdshader` as a full-screen effect.
- **Optimization:** 
  - Use of GLTF with Draco compression and OGG Vorbis audio to keep the demo build under **500 MB**.
  - Static batching for modular slum assets (tin sheets, debris).
- **Systems:** Save/load systems are disabled for the demo; progress is linear and resets upon restart.

## 6. Art & Audio
- **Visuals:** Strict adherence to the High-Contrast Black, White, and Red palette. Red is used exclusively for enemy alerts and critical damage.
- **Audio:** 
  - **Atmosphere:** "City Hum" background layer for urban claustrophobia.
  - **Music:** Minimalist, distorted Sarangi score that intensifies during "Alerted" states.
  - **Voice:** Naturalistic Hindi/English dialogue for the opening scene and key narrative cues.

## 7. Limitations
- **Excluded Features:** 
  - Advanced AI (Fixers and Upper Tier).
  - Full Weapon Arsenal (Rifles/Shotguns).
  - Later Acts (II-V).
  - Branching dialogue choices (limited to linear paths for the demo).
- **Placeholders:** Some background environmental props may use simplified low-poly models where they do not impact gameplay or the primary visual silhouette.

## 8. Testing & Feedback
**Testing Methodology:**
- Closed playtests with a small group of narrative-stealth fans.
- Observational recording of player movement and decision-making.

**Key Metrics:**
- **Stealth Success Rate:** Percentage of players who reach the informant without being detected.
- **Detection Tension:** Subjective feedback on the "Suspicious" state—does it create genuine anxiety?
- **Narrative Clarity:** Do players understand Arjun's motivation and the significance of the dead informant?
- **Mechanical Intuition:** How quickly do players discover and utilize the Shadow Merge?

## 9. Next Steps
- **Feedback Loop:** Use playtest data to tune the detection radius and Shadow Merge regeneration speed.
- **Expansion:** Once the Vertical Slice is validated, begin the "Horizontal" expansion into Act II: The Market.
- **Refinement:** Replace placeholder assets and expand the AI Behavior Tree to include flanking and coordination.
