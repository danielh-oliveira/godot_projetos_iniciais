extends Node3D

var tempo_vivo := 0
var moedas := 0
@onready var musiquinha: AudioStreamPlayer = $musiquinha

signal  aumentou_tempo_vivo(tempo : int)
signal  pegou_moeda(tempo : int)
signal aumentar_multiplicador_velocidade(quant : float)

func _ready() -> void:
	musiquinha.play(5.0)

func _on_tempo_vivo_timeout() -> void:
	tempo_vivo += 1
	aumentou_tempo_vivo.emit(tempo_vivo)

func _on_coin_gerente_pegou_moeda() -> void:
	moedas += 1
	pegou_moeda.emit(moedas)
	if moedas % 5 == 0:
		aumentar_multiplicador_velocidade.emit(0.5)


func _on_character_body_3d_morreu() -> void:
	GameData.passar_valores(tempo_vivo, moedas)
	get_tree().paused = true
	get_tree().change_scene_to_file("res://cena/final.tscn")
	pass # Replace with function body.
