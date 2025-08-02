extends Node3D
const distancia_spawn := -50.0
@export var Obstaculos : Array[PackedScene] = []
var posicoes_linha := [2.0, 0.0, -2.0]
var posicao_livre_atual := 0.0
var posicao_livre_anterior := -99.0  # Valor inicial que não existe nas posições
var multiplicador_velocidade := .3

signal nova_linha_livre(linha : int)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_spawn_obstaculo_timeout() -> void:
	randomize()
	var obstaculo = Obstaculos[randi() % Obstaculos.size()]
	var helperObjstaculo = obstaculo.instantiate()
	
	if helperObjstaculo.tipo_do_objeto == Obstaculo.tipo.BAIXO:
		var obstaculo_instanciado = obstaculo.instantiate()
		add_child(obstaculo_instanciado)
		obstaculo_instanciado.position = Vector3(0, 0, distancia_spawn)
		obstaculo_instanciado.SPEED += multiplicador_velocidade + 1 
	else:
		var linha_livre : int = randi() % 3
		
		# CORREÇÃO: Verificar a posição atual contra a anterior
		while posicoes_linha[linha_livre] == posicao_livre_anterior:
			linha_livre = randi() % 3
		
		# Atualizar as variáveis de controle
		posicao_livre_atual = posicoes_linha[linha_livre]
		posicao_livre_anterior = posicao_livre_atual  # Guardar para próxima verificação
		
		nova_linha_livre.emit(posicao_livre_atual)
		
		# Spawnar obstáculos nas outras 2 lanes
		for i in range(3):
			if i != linha_livre:
				var obstaculo_instanciado = obstaculo.instantiate()
				add_child(obstaculo_instanciado)
				obstaculo_instanciado.position = Vector3(posicoes_linha[i], 0, distancia_spawn)
				obstaculo_instanciado.SPEED += multiplicador_velocidade + 1 
				
		
		# Shuffle após usar as posições
		posicoes_linha.shuffle()
	
	helperObjstaculo.queue_free()


func _on_cena_gerente_aumentar_multiplicador_velocidade(quant: float) -> void:
	multiplicador_velocidade += quant
