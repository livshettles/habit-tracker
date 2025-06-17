extends GridContainer

@export var line_width: float = 2
@export var line_color: Color = Color.RED
@export var bg_color: Color = Color.WHITE
@export var grid_color: Color = Color.DIM_GRAY
@export var grid_thickness: float = 1.0
@export var axis_color: Color = Color.WHITE
@export var axis_thickness: float = 2.0

@export var x_label: String = ""
@export var y_label: String = ""

@export var x_ticks: int = 7
@export var y_ticks: int = 7

var x_numerical := true
var y_numerical := true

var min_x
var min_y
var max_x
var max_y

var animated_points: Array = []
var all_points: Array = []
var visible_line: Array = []

var drawing :bool = false
var new_interp :bool = true
var draw_speed := 1000  # pixels per second
var current_index := 0
var t := 0.0

var data = [
	{'x': 'MON', 'y': 7.0},
	{'x': 'TUE', 'y': 8.0},
	{'x': 'WED', 'y': 3.0},
	{'x': 'THU', 'y': 5.0},
	{'x': 'FRI', 'y': 4.0},
	{'x': 'SAT', 'y': 6.0},
	{'x': 'SUN', 'y': 1.0},
]

func _ready():
	$x_label.text = x_label
	$y_label.text = y_label
	$"line_plot/Chart BG".color = bg_color
	
	$line_plot.set_style({
	"line_color": line_color,
	"line_width": line_width,
	"grid_color": grid_color,
	"grid_thickness": grid_thickness,
	"axis_color": axis_color,
	"axis_thickness": axis_thickness
	})
	# Detect numerical axes
	for val in data:
		if not [TYPE_INT, TYPE_FLOAT].has(typeof(val['x'])):
			x_numerical = false
		if not [TYPE_INT, TYPE_FLOAT].has(typeof(val['y'])):
			y_numerical = false

	# Compute min/max
	for i in range(data.size()):
		var x_val = get_val(data[i]['x'], i)
		var y_val = get_val(data[i]['y'], i)
		if min_x == null or x_val < min_x:
			min_x = x_val
		if max_x == null or x_val > max_x:
			max_x = x_val
		if min_y == null or y_val < min_y:
			min_y = y_val
		if max_y == null or y_val > max_y:
			max_y = y_val

	# Tick labels: X
	for i in range(x_ticks):
		var x_tick = Label.new()
		x_tick.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		x_tick.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		if x_numerical:
			x_tick.text = str(round(i * (max_x - min_x) / (x_ticks - 1) + min_x))
		else:
			x_tick.text = str(data[i]['x'])
		$x_ticks_cont.add_child(x_tick)

	# Tick labels: Y
	for i in range(y_ticks - 1, -1, -1):
		var y_tick = Label.new()
		y_tick.size_flags_vertical = Control.SIZE_EXPAND_FILL
		y_tick.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		if y_numerical:
			y_tick.text = str(round(i * (max_y - min_y) / (y_ticks - 1) + min_y))
		else:
			y_tick.text = str(data[y_ticks - i - 1]['y'])
		$y_ticks_cont.add_child(y_tick)

	# Wait one frame so Control layout is correct
	await get_tree().process_frame

	# Generate points and pass to line_plot
	var plot_points := PackedVector2Array()
	for i in range(data.size()):
		var x_val = get_val(data[i]['x'], i)
		var y_val = get_val(data[i]['y'], i)
		var px = scale_x(x_val)
		var py = scale_y(y_val)
		plot_points.append(Vector2(px, py))
	
	$line_plot.set_grid(x_ticks, y_ticks)
	all_points = plot_points
	#$line_plot.line_color = Color.SKY_BLUE
	#await draw_graph_line_step_by_step(plot_points)
	#draw_graph_line_step_by_step(plot_points)
	#all_points = plot_points
	#draw_graph_line_step_by_step_V2(plot_points)
	

	#$line_plot.set_points(plot_points)
	

func draw_graph_line_step_by_step(plot_points):
	animated_points.clear()
	all_points.clear()

	for p in plot_points:
		animated_points.append(p)
		$line_plot.set_points(animated_points)
		queue_redraw()  # Tells Godot to call _draw()
		await get_tree().create_timer(0.15).timeout



	#for p in points:
		#temp_pts.append(p)
		#if temp_pts.size() >= 2 and temp_pts.size() != points.size() :
			#draw_polyline(temp_pts, Color.RED, 10.0)
			#queue_redraw()
			#await get_tree().create_timer(0.25).timeout
			#print("hello", points.size(), temp_pts.size())

func draw_graph_line_step_by_step_V2(plot_points):
	drawing = true
	new_interp = true
	current_index = 0
	visible_line = []
	t = 0.0 #interp variable
	visible_line.append(plot_points[0])
	set_process(true)
	
func _process(delta):
	if !drawing:
		return

	if current_index >= all_points.size() - 1:
		drawing = false
		set_process(false) #kill the process
		return

	var p1
	var p2
	if(new_interp):
		p1 = all_points[current_index]
		p2 = all_points[current_index + 1]
	else: 
		p1 = all_points[current_index]
		p2 = all_points[current_index + 1]
	var dist = p1.distance_to(p2)
	t += delta * draw_speed / dist

	if t >= 1.0:
		t = 0.0
		current_index += 1
		visible_line[current_index] = all_points[current_index]
		new_interp = true
	else:
		var interp_point = p1.lerp(p2, t)
		if visible_line.size() > current_index + 1:
			visible_line[-1] = interp_point
		else:
			visible_line.append(interp_point)

	$line_plot.set_points_2(visible_line)
	queue_redraw()  # Tells Godot to call _draw()
	print(visible_line.size(), " ", t)
	

	#for p in points:
		#temp_pts.append(p)
		#if temp_pts.size() >= 2 and temp_pts.size() != points.size() :
			#draw_polyline(temp_pts, Color.RED, 10.0)
			#queue_redraw()
			#await get_tree().create_timer(0.25).timeout
			#print("hello", points.size(), temp_pts.size())

func scale_x(val: float) -> float:
	var w = $line_plot.size.x
	var dx = max_x - min_x
	return ((val - min_x) / dx) * w if dx != 0 else 0

func scale_y(val: float) -> float:
	var h = $line_plot.size.y
	var dy = max_y - min_y
	return h - ((val - min_y) / dy) * h if dy != 0 else 0

func get_val(val, idx: int) -> float:
	if typeof(val) in [TYPE_INT, TYPE_FLOAT]:
		return val
	return idx

func _on_do_something(): 
	await draw_graph_line_step_by_step_V2(all_points)
