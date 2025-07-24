extends RigidBody3D

@onready var gato_preto_1: Node3D = $gatoPreto1
@onready var gato_preto_2: Node3D = $gatoPreto2
@onready var gato_preto_3: Node3D = $gatoPreto3

var velocidade_rotacao: Vector3
var modelos: Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modelos = [gato_preto_1, gato_preto_2, gato_preto_3]
	modelos[randi_range(0, modelos.size() -1)].visible = true;
		# Define velocidade de rotação aleatória quando o cubo é criado
	velocidade_rotacao = Vector3(
		randf_range(-2.0, 2.0),
		randf_range(-2.0, 2.0), 
		randf_range(-2.0, 2.0)
	)
	
	# Aplica a velocidade angular
	angular_velocity = velocidade_rotacao


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.y < -15:
		get_parent().notifica_morte_gato()
		queue_free()
