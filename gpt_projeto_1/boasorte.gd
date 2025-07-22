extends Control

@onready var timer: Timer = $Timer
@export var mensagem := "BOA SORTE!!"
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = mensagem
	timer.start()
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
	# Balanço com rotação
	tween.tween_property(self, "rotation_degrees", -15, 0.1)
	tween.tween_property(self, "rotation_degrees", 15, 0.2)
	tween.tween_property(self, "rotation_degrees", -10, 0.15)
	tween.tween_property(self, "rotation_degrees", 10, 0.15)
	tween.tween_property(self, "rotation_degrees", 0, 0.1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	visible = false
