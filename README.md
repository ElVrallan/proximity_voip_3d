# Proximity VoIP 3D for Godot 4.x

A lightweight, drop-in 3D positional proximity voice chat component with jitter compensation and spatial attenuation.

## Features

- **Microphone Capture**: 16 kHz Mono PCM audio capture using `AudioEffectCapture`.
- **Adaptive 960-Byte Jitter Buffer**: Absorbs internet packet bursts and reordering (60 ms window) for crystal-clear spatial audio.
- **Realistic 3D Acoustic Falloff**: Inverse-distance spatial attenuation up to 50+ meters.
- **Audio Bus Routing**: Routes directly to custom audio buses with reverb, lowpass, or pitch shifting effects.

## Usage in any Godot 4 project

1. Enable the plugin in **Project Settings -> Plugins**.
2. Add a `ProximityVoIPController` node as a child of your player character (`CharacterBody3D`).
3. Pass incoming network voice packets to:
   ```gdscript
   voip_controller.receive_voice_chunk(pcm_data)
   ```

## ⚖️ Licencia y Uso Comercial
Este plugin está licenciado bajo la **Mozilla Public License 2.0 (MPL-2.0)** por **Estudio Eclipse**.

### ¿Puedo usar este plugin en mi videojuego comercial cerrado (Steam, Consolas, Móviles)?
**SÍ.** La licencia MPL-2.0 permite explícitamente compilar e integrar este plugin dentro de obras comerciales propietarias (*Larger Works*) sin que tengas que liberar el código de tu juego ni tus recursos artísticos.

### ¿Qué obligaciones tengo?
1. Si realizas cambios o mejoras directamente sobre los archivos de este plugin (por ejemplo, optimizaciones o correcciones de bugs en sus scripts), debes poner a disposición de la comunidad esas modificaciones bajo la misma licencia MPL-2.0.
2. Mantener los avisos de copyright y autoría original de **Estudio Eclipse**.
