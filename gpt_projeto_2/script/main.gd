extends Node3D

var tempo_vivo := 0
signal  aumentou_tempo_vivo(tempo : int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tempo_vivo_timeout() -> void:
	tempo_vivo += 1
	aumentou_tempo_vivo.emit(tempo_vivo)
