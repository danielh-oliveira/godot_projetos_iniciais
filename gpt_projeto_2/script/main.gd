extends Node3D

var tempo_vivo := 0
var moedas := 0
var velocidade_atual := 10

signal  aumentou_tempo_vivo(tempo : int)
signal  pegou_moeda(tempo : int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tempo_vivo_timeout() -> void:
	tempo_vivo += 1
	aumentou_tempo_vivo.emit(tempo_vivo)
	if tempo_vivo % 10 == 0:
		velocidade_atual += 3
		for obstaculo in get_node("ObstaculoGerente").get_children():
			if obstaculo is Obstaculo:
				obstaculo.SPEED = velocidade_atual
		for coin in get_node("CoinGerente").get_children():
			if coin is Coin:
				coin.SPEED = velocidade_atual
		print("aumentando velocidade")



func _on_coin_body_entered(body: Node3D) -> void:
	moedas += 1
	pegou_moeda.emit(moedas)


func _on_coin_gerente_pegou_moeda() -> void:
	moedas += 1
	pegou_moeda.emit(moedas)
