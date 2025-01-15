# Monka Utils 📦

### What does this includes? 🔍

- TriggerBox
- Air
- MonkaSoundResource
- MonkaAutoload
- Component

# How to use ❔

### *Everything has documentation, parameters, methods and signals*

# TriggerBox 📦
![TB](monka_utils/images/tb_ss_1.png?raw=true)

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
# Air 💨
![Air](monka_utils/images/air_ss_1.png?raw=true)
in the other hand, the Air node works a little different, this node applies a force to all colliding bodies when active, you can mix
the options and use the **FadeIn** and **FadeOut** to animate it *(that will only work if **Timed** is **TRUE**)*

## Air Showcase 🎬

![airSC](monka_utils/images/air_showcase.gif?raw=true)

# How to install ⬇🌐

### 1. Create an "addons" folder in your Godot project
### 2. Open a terminal inside the "addons" folder
### 3. `git clone https://github.com/soymako/MonkaUtils.git`
### 4. Go to `Project > Project Settings > Plugins`
### 5. Activate the plugin.
