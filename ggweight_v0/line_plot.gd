extends Control

#defaults
var line_color: Color = Color.RED
var line_width: float = 5.0
var grid_color: Color = Color.DIM_GRAY
var grid_thickness: float = 1.0
var axis_color: Color = Color.WHITE
var axis_thickness: float = 2.0

#storage for line
var points: PackedVector2Array = []
var points_2: PackedVector2Array = []

# Grid line info
var x_ticks := 7
var y_ticks := 7

func set_style(params: Dictionary):
	line_color = params.get("line_color", line_color)
	line_width = params.get("line_width", line_width)
	grid_color = params.get("grid_color", grid_color)
	grid_thickness = params.get("grid_thickness", grid_thickness)
	axis_color = params.get("axis_color", axis_color)
	axis_thickness = params.get("axis_thickness", axis_thickness)
	queue_redraw()

func set_points(p: PackedVector2Array):
	points = p
	queue_redraw()

func set_points_2(p_2: PackedVector2Array):
	points_2 = p_2
	queue_redraw()

func set_grid(x_t: int, y_t: int):
	x_ticks = x_t
	y_ticks = y_t
	queue_redraw()

func _draw():
	var size = get_size()

	# Draw vertical grid lines
	if x_ticks > 1:
		for i in range(x_ticks):
			var x = size.x * i / (x_ticks - 1)
			var color = axis_color if i == 0 else grid_color
			var thickness = axis_thickness if i == 0 else grid_thickness
			draw_line(Vector2(x, 0), Vector2(x, size.y), color, thickness)

	# Draw horizontal grid lines
	if y_ticks > 1:
		for i in range(y_ticks):
			var y = size.y * i / (y_ticks - 1)
			var color = axis_color if i == y_ticks - 1 else grid_color
			var thickness = axis_thickness if i == y_ticks - 1 else grid_thickness
			draw_line(Vector2(0, y), Vector2(size.x, y), color, thickness)

	# Draw data polyline
	if points.size() >= 2:
		draw_polyline(points, Color.CADET_BLUE, line_width)
		
	if points_2.size() >= 2:
		draw_polyline(points_2, Color.ORANGE_RED, line_width)

func _resized():
	queue_redraw()
