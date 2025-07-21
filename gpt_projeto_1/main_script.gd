extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var viewport = get_viewport()
@onready var numeros: Label = $Control/numeros
var quantidade := 0


var cubo = preload("res://cubo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numeros.text = str(quantidade)
	# Isso garante que cada vez que você rodar o jogo, 
	# os valores aleatórios sejam realmente diferentes (senão, eles sempre saem igual na primeira vez).
	randomize()
		
func _on_timer_timeout() -> void:
	adiciona_cubo()
	
func adiciona_cubo() -> void:
	var cubo_instanciado: Node3D = cubo.instantiate()

	# Altura e profundidade fixas
	var altura_y = 6.0
	var profundidade_z = 0.0

	# 1. Gera um ponto aleatório na tela (coordenada X da viewport)
	var screen_x = randf_range(0, viewport.size.x)
	var screen_point = Vector2(screen_x, -viewport.size.y)
	
	# 2. Projeta o ponto para uma posição 3D na altura desejada
	var world_position = camera_3d.project_position(screen_point, altura_y)
	
	add_child(cubo_instanciado)

	# Define a posição do cubo
	cubo_instanciado.global_position = world_position
	
	# Adiciona uma rotação aleatória
	cubo_instanciado.rotation_degrees = Vector3(
		randf_range(0, 360),
		randf_range(0, 360),
		randf_range(0, 360)
	)

func _unhandled_input(event: InputEvent) -> void:
	# Se for um toque na tela ou clique do mouse
	if event is InputEventScreenTouch and event.pressed or \
	   event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		# Cria uma consulta de raycast
		var raycast_query = PhysicsRayQueryParameters3D.create(
			camera_3d.global_position,                      # Origem do raio (posição da câmera)
			camera_3d.project_ray_normal(event.position)    # Direção do raio (normalizada)
		)
		
		# Executa o raycast
		var space_state = get_world_3d().direct_space_state
		var raycast_result = space_state.intersect_ray(raycast_query)
		
		# Verifica se atingiu um cubo
		if raycast_result:
			var collider = raycast_result["collider"]
			if collider is RigidBody3D:
				quantidade += 1
				numeros.text = str(quantidade)
				collider.queue_free()
