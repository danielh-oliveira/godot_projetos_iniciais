extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var puff_som: AudioStreamPlayer = $puff_som

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("puff_pop")
	randomize()
	puff_som.pitch_scale = randf_range(1.0, 3.0)
	puff_som.play(4.4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if puff_som.get_playback_position() >= 4.75:
		puff_som.stop()

	if !animation_player.is_playing():
		queue_free()
	pass
