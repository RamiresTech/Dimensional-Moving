extends Node2D

class_name LevelUm2D

@export var limit_time: int = 5

@onready var table: Table2D = $Level_2D/Table2D
@onready var table_3d: Table3D = $Level_3D/Table3D
@onready var task_scene: PackedScene = preload("res://scenes/task.tscn")
@onready var movel_template: PackedScene = preload("res://scenes/movel2D.tscn")
@onready var tasks_list: VBoxContainer = %TaskList
@onready var cover_screen: TextureRect = %Cover
@onready var victory_screen: MarginContainer = %VictoryScreen
@onready var loose_screen: MarginContainer = %LooseScreen
@onready var contdown: CountDown = %Countdown

const TASKS_FILE_PATH = "res://tasks.json"

var selected_cells_2D: Array
var selected_cells_3D: Array
var tasks: Array[Task]

func _ready():
	start_game()

func _process(delta: float) -> void:
	var finish_2d = check_victory_condition_2D()
	var finish_3d = check_victory_condition_3D()

	if finish_2d and finish_3d:
		await get_tree().create_timer(0.5).timeout
		cover_screen.show()
		victory_screen.show()

func start_game() -> void:
	Global.game_mode = Global.game_modes.GAME2D
	contdown.countdown_minutes = limit_time
	var tasks_data = get_tasks_data_from_json_file()
	var tasks_informations = get_random_tasks(tasks_data)

	for task in tasks_informations:
		tasks.append(
			get_task_object(task[0], task[1], task[2], task[3])
		)
	fill_tasks_list()
	select_random_cells_2D(tasks.size())
	set_initial_position_of_moveis_2D()
	select_random_cells_3D(tasks.size())
	set_initial_position_of_moveis_3D()
	contdown.start_countdown()


func get_tasks_data_from_json_file() -> Dictionary:
	var file = FileAccess.open(TASKS_FILE_PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	return JSON.parse_string(json_string)

func select_random_cells_2D(amount_of_cells_to_select: int) -> void:
	selected_cells_2D = []

	while selected_cells_2D.size() < amount_of_cells_to_select:
		var row = randi_range(0, 9)
		var col = randi_range(0, 9)
		var cell = table.get_cell_at(row, col)

		if cell and !selected_cells_2D.has(cell):
			selected_cells_2D.append(cell)

func select_random_cells_3D(amount_of_cells_to_select: int) -> void:
	selected_cells_3D = []

	while selected_cells_3D.size() < amount_of_cells_to_select:
		var row = randi_range(0, 9)
		var col = randi_range(0, 9)
		var cell = table_3d.get_cell_at(row, col)

		if cell and !selected_cells_3D.has(cell):
			selected_cells_3D.append(cell)

func set_initial_position_of_moveis_2D() -> void:
	for index in range(tasks.size()):
		var cell = selected_cells_2D[index]
		var task = tasks[index] as Task
		var movel_instance = task.moveis_2d.get(task.movel_name).instantiate()
		var movel = movel_instance as Movel2D
		movel.movel_name = task.movel_name
		movel.position = cell.position
		table.add_child(movel_instance)
		cell.content = movel
		movel.cell = cell

func set_initial_position_of_moveis_3D() -> void:
	for index in range(tasks.size()):
		var cell = selected_cells_3D[index]
		var task = tasks[index] as Task
		var movel_instance = task.moveis_3d.get(task.movel_name).instantiate()
		var movel = movel_instance as Movel3D
		movel.movel_name = task.movel_name
		movel.position = cell.position
		table_3d.add_child(movel_instance)
		cell.content = movel
		movel.cell = cell

func get_random_tasks(tasks_data: Dictionary) -> Array:
	var levels = tasks_data["levels"]
	var random_index = randi() % levels.size()
	return levels[random_index].get("tasks")

func get_task_object(movel_name: String, column: String, row: int, direction: String) -> Task:
	var task: Task = task_scene.instantiate() as Task
	task.movel_name = movel_name
	task.column = column
	task.row = row
	task.face_direction = direction
	return task

func fill_tasks_list() -> void:
	for task in tasks:
		tasks_list.add_child(task)

func check_victory_condition_2D() -> bool:
	var response = true
	for task in tasks:
		if task.task_2d_is_completed:
			continue
		var column = task.column
		var row = task.row - 1
		var direction = task.face_direction
		var cell = table.get_cell_at(row, get_column_index(column))

		if cell and cell.content:
			var movel = cell.content as Movel2D

			if movel.movel_name == task.movel_name and movel.face_front_by == get_direction_index(direction):
				movel.in_place()
				task.task_2d_complete()

		response = false

	return response

func check_victory_condition_3D() -> bool:
	var response = true
	for task in tasks:
		if task.task_3d_is_completed:
			continue
		var column = task.column
		var row = task.row - 1
		var direction = task.face_direction
		var cell = table_3d.get_cell_at(row, get_column_index(column))

		if cell and cell.content:
			var movel = cell.content as Movel3D

			if movel.movel_name == task.movel_name and movel.face_front_by == get_direction_index(direction):
				movel.in_place()
				task.task_3d_complete()

		response = false

	return response

func get_column_index(column: String) -> int:
	var column_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
	return column_letters.find(column)

func get_direction_index(direction: String) -> int:
	match direction:
		"N":
			return Movel2D.faces.NORTH
		"E":
			return Movel2D.faces.EAST
		"S":
			return Movel2D.faces.SOUTH
		"W":
			return Movel2D.faces.WEST

	return -1


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_countdown_time_over() -> void:
	await get_tree().create_timer(0.5).timeout
	cover_screen.show()
	loose_screen.show()
