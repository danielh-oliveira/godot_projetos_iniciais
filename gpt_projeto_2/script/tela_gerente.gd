extends Control

@onready var tempo_vivo: Label = $TempoVivo
@onready var moedas: Label = $Moedas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cena_gerente_aumentou_tempo_vivo(tempo: int) -> void:
	tempo_vivo.text = "Tempo vivo: " + str(tempo)
	pass # Replace with function body.


func _on_cena_gerente_pegou_moeda(tempo: int) -> void:
	moedas.text = "Moedas: " + str(tempo)
	pass # Replace with function body.
