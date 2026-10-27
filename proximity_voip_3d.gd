# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2026 Estudio Eclipse. All rights reserved.

@tool
extends EditorPlugin
## Proximity VoIP 3D Plugin for Godot 4.x

func _enter_tree() -> void:
	add_custom_type("ProximityVoIPController", "Node3D", preload("ProximityVoIPController.gd"), null)
	print("[ProximityVoIP3D] Plugin activado.")


func _exit_tree() -> void:
	remove_custom_type("ProximityVoIPController")
	print("[ProximityVoIP3D] Plugin desactivado.")
