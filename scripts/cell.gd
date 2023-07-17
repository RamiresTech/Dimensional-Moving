extends Node
class_name Cell

@export var neighbourhood_north: Cell = null
@export var neighbourhood_east: Cell = null  # Right
@export var neighbourhood_south: Cell = null
@export var neighbourhood_west: Cell = null  # Left

var content = null
var cell_name: String
