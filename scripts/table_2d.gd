extends Node2D

class_name Table2D

@export var cell_template: PackedScene
@export var cell_size: float = 50.0

var cells: Array

var column_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]

func _ready():
	cells = []

	for row in range(10):
		var row_cells = []
		for col in range(10):
			var cell_instance = cell_template.instantiate()
			var cell = cell_instance as Cell2D
			cell.position = Vector2(col * cell_size, row * cell_size)
			cell.cell_name = get_cell_name(row, col)
			cell.name = get_cell_name(row, col)
			add_child(cell_instance)

			if row > 0:
				var north_cell = cells[row - 1][col]
				cell.neighbourhood_north = north_cell
				north_cell.neighbourhood_south = cell

			if col > 0:
				var west_cell = row_cells[col - 1]
				cell.neighbourhood_west = west_cell
				west_cell.neighbourhood_east = cell

			row_cells.append(cell)
		cells.append(row_cells)

func get_cell_at(row: int, col: int) -> Cell2D:
	if row >= 0 and row < 10 and col >= 0 and col < 10:
		return cells[row][col]
	else:
		return null

func get_cell_name(row: int, col: int) -> String:
	var column_letter = column_letters[col]
	var row_number = row + 1
	return column_letter + str(row_number)
