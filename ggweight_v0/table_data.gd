extends Node

signal data_changed

var table_data: Array = []
var undo_stack: Array = []

func _ready():
	# Initialize with one row
	table_data.append(["2025-06-27", "20:12:23", "55"])
	table_data.append(["2025-06-28", "16:35:23", "44"])
	table_data.append(["2025-06-30", "10:12:23", "63"])
	# add_row()
	pass

func get_data() -> Array:
	return table_data

func add_row():
	_push_undo_state()
	
	var now = Time.get_datetime_dict_from_system()
	var date = "%04d-%02d-%02d" % [now["year"], now["month"], now["day"]]
	var time = "%02d:%02d:%02d" % [now["hour"], now["minute"], now["second"]]
	table_data.append([date, time, ""])
	emit_signal("data_changed")

func remove_last_row():
	#TO DO _release_all_lineedit_focus()
	if table_data.size() > 0:
		_push_undo_state()
		table_data.pop_back()
		emit_signal("data_changed")

func update_cell(row: int, col: int, value: String):
	if row < table_data.size() and col < table_data[row].size():
		if table_data[row][col] != value:
			_push_undo_state()
			table_data[row][col] = value
			emit_signal("data_changed")

func undo():
	if undo_stack.size() > 0:
		table_data = undo_stack.pop_back()
		emit_signal("data_changed")

func _push_undo_state():
	var snapshot = table_data.duplicate(true)
	undo_stack.append(snapshot)
	if undo_stack.size() > 25:
		undo_stack.pop_front()
