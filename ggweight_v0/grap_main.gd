extends Node2D

func _ready():
	$Line_Chart_v0.visible = true
	$Line_Chart_v0.modulate.a = 1
	$Line_Chart_v0.scale.y = 0.0
	$Line_Chart_v0.modulate.a = 0.0
	$Line_Chart_v0.pivot_offset = Vector2(0, 0)  # Grows from top
	$Line_Chart_v0.anchor_top = 0  # Ensure anchor is top-aligned (important)

func _on_check_button_toggled(toggled_on: bool) -> void:
	
	if(toggled_on):
		$Line_Chart_v0.visible = true
		$AnimationPlayer.play("fade_in")
	else:
		print("here")
		$AnimationPlayer.play("fade_out")
		#$Line_Chart_v0.visible = false
	pass # Replace with function body.

func _on_check_button_2_toggled(toggled_on: bool) -> void:
	
	if(toggled_on):
		var tween = get_tree().create_tween()
		tween.parallel().tween_property($Line_Chart_v0, "scale:y", 1.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property($Line_Chart_v0, "modulate:a", 1.0, 0.5)
		$Line_Chart_v0._on_do_something()
	else:
		var tween = get_tree().create_tween()
		tween.parallel().tween_property($Line_Chart_v0, "modulate:a", 0.0, 0.15)
		tween.parallel().tween_property($Line_Chart_v0, "scale:y", 0.25, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	pass # Replace with function body.
