extends Control

@onready var tempo_label: Label = $VBoxContainer/Label2
@onready var moeda_label: Label = $VBoxContainer/Label3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	tempo_label.text = "Tempo vivo: " + str(GameData.tempo)
	moeda_label.text = "Moedas coletadas: " + str(GameData.moedas)
	Input.vibrate_handheld(500)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cena/main.tscn")
	pass # Replace with function body.
