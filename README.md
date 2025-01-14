# Monka Utils

### What does this includes?

- TriggerBox
- Air
- MonkaSoundResource
- MonkaAutoload
- Component

# How to use

### *Everything has documentation, parameters, methods and signals*

# TriggerBox

The TriggerBox is **REALLY** useful, you can select one of the 6 presets
- Free
- Call
- Trigger Component 
- Play Sound
- Play Spatial Sound
- Play Animation

*Note: TriggerComponent allows for custom scripts either inheriting from **TriggerComponent** or  using a local **GDScript** resource*

You can use it for your singleplayer games to play a sound or music just at the right time.

Since it inherits from **Area3D** you need to add a **CollisionShape3D** as a child.

![Air]([https://prnt.sc/okTdCanORyp0](https://github.com/soymako/MonkaUtils/blob/main/monka_utils/images/air_ss_1.png))

in the other hand, the Air node works a little different, this node applies a force to all colliding bodies when active

<!-- 
# TriggerBox

TriggerBox inherits from **Area3D**

### Signals
- Triggered
### Methods

- restart()->void

### Parameters

- option:triggerBoxTypes
- oneShot:bool
- debug:bool

### execution

- method:String
- args:Array
- soundResource:MonkaSoundResource
- soundOrigin:Node3D
- soundPosition:Vector3

# Air

Air inherits from **Area3D**, it applies an impulse to all RigidBodies colliding with it

### Methods
- start()->void

### Parameters -->
