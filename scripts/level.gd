extends Node2D

class_name LevelUm2D

@onready var table: Table2D = $Level_2D/Table2D
@onready var task_scene: PackedScene = preload("res://scenes/task.tscn")
@onready var movel_template: PackedScene = preload("res://scenes/movel2D.tscn")
@onready var tasks_list: VBoxContainer = %TaskList

const TASKS_FILE_PATH = "res://tasks.json"

var selected_cells: Array
var tasks: Array[Task]

func _ready():
	var tasks_data = get_tasks_data_from_json_file()
	var tasks_informations = get_random_tasks(tasks_data)

	for task in tasks_informations:
		tasks.append(
			get_task_object(task[0], task[1], task[2], task[3])
		)
	fill_tasks_list()
	select_random_cells(tasks.size())

	for index in range(tasks.size()):
		var cell = selected_cells[index]
		var task = tasks[index] as Task
		var movel_instance = task.moveis_2d.get(task.movel_name).instantiate()
		var movel = movel_instance as Movel2D
		movel.position = cell.position
		table.add_child(movel_instance)
		cell.content = movel
		movel.cell = cell

func get_tasks_data_from_json_file() -> Dictionary:
	var file = FileAccess.open(TASKS_FILE_PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	return JSON.parse_string(json_string)

func select_random_cells(amount_of_cells_to_select: int) -> void:
	selected_cells = []

	while selected_cells.size() < amount_of_cells_to_select:
		var row = randi_range(0, 9)
		var col = randi_range(0, 9)
		var cell = table.get_cell_at(row, col)

		if cell and !selected_cells.has(cell):
			selected_cells.append(cell)

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
