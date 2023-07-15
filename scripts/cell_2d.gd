extends Node2D
class_name Cell2D

@export var neighbourhood_north: Cell2D = null
@export var neighbourhood_east: Cell2D = null  # Right
@export var neighbourhood_south: Cell2D = null
@export var neighbourhood_west: Cell2D = null  # Left

var content = null
var cell_name: String
