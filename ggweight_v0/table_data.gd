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
		var user_input = [table_data[row][0], table_data[row][1], value]
		is_valid_datetime(user_input)
		print(is_valid_datetime(user_input))
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


func is_valid_datetime(input_array: Array) -> bool:
	if input_array.size() != 3:
		return false

	var date_str = input_array[0]  # "YYYY-MM-DD"
	var time_str = input_array[1]  # "HH:MM:SS"
	var ms_str = input_array[2]    # "milliseconds"

	# Validate date
	var date_parts = date_str.split("-")
	if date_parts.size() != 3:
		return false
	var year = int(date_parts[0])
	var month = int(date_parts[1])
	var day = int(date_parts[2])

	# Check for valid date
	if not is_valid_date(year, month, day):
		return false

	# Validate time
	var time_parts = time_str.split(":")
	if time_parts.size() != 3:
		return false
	var hour = int(time_parts[0])
	var minute = int(time_parts[1])
	var second = int(time_parts[2])

	if hour < 0 or hour > 23:
		return false
	if minute < 0 or minute > 59:
		return false
	if second < 0 or second > 59:
		return false

	# Validate milliseconds
	var ms = int(ms_str)
	if ms < 0 or ms > 999:
		return false
	return true

# Helper function to check if a date is valid (because users can be stupid sometimes :)
func is_valid_date(year: int, month: int, day: int) -> bool:
	var days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

	# Leap year check
	if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
		days_in_month[1] = 29

	if month < 1 or month > 12:
		return false
	var max_day = days_in_month[month - 1]
	
	return day >= 1 and day <= max_day
