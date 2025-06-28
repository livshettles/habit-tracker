extends Node2D

@onready var chart = $Line_Chart_v0

func _ready():
	chart.visible = true
	chart.modulate.a = 0.0
	chart.scale.y = 0.0
	chart.pivot_offset = Vector2(0, 0)

func _handle_chart_toggle(toggled_on: bool, animate_chart: bool) -> void:
	if animate_chart:
		var tween = get_tree().create_tween()

		if toggled_on:
			chart.visible = true
			tween.parallel().tween_property(chart, "scale:y", 1.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			tween.parallel().tween_property(chart, "modulate:a", 1.0, 0.5)
			chart._on_do_something()
		else:
			tween.parallel().tween_property(chart, "modulate:a", 0.0, 0.15)
			tween.parallel().tween_property(chart, "scale:y", 0.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	else:
		if toggled_on:
			chart.modulate.a = 1.0
			chart.scale.y = 1.0
			chart._on_do_something()
		else:
			chart.modulate.a = 0.0
			chart.scale.y = 0.0

func _on_check_smooth_button_toggled(toggled_on: bool) -> void:
	_handle_chart_toggle(toggled_on, true)

func _on_check_button_toggled(toggled_on: bool) -> void:
	_handle_chart_toggle(toggled_on, false)
