extends Node2D

var Shader_Array = []
var rand_int = []
var Shader_index = 0
var shader_path :String

func _ready(): 
	Shader_Array = get_shader_list_from_folder("res://Shaders")
	
	Shader_index = randi() % Shader_Array.size() # pick a random shader to start with :)
	shader_path = Shader_Array[Shader_index]
	
	var shader := load(Shader_Array[Shader_index])
	var shader_material := ShaderMaterial.new()
	shader_material.shader = shader
	shader_material = Set_shader_parameters_correctly(Shader_Array[Shader_index], shader_material)
	$Background.material = shader_material
	
	pass
	
	#var Shader_file = "res://Shaders/My_first_shader.gdshader"
	#var shader_param_names = ["bottom_color",
		#"top_color",
		#"beam_distance",
		#"beam_height",
		#"beam_width",
		#"total_phases",
		#]
	#var shader_param_setpoints = [Color8(214, 135, 168, 255),
		#Color8(25, 189, 189, 255),
		#0.05,
		#0.035,
		#0.128,
		#10,
		#]
		#
	#var Shader_file = "res://Shaders/Balatro_shader.gdshader"
	#var shader_param_names = [#"polar_coordinates",
			#"polar_center",
			##"polar_zoom",
			#"polar_repeat",
			#"spin_rotation",
			#"spin_speed",
			##"offset",
			#"colour_1",
			#"colour_2",
			#"colour_3",
			##"contrast",
			##"spin_amount",
			##"pixel_filter",
		#]
	#var shader_param_setpoints = [
			#Vector2(500, 0),
			#2,
			#1,
			#3,
			#Color8(217, 191, 235, 255),
			#Color8(212, 151, 100, 255),
			#Color8(78, 37, 91, 255),
			#]
	
	#var Shader_file = "res://Shaders/Nebula.gdshader"
	#var shader_param_names = ["stars_on",
		#"timeScaleFactor",
		#"noise_texture",
		#"colour_muiltiplier",
		#"colour_muiltiplier2",
		#"brightness",
		#"clouds_resolution",
		#"clouds_intesity",
		#"waveyness",
		#"fragmentation",
		#"distortion",
		#"clouds_alpha",
		#"movement",
		#"blur",
		#"blur2",
		#]
	#var shader_param_setpoints = [true,
		#1.0, 
		#"res://textures/NoisePattern-220722-1826-55cm-detail.jpg",
		#Color(0.18, 1.0, 0.698), 
		#Color(1.0, 0.0, 0.965), 
		#0.85, 
		#10,
		#0.0,
		#0.25,
		#20.0,
		#0.25,
		#0.4,
		#1.3,
		#10.0,
		#0.0025,
		#]
	#
	#var local_shader:= load(Shader_file)
	#var local_shader_mat := ShaderMaterial.new()
	#local_shader_mat.shader = local_shader
	##
#
	#var params := local_shader_mat.shader.get_shader_uniform_list()
	#for p in params:
		#print("\"", p.name, "\",")
		#
	#for i in shader_param_names.size():
		#local_shader_mat.set_shader_parameter(shader_param_names[i], shader_param_setpoints[i]) 
	#
	#$Background.material = local_shader_mat
	#
	#pass

func get_shader_list_from_folder(folder_path: String) -> Array:
	var shader_files := []
	var dir := DirAccess.open(folder_path)
	if dir == null:
		push_error("Failed to open folder: %s" % folder_path)
		return shader_files

	dir.list_dir_begin()

	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break

		if dir.current_is_dir():
			continue

		if file_name.ends_with(".gdshader"):
			var full_path = folder_path + "/" + file_name
			shader_files.append(full_path)

	dir.list_dir_end()
	return shader_files

func _on_texture_button_pressed() -> void:
	
	Shader_index += 1
	Shader_index = Shader_index % Shader_Array.size()
	
	var shader := load(Shader_Array[Shader_index])
	var shader_material := ShaderMaterial.new()
	shader_material.shader = shader
	shader_material = Set_shader_parameters_correctly(Shader_Array[Shader_index], shader_material)
	$Background.material = shader_material
	
	pass # Replace with function body.

func Set_shader_parameters_correctly(Shader_file, Shader_material):
	var local_shader_mat = Shader_material
	var local_shader_param_names
	var local_shader_param_setpoints
	if(Shader_file == "res://Shaders/Balatro_shader.gdshader"): 
		local_shader_param_names = [#"polar_coordinates",
			"polar_center",
			#"polar_zoom",
			"polar_repeat",
			"spin_rotation",
			"spin_speed",
			#"offset",
			"colour_1",
			"colour_2",
			"colour_3",
			#"contrast",
			#"spin_amount",
			#"pixel_filter",
		]
		local_shader_param_setpoints = [
			Vector2(500, 0),
			2,
			1,
			3,
			Color8(217, 191, 235, 255),
			Color8(212, 151, 100, 255),
			Color8(78, 37, 91, 255),
			]
	elif (Shader_file == "res://Shaders/My_first_shader.gdshader"): 
		local_shader_param_names = ["bottom_color",
		"top_color",
		"beam_distance",
		"beam_height",
		"beam_width",
		"total_phases",
		]
		local_shader_param_setpoints = [Color8(214, 135, 168, 255),
			Color8(25, 189, 189, 255),
			0.05,
			0.035,
			0.128,
			10,
			]
	elif (Shader_file == "res://Shaders/Nebula.gdshader"):
		local_shader_param_names = ["stars_on",
		"timeScaleFactor",
		"noise_texture",
		"colour_muiltiplier",
		"colour_muiltiplier2",
		"brightness",
		"clouds_resolution",
		"clouds_intesity",
		"waveyness",
		"fragmentation",
		"distortion",
		"clouds_alpha",
		"movement",
		"blur",
		"blur2",
		]
		var my_noise_texture = load("res://textures/NoisePattern-220722-1826-55cm-detail.jpg")
		local_shader_param_setpoints = [true,
		1.0, 
		my_noise_texture,
		Color(0.18, 1.0, 0.698), 
		Color(1.0, 0.0, 0.965), 
		0.85, 
		10,
		0.0,
		0.25,
		20.0,
		0.25,
		0.4,
		1.3,
		10.0,
		0.0025,
		]
	
	for i in local_shader_param_names.size():
		local_shader_mat.set_shader_parameter(local_shader_param_names[i], local_shader_param_setpoints[i]) 
	
	return local_shader_mat 

#TODO: could also write a "get" shader properties function, so I don't have to type them all out like a pleb
