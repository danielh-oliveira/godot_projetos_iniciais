extends CharacterBody3D
signal morreu

var SPEED := 8.0
const JUMP_VELOCITY = 4.5
enum linha {ESQUERDA = -2, MEIO = 0, DIREITA = 2}
var linha_atual = linha.MEIO
var linha_desejada := 0.0

# Variáveis para controle de touch
var touch_start_position: Vector2
var is_touching := false
var touch_threshold := 50.0  # Distância mínima para reconhecer o drag

func _ready():
	# Conecta os sinais de input
	pass

func _input(event):
	# Detecta início do toque
	if event is InputEventScreenTouch:
		if event.pressed:
			touch_start_position = event.position
			is_touching = true
		else:
			is_touching = false
	
	# Detecta movimento do drag
	elif event is InputEventScreenDrag and is_touching:
		var drag_distance = event.position - touch_start_position
		# Verifica se o drag foi suficiente para triggerar uma ação
		if abs(drag_distance.x) > touch_threshold or abs(drag_distance.y) > touch_threshold:
			# Determina a direção principal do drag
			if abs(drag_distance.x) > abs(drag_distance.y):
				# Movimento horizontal
				if drag_distance.x > 0:
					# Drag para direita
					move_right()
				else:
					# Drag para esquerda
					move_left()
			else:
				# Movimento vertical
				if drag_distance.y < 0:
					# Drag para cima (pulo)
					jump()
			
			# Reset para evitar múltiplas ações do mesmo drag
			is_touching = false

func move_left():
	if linha_desejada != linha.ESQUERDA:
		linha_desejada -= 2.0

func move_right():
	if linha_desejada != linha.DIREITA:
		linha_desejada += 2.0

func jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	if position.z > 0.3:
		morreu.emit()
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		linha_atual = position.x
		position.x = lerp(position.x, linha_desejada, SPEED * delta)
		move_and_slide()
