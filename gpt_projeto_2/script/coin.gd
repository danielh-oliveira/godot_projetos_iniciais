extends Area3D
class_name Coin

enum tipo {COIN, POWERUP}
@export var tipo_do_objeto : tipo = tipo.COIN
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var SPEED = 10

func _ready() -> void:
	animation_player.play("moeda_idle")
	get_tree().current_scene.aumentar_multiplicador_velocidade.connect(_on_aumentar_velocidade)

func _process(delta: float) -> void:
	if position.z > 10:
		queue_free()

func _physics_process(delta: float) -> void:
	position.z += SPEED * delta

func _on_body_entered(body: Node3D) -> void:
	get_parent().pegou_moeda.emit()
	queue_free()

func _on_aumentar_velocidade(quantiade: float) -> void:
	SPEED += quantiade
