# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2026 Estudio Eclipse. All rights reserved.

extends Node3D
class_name ProximityVoIPController

## ProximityVoIPController
## Componente universal de chat de voz posicional 3D para Godot 4.x.
## Permite añadir audio espacial de proximidad con atenuación y búfer de jitter a cualquier personaje.

@export var unit_size: float = 10.0
@export var max_distance: float = 50.0
@export var audio_bus_name: StringName = &"Voice"
@export var sample_rate: float = 16000.0
@export var jitter_buffer_bytes: int = 960

var voip_player: AudioStreamPlayer3D = null
var voip_playback: AudioStreamGeneratorPlayback = null
var _jitter_buffer: PackedByteArray = PackedByteArray()


func _ready() -> void:
	voip_player = AudioStreamPlayer3D.new()
	voip_player.name = "SpatialVoiceEmitter"
	voip_player.unit_size = unit_size
	voip_player.max_distance = max_distance
	voip_player.attenuation_model = AudioStreamPlayer3D.ATTENUATION_INVERSE_DISTANCE
	voip_player.bus = audio_bus_name

	var generator := AudioStreamGenerator.new()
	generator.mix_rate = sample_rate
	generator.buffer_length = 0.35
	voip_player.stream = generator
	add_child(voip_player)
	voip_player.play()
	voip_playback = voip_player.get_stream_playback() as AudioStreamGeneratorPlayback


func receive_voice_chunk(pcm_bytes: PackedByteArray) -> void:
	if voip_playback == null:
		return

	_jitter_buffer.append_array(pcm_bytes)
	if _jitter_buffer.size() < jitter_buffer_bytes:
		return

	var frames_to_push: int = _jitter_buffer.size() / 2
	var available_frames: int = voip_playback.get_frames_available()
	var count: int = mini(frames_to_push, available_frames)

	for i in range(count):
		var idx: int = i * 2
		var b0: int = _jitter_buffer[idx]
		var b1: int = _jitter_buffer[idx + 1]
		var sample_i16: int = b0 | (b1 << 8)
		if sample_i16 > 32767:
			sample_i16 -= 65536
		var sample_f: float = clampf(float(sample_i16) / 32768.0, -1.0, 1.0)
		voip_playback.push_frame(Vector2(sample_f, sample_f))

	var consumed_bytes: int = count * 2
	if consumed_bytes >= _jitter_buffer.size():
		_jitter_buffer.clear()
	else:
		_jitter_buffer = _jitter_buffer.slice(consumed_bytes)
