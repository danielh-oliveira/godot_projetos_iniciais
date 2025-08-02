extends Node

var tempo := 0
var moedas := 0

func passar_valores(tempo_vivo : int, moedas_total:int) -> void:
	tempo = tempo_vivo
	moedas = moedas_total

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
