extends Control
@onready var quantidade_gatinhos: Label = $quantidade_gatinhos
@onready var morreu: AudioStreamPlayer = $morreu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quantidade_gatinhos.text = str(Global.quantidade_gatos)
	Input.vibrate_handheld(1000)
	morreu.play(1.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_reset_pressed() -> void:
	Global.quantidade_gatos = 0;
	get_tree().change_scene_to_file("res://main.tscn")
