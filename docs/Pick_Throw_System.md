# Minimal Pick & Throw System

This system allows objects to be picked up and thrown with minimal setup.

## Implementation Files
- `script/pickable.gd`: Attach to any RigidBody3D to make it pickable
- `script/player/fps_player_controller.gd`: Handles player interaction
- `scene/crosshair.tscn`: UI crosshair that highlights when targeting objects

## Setup Instructions
1. **Attach Pickable Script**:
   - Add `pickable.gd` to any RigidBody3D
   - No additional configuration needed

2. **Player Configuration**:
   - Ensure your player has:
     - Camera3D
     - RayCast3D (child of camera, Target Position: `(0, 0, -3)`)
   - The player script already handles input and physics

3. **Input Mapping**:
   - `interact` (E key): Pick up/drop objects
   - `throw` (Q key): Throw held object

## Usage
1. **Picking Up**:
   - Look at object with crosshair (turns green when targetable)
   - Press E to pick up

2. **Dropping**:
   - Press E while holding object to drop

3. **Throwing**:
   - Press Q while holding object to throw

## Test Object
- `scene/test_pickable.tscn`: Preconfigured test sphere
- Add to your scene to verify system works

## Key Features
- Only one object can be held at a time
- No inventory system
- Physics-based throwing
- Visual targeting feedback

> Note: The system uses layer 1 for collision. Adjust if needed.