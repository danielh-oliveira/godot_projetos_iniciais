extends CharacterBody3D


const SPEED := 8.0
const JUMP_VELOCITY = 4.5

enum linha {ESQUERDA = -2, MEIO = 0, DIREITA = 2}

var linha_atual = linha.MEIO
var linha_desejada := 0.0

func _physics_process(delta: float) -> void:
	print(position.z) #quando toco no obstaculo baixo e pulo o player começa a ficar com a posição z negativa
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	linha_atual = position.x

	if Input.is_action_just_pressed("ui_left"):
		if linha_desejada != linha.ESQUERDA:
			linha_desejada -= 2.0;
		
	if Input.is_action_just_pressed("ui_right"):
		if linha_desejada != linha.DIREITA:
			linha_desejada += 2.0;
			
	position.x = lerp(position.x, linha_desejada, SPEED * delta)


	move_and_slide()
