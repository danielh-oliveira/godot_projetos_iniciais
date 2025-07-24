extends Control
@onready var quantidade_gatinhos: Label = $quantidade_gatinhos


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quantidade_gatinhos.text = str(Global.quantidade_gatos)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
