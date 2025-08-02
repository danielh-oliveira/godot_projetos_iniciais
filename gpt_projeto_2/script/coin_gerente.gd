extends Node3D

@onready var shape_cast_3d: ShapeCast3D = $ShapeCast3D

@export var pegaveis : Array[PackedScene] = []

var distancia_spawn := -35.0
const posicoes_linha := [2.0, 0.0, -2.0]
var posicao_linha_livre := 0.0
var multiplicador_velocidade := 0.3
signal pegou_moeda

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tempo_moeda_timeout() -> void:
	randomize()
	
	if shape_cast_3d.is_colliding():
		distancia_spawn = -55
	else:
		distancia_spawn = -50
	
	var pegavel = pegaveis[randi() % pegaveis.size()]
	var helperPegavel = pegavel.instantiate();
	if helperPegavel.tipo_do_objeto == Coin.tipo.COIN:
		var linha_livre = randi() % 3
		while posicao_linha_livre == posicoes_linha[linha_livre]:
			linha_livre = randi() % 3
		var pegavel_instanciado = pegavel.instantiate()
		add_child(pegavel_instanciado)
		pegavel_instanciado.position = Vector3(posicoes_linha[linha_livre] , 0, distancia_spawn)
		pegavel_instanciado.SPEED += multiplicador_velocidade + 1
				
	helperPegavel.queue_free()
	


func _on_obstaculo_gerente_nova_linha_livre(linha: int) -> void:
	posicao_linha_livre = linha


func _on_cena_gerente_aumentar_multiplicador_velocidade(quant: float) -> void:
	multiplicador_velocidade += quant
	pass # Replace with function body.
