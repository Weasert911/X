# Weapon System Documentation (Godot FPS)

## Version
1.0 – Modular, Scalable Weapon Architecture

---

## 🔥 Core Architecture

The weapon system is built on **three distinct layers**. This separation is mandatory for scalability, maintainability, and clean integration with save/load systems.

### 1. WeaponData (Resource) → CONFIG
- Pure data container (`.tres`)
- Defines weapon stats and identity

### 2. Weapon (Scene + Script) → BEHAVIOR
- Handles gameplay logic and visuals

### 3. WeaponManager → CONTROL + STATE
- Central controller for weapon switching and persistence

---

## 🧠 System Responsibilities

### ✅ WeaponData (Resource)

**Purpose:** Store static weapon configuration

**Contains:**
- `gun_id`
- `weapon_type` (ENUM)
- `mag_size`
- `max_mags`
- `reload_time`
- `fire_rate`
- `recoil`
- `spread`
- `damage`

**Notes:**
- No logic allowed
- Each weapon = one resource
- Acts as the **Gun ID system**

---

### 🔫 Weapon.gd (Weapon Scene Script)

**Purpose:** Execute weapon behavior and visuals

**Responsibilities:**
- Raycast-based shooting
- Playing animations (shoot, reload, draw)
- Applying recoil and spread
- Managing runtime ammo state:
  - `ammo_in_mag`
  - `mags_left`

**Exclusions:**
- No saving logic
- No weapon switching
- No global state management

---

### 🎮 WeaponManager.gd

**Purpose:** Central weapon controller

**Responsibilities:**
- Track current and previous weapons
- Handle equip/unequip logic
- Manage weapon switching
- Handle reload requests
- Communicate with GameManager (signals)

**Core Data:**
```gdscript
var current_weapon: Weapon
var previous_weapon: Weapon
var inventory = {} # gun_id -> weapon instance
```

---

## ⚙️ Feature Distribution

| Feature            | Responsible System  |
|------------------|--------------------|
| Raycast shooting | Weapon             |
| Ammo in mag      | Weapon             |
| Mags left        | Weapon             |
| Reload speed     | WeaponData         |
| Recoil           | WeaponData + Weapon|
| Spread           | WeaponData + Weapon|
| Weapon type enum | WeaponData         |
| Gun ID system    | WeaponData         |
| Equip tracking   | WeaponManager      |

---

## 🔁 Signal Flow (Weapon → Save System)

### WeaponManager emits:
```gdscript
signal weapon_state_changed(data)
```

### GameManager listens:
```gdscript
weapon_manager.weapon_state_changed.connect(save_weapon_data)
```

---

## 💾 Save System Integration

### Stored Data Structure:
```json
"weapons": {
  "current_weapon_id": "smg_01",
  "inventory": {
    "smg_01": {
      "ammo_in_mag": 18,
      "mags_left": 2
    },
    "pistol_01": {
      "ammo_in_mag": 6,
      "mags_left": 1
    }
  }
}
```

### ❌ Do NOT Save:
- recoil
- spread
- reload_time
- weapon_type

**Reason:**
These values belong to `WeaponData`. Saving them creates maintenance and balancing issues.

---

## 🔁 Checkpoint Save Flow

1. GameManager triggers save:
```gdscript
save_game()
```

2. Pull weapon state:
```gdscript
var weapon_data = weapon_manager.get_save_data()
```

3. Merge into save JSON

---

## 🧩 Load Flow

After level load:
```gdscript
weapon_manager.load_from_save(data["weapons"])
```

### Steps:
- Recreate weapons using `gun_id`
- Restore ammo state
- Equip current weapon automatically

---

## 🔫 Weapon Pickup System

### World Pickup Object

**Components:**
- Static weapon mesh
- `PickupWeapon.gd`

**On Interaction:**
```gdscript
weapon_manager.add_weapon("smg_01")
queue_free()
```

---

### First-Person Weapon Instance

**Components:**
- Arms + animated weapon model
- Spawned by WeaponManager

**On Equip:**
```gdscript
play("draw")
```

---

## ⚠️ Common Mistakes

### ❌ Monolithic weapon script
→ Leads to unmaintainable code

### ❌ Saving full node states
→ Breaks with updates

### ❌ Hardcoding weapon stats
→ Impossible to balance later

### ❌ GameManager controlling weapons directly
→ Destroys modularity

---

## 🧠 Enum Definition

```gdscript
enum WeaponType {
    PISTOL,
    SMG,
    RIFLE
}
```

---

## 🚀 Implementation Order

1. Create WeaponData resources (SMG, pistol, rifle)
2. Implement Weapon.gd (shooting + reload + ammo)
3. Implement WeaponManager.gd
4. Connect signals to GameManager
5. Extend save system
6. Build pickup system
7. Integrate animations (draw, shoot, reload)

---

## 📌 Key Principle

**Separation of Data, Behavior, and Control is non-negotiable.**

Breaking this rule will lead to scaling issues, bugs, and poor maintainability as more weapons are added.

