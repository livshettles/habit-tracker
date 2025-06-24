extends VBoxContainer

@onready var header_grid = $HeaderGrid
@onready var table_grid = $TableGrid
@onready var add_row_button = $Toolbar/AddRowButton
@onready var remove_row_button = $Toolbar/RemoveRowButton
@onready var undo_button = $Toolbar/UndoButton
@onready var data_store = get_parent().get_node("DataStore")  # 👈 sibling node

const NUM_COLUMNS := 3  # "Date", "Time", "Note"

func _ready():
	# Setup column counts
	header_grid.columns = NUM_COLUMNS
	table_grid.columns = NUM_COLUMNS

	_create_headers()

	# Connect UI buttons to the data store
	add_row_button.pressed.connect(data_store.add_row)
	remove_row_button.pressed.connect(data_store.remove_last_row)
	undo_button.pressed.connect(data_store.undo)

	# Refresh table whenever data changes
	data_store.data_changed.connect(_refresh_table)

	# Initial draw
	_refresh_table()


func _create_headers():
	var headers = ["Date", "Time", "Note"]
	for header_text in headers:
		var label = Label.new()
		label.text = header_text
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.custom_minimum_size = Vector2(140, 24)
		header_grid.add_child(label)


func _refresh_table():
	# Clear previous UI
	for child in table_grid.get_children():
		child.queue_free()

	var table_data = data_store.get_data()

	for row in table_data.size():
		for col in range(NUM_COLUMNS):
			var input = LineEdit.new()
			input.text = table_data[row][col]
			input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			input.custom_minimum_size = Vector2(140, 24)
			input.set_meta("row", row)
			input.set_meta("col", col)
			input.text_changed.connect(_on_cell_edited.bind(input))
			table_grid.add_child(input)


func _on_cell_edited(new_text: String, line_edit: LineEdit):
	var row = line_edit.get_meta("row")
	var col = line_edit.get_meta("col")
	data_store.update_cell(row, col, new_text)


#extends VBoxContainer
#
#@onready var header_grid = $HeaderGrid
#@onready var table_grid = $TableGrid
#@onready var add_row_button = $Toolbar/AddRowButton
#@onready var remove_row_button = $Toolbar/RemoveRowButton
#@onready var undo_button = $Toolbar/UndoButton
#
#const NUM_COLUMNS := 3  # Date, Time, User input
#var table_data: Array = []  # Each row is [date, time, user_text]
#var undo_stack: Array = []             # Previous states (max 15)
#
#func _ready():
	#header_grid.columns = NUM_COLUMNS
	#table_grid.columns = NUM_COLUMNS
	#_create_headers()
#
	#add_row_button.pressed.connect(_on_add_row)
	#remove_row_button.pressed.connect(_on_remove_row)
	#undo_button.pressed.connect(_on_undo_pressed)
#
	#_add_row()  # Add initial row
#
#func _create_headers():
	#var headers = ["Date", "Time", "Weight (kg)"]
	#for header_text in headers:
		#var label = Label.new()
		#label.text = header_text
		#label.custom_minimum_size = Vector2(140, 24)
		#label.add_theme_font_size_override("font_size", 16)
		#label.set("theme_override_constants/margin_top", 4)
		#label.set("theme_override_constants/margin_bottom", 4)
		#label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		#header_grid.add_child(label)
#
#func _on_add_row():
	#_add_row()
#
#func _on_remove_row():
	#if table_data.size() > 0:
		#_push_undo_state()
		#table_data.pop_back()
		#_refresh_table()
#
#func _add_row():
	#_push_undo_state()
	#var now = Time.get_datetime_dict_from_system()
	#var date = "%04d-%02d-%02d" % [now["year"], now["month"], now["day"]]
	#var time = "%02d:%02d:%02d" % [now["hour"], now["minute"], now["second"]]
	#table_data.append([date, time, ""])
	#_refresh_table()
#
#func _refresh_table():
	#for child in table_grid.get_children():
		#child.queue_free()
#
	#for row in table_data.size():
		#for col in range(NUM_COLUMNS):
			#var input = LineEdit.new()
			#input.text = table_data[row][col]
			#input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			#input.custom_minimum_size = Vector2(140, 24)
			#input.set_meta("row", row)
			#input.set_meta("col", col)
			#input.text_changed.connect(_on_cell_edited.bind(input))
			#table_grid.add_child(input)
#
#func _on_cell_edited(new_text: String, line_edit: LineEdit):
	#var row = line_edit.get_meta("row")
	#var col = line_edit.get_meta("col")
#
	## Save undo only if value changed
	#if table_data[row][col] != new_text:
		#_push_undo_state()
		#table_data[row][col] = new_text
		#print("Updated cell [", row, ",", col, "] to: ", new_text)
#
#
#func _push_undo_state():
	#var snapshot = table_data.duplicate(true)  # Deep copy
	#undo_stack.append(snapshot)
	#if undo_stack.size() > 15:
		#undo_stack.pop_front()  # Keep only last 15
#
#func _on_undo_pressed():
	#if undo_stack.size() > 0:
		#table_data = undo_stack.pop_back()
		#_refresh_table()
		#print("Undo performed.")
	#else:
		#print("Nothing to undo.")
