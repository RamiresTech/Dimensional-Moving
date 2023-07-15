extends Node2D

class_name LevelUm2D

@onready var table: Table2D = $Table2D
@onready var movel_template: PackedScene = preload("res://scenes/movel2D.tscn")

var selected_cells: Array

func _ready():
	selected_cells = []

	while selected_cells.size() < 5:
		var row = randi_range(0, 9)
		var col = randi_range(0, 9)
		var cell = table.get_cell_at(row, col)

		if cell and !selected_cells.has(cell):
			selected_cells.append(cell)

	for cell in selected_cells:
		var movel_instance = movel_template.instantiate()
		var movel = movel_instance as Movel2D
		movel.position = cell.position
		table.add_child(movel_instance)
		cell.content = movel
		movel.cell = cell
