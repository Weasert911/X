# Multiplayer Systems

## Modes

### Loose Gang Chaos (formerly Free For All)

- Every player for themselves, but temporary gang alliances are possible
- Players can form and break alliances mid-match
- Gang identity is cosmetic—choose your archetype for personality, not power
- Perfect for casual play and chaotic social dynamics

### Gang vs Gang (formerly Squad Mode)

- Pre-selected gangs fight each other
- 2–4 players per gang
- True gang warfare—your crew vs theirs
- Gang scoring and territory control matter here

### Dynamic Alliances (New)

- Non-forced, player-driven alliance system
- Players can propose alliances using the signal system
- Alliances are temporary—can be broken at any time
- Betrayal is a core mechanic—backstab your partners when it benefits you
- Creates emergent social gameplay: 2v2 becomes 3v1 becomes everyone for themselves

---

## Match Structure

- **Duration:** 5–8 minutes
- **Objective:** Survive longest, score highest, or control most territory
- **Gang Scoring:** Points awarded for gang actions, not just individual performance

---

## Scoring

### Individual Scoring

- Survival time
- Personal chaos contribution
- Player interactions (kills, assists, betrayals)

### Gang Scoring (New)

- **Gang Contribution:** Points for actions that benefit your gang
- **Zone Control:** Points for holding territory zones
- **Chaos Impact:** Points for causing chaos that affects rival gangs
- **Alliance Bonus:** Temporary points for successful alliances (lost if betrayed)
- **Betrayal Bonus:** Points for successfully backstabbing allies (high risk, high reward)

### Winning Conditions

- **Loose Gang Chaos:** Highest individual score OR last survivor
- **Gang vs Gang:** Highest gang score OR last surviving gang
- **Dynamic Alliances:** Most points when match ends—whether through cooperation or betrayal

---

## Player Interaction Systems

### Cooperative

- Reviving gang members
- Sharing items and jugaad tools
- Coordinating attacks on rival gangs
- Holding zones together

### Competitive

- Stealing items from rival gangs
- Blocking paths and trapping enemies
- Triggering chaos near rival gang positions
- Betraying temporary allies
- Contesting and stealing territory zones

### Gang-Specific Interactions

Each gang has unique ways to interact with others:
- **IAS Aspirant:** Can "mentor" allies (small temporary boost)
- **Corporate Majdur:** Can "outsource" tasks (share item cooldowns)
- **Tapori Gunda:** Can "call backup" (summon AI street dogs to harass enemies)
- **Gym Bro:** Can "spot" allies (help them recover faster)
- **Tech Bro:** Can "share WiFi" (reveal nearby items to allies)

---

## Networking Considerations

- Server authoritative model
- Minimal physics sync
- Event-based updates for chaos system
- Gang state synchronization (who's in which gang, current alliances)
- Zone control state sync (who owns which zone)

---

## Key Requirement

Multiplayer must feel:
- **Fast:** Instant response to actions
- **Responsive:** No lag during chaotic moments
- **Unpredictable:** Anything can happen at any time
- **Social:** Players constantly interact, cooperate, and betray

---

## Gang Visibility

- Gang indicators above players (color-coded by gang)
- Alliance indicators (show who's allied with whom)
- Zone ownership markers on the map
- Chaos contribution per gang (visible in UI)
