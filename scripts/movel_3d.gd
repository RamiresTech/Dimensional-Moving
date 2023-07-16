extends StaticBody3D

class_name Movel3D

enum Faces {
	NORTH,
	EAST,
	SOUTH,
	WEST
}

@export var movel_name: String

@onready var movel_body: Node3D = $MovelBody
@onready var collision: CollisionShape3D = %CollisionShape3D
@onready var direction_indication: Sprite3D = %DirectionIndication
@onready var cell_name_label: Label3D = $CellName
@onready var done_checker: Sprite3D = %DoneChecker

var tween: Tween
var player_in_face: String = ""
var position_to_move: Vector3 = Vector3.ZERO

var CELL_TO_PUSH: Dictionary = {}

var CELL_TO_PULL: Dictionary = {}

var face_front_by: Faces = Faces.NORTH

var RIGHT_TURN_TO: Dictionary = {
	Faces.NORTH: Faces.EAST,
	Faces.EAST: Faces.SOUTH,
	Faces.SOUTH: Faces.WEST,
	Faces.WEST: Faces.NORTH
}

var LEFT_TURN_TO: Dictionary = {
	Faces.NORTH: Faces.WEST,
	Faces.WEST: Faces.SOUTH,
	Faces.SOUTH: Faces.EAST,
	Faces.EAST: Faces.NORTH
}

var cell: Cell = null:
	set(value):
		cell = value
		cell_name_label.text = cell.cell_name
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

var is_movable: bool = true

func _ready() -> void:
	var random_spin = randi_range(0, 10)

	for i in range(random_spin):
		turn_to_right()

func _process(delta: float) -> void:
	if player_in_face and is_movable:
		direction_indication.show()
		cell_name_label.show()
		if Input.is_action_just_pressed("action"):
			var actions = MainPlayer.actions
			match MainPlayer.selected_action:
				actions.PUSH:
					push_movel()
				actions.PULL:
					pull_movel()
				actions.TURN_TO_LEFT:
					turn_to_left()
				actions.TURN_TO_RIGHT:
					turn_to_right()
	else:
		direction_indication.hide()
		cell_name_label.hide()

func push_movel() -> void:
	var new_cell: Cell = CELL_TO_PUSH.get(player_in_face)
	if new_cell:
		chance_cell(new_cell)
		move_to_cell()

func pull_movel() -> void:
	var new_cell: Cell = CELL_TO_PULL.get(player_in_face)
	if new_cell:
		chance_cell(new_cell)
		move_to_cell()

func turn_to_right() -> void:
	face_front_by = RIGHT_TURN_TO.get(face_front_by)
	movel_body.rotate_y(deg_to_rad(-90))
	collision.rotate_y(deg_to_rad(-90))

func turn_to_left() -> void:
	face_front_by = LEFT_TURN_TO.get(face_front_by)
	movel_body.rotate_y(deg_to_rad(90))
	collision.rotate_y(deg_to_rad(90))

func chance_cell(new_cell: Cell) -> void:
	if !new_cell.content:
		cell.content = null
		new_cell.content = self
		cell = new_cell

func move_to_cell() -> void:
	tween = create_tween()
	var target_position = cell.position

	tween.tween_property(self, "position", target_position, 0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

func _on_face_north_body_entered(body: Node) -> void:
	if body is Player3D:
		player_in_face = "N"

func _on_face_south_body_entered(body: Node) -> void:
	if body is Player3D:
		player_in_face = "S"

func _on_face_east_body_entered(body: Node) -> void:
	if body is Player3D:
		player_in_face = "E"

func _on_face_west_body_entered(body: Node) -> void:
	if body is Player3D:
		player_in_face = "W"

func _on_face_body_exited(body: Node) -> void:
	if body is Player3D:
		player_in_face = ""

func in_place() -> void:
	is_movable = false
	done_checker.show()
