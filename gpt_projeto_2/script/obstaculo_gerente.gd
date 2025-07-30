extends Node3D

const distancia_spawn := -35.0
@export var Obstaculos : Array[PackedScene] = []
const posicoes_linha := [2.0, 0.0, -2.0]

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_spawn_obstaculo_timeout() -> void:
	randomize()
	var obstaculo = Obstaculos[randi() % Obstaculos.size()]
	var helperObjtaculo = obstaculo.instantiate();
	if helperObjtaculo.tipo_do_objeto == Obstaculo.tipo.BAIXO:
		var obstaculo_instanciado = obstaculo.instantiate()
		add_child(obstaculo_instanciado)
		obstaculo_instanciado.position = Vector3(0 , 0, distancia_spawn)
	else:
		var linha_livre = randi() % 3
		for i in range(3):
			if i != linha_livre:
				var obstaculo_instanciado = obstaculo.instantiate()
				add_child(obstaculo_instanciado)
				obstaculo_instanciado.position = Vector3(posicoes_linha[i] , 0, distancia_spawn)
	
	#helperObjtaculo.queue_free()
