extends HBoxContainer
class_name Task

@onready var movel_image: TextureRect = %MovelImage
@onready var direction_image: TextureRect = %DirectionImage
@onready var column_label: Label = %ColumnLabel
@onready var row_label: Label = %RowLabel
@onready var check_2d: CheckBox = %"2DCheckBox"
@onready var check_3d: CheckBox = %"3DCheckBox"

var directions: Dictionary = {
	"N": preload("res://assets/sprites/GUI/Directions/arrowUp.png"),
	"E": preload("res://assets/sprites/GUI/Directions/arrowRight.png"),
	"S": preload("res://assets/sprites/GUI/Directions/arrowDown.png"),
	"W": preload("res://assets/sprites/GUI/Directions/arrowLeft.png")
}

var moveis_images: Dictionary = {
	"poltrona_vermelha": preload("res://assets/sprites/moveis_images/loungeChair.png"),
}

var moveis_2d: Dictionary = {
	"poltrona_vermelha": preload("res://scenes/poltrona_vermelha.tscn"),

}

var moveis_3d: Dictionary = {
	"poltrona_vermelha": preload("res://scenes/poltrona_vermelha.tscn"),

}

#enum movel{
#	SOFA_VERMELHO,
#	POLTRONA_VERMELHA,
#	CADEIRA,
#	MESA,
#	MESINHA_DE_CENTRO,
#	FOGAO,
#	BALCAO
#}

@export var column: String = "A"
@export var row: int = 1
@export var face_direction: String = "N"
@export var movel_name: String = "poltrona_vermelha"

var task_2d_is_completed: bool = false
var task_3d_is_completed: bool = false

var column_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]


func _ready() -> void:
	column_label.text = column
	row_label.text = str(row)
	movel_image.texture = moveis_images.get(movel_name)
	direction_image.texture = directions.get(face_direction)



func _process(delta: float) -> void:
	pass

func get_random_number() -> int:
	return (randi() % 10) + 1

func get_random_letter() -> String:
	return column_letters[randi() % 10]

