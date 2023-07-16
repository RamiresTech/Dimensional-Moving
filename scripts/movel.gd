extends StaticBody2D
class_name Movel2D


enum faces{
	NORTH,
	EAST,
	SOUTH,
	WEST
	}

@onready var movel_body: Sprite2D = %MovelBody
@export var movel_name: String

var tween: Tween
var player_in_face: String = ""
var position_to_move: Vector2 = Vector2.ZERO

var CELL_TO_PUSH: Dictionary = {}

var CELL_TO_PULL: Dictionary = {}

var face_front_by: faces = faces.NORTH

var RIGHT_TURN_TO: Dictionary = {
	faces.NORTH: faces.EAST,
	faces.EAST: faces.SOUTH,
	faces.SOUTH: faces.WEST,
	faces.WEST: faces.NORTH,
}

var LEFT_TURN_TO: Dictionary = {
	faces.NORTH: faces.WEST,
	faces.WEST: faces.SOUTH,
	faces.SOUTH: faces.EAST,
	faces.EAST: faces.NORTH,
}

var cell: Cell2D = null:
	set(value):
		cell = value
		if value:
			CELL_TO_PUSH = {
				"N": value.neighbourhood_south,
				"S": value.neighbourhood_north,
				"E": value.neighbourhood_west,
				"W": value.neighbourhood_east
			}

			CELL_TO_PULL = {
				"S": value.neighbourhood_south,
				"N": value.neighbourhood_north,
				"W": value.neighbourhood_west,
				"E": value.neighbourhood_east
			}

func _ready() -> void:
	var random_spin = randi_range(0, 10)

	for i in range(random_spin):
		turn_to_right()

func _process(delta: float) -> void:
	if player_in_face:
		if Input.is_action_just_pressed("push"):
			push_movel()

		elif Input.is_action_just_pressed("pull"):
			pull_movel()

		elif Input.is_action_just_pressed("turn_right"):
			turn_to_right()

		elif Input.is_action_just_pressed("turn_left"):
			turn_to_left()

func push_movel() -> void:
	var new_cell: Cell2D = CELL_TO_PUSH.get(player_in_face)
	if new_cell:
		chance_cell(new_cell)
		move_to_cell()

func pull_movel() -> void:
	var new_cell: Cell2D = CELL_TO_PULL.get(player_in_face)
	if new_cell:
		chance_cell(new_cell)
		move_to_cell()

func turn_to_right() -> void:
	face_front_by = RIGHT_TURN_TO.get(face_front_by)
	movel_body.rotate(deg_to_rad(90))

func turn_to_left() -> void:
	face_front_by = RIGHT_TURN_TO.get(face_front_by)
	movel_body.rotate(deg_to_rad(-90))

func chance_cell(new_cell: Cell2D) -> void:
	if not new_cell.content:
		cell.content = null
		cell = new_cell
		cell.content = self

func move_to_cell() -> void:
	tween = create_tween()
	var target_position = cell.position

	tween.tween_property(self, "position", target_position, 0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)


func _on_face_north_body_entered(body: Node2D) -> void:
	if body is Player2D:
		player_in_face = "N"


func _on_face_south_body_entered(body: Node2D) -> void:
	if body is Player2D:
		player_in_face = "S"


func _on_face_east_body_entered(body: Node2D) -> void:
	if body is Player2D:
		player_in_face = "E"


func _on_face_west_body_entered(body: Node2D) -> void:
	if body is Player2D:
		player_in_face = "W"


func _on_face_body_exited(body: Node2D) -> void:
	if body is Player2D:
		player_in_face = ""
