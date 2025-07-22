extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var viewport = get_viewport()
@onready var numeros: Label = $"info cliques/numeros"

var quantidade := 0
var quantidade_anterior := 0
var clicou := false
var aumentou_velocidade := false
var velocidade_atual := 0.3

var cubo = preload("res://cubo.tscn")
var mensagem_aviso = preload("res://boasorte.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numeros.text = str(quantidade)
	# Isso garante que cada vez que você rodar o jogo, 
	# os valores aleatórios sejam realmente diferentes (senão, eles sempre saem igual na primeira vez).
	randomize()
		
func _on_timer_timeout() -> void:
	adiciona_cubo()
	
func adiciona_aviso_velocidade() -> void:
	var msg_instancia = mensagem_aviso.instantiate()
	msg_instancia.mensagem = "MAIS RAPIDO!"
	add_child(msg_instancia)
	
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
	
	if quantidade >= quantidade_anterior + 5:
		quantidade_anterior = quantidade
		cubo_instanciado.gravity_scale = velocidade_atual + 0.2
		velocidade_atual = cubo_instanciado.gravity_scale
		aumentou_velocidade = true
		adiciona_aviso_velocidade()
	else:
		cubo_instanciado.gravity_scale = velocidade_atual
	
	add_child(cubo_instanciado)

	# Define a posição do cubo
	cubo_instanciado.global_position = world_position
	
	# Adiciona uma rotação aleatória
	cubo_instanciado.rotation_degrees = Vector3(
		randf_range(0, 360),
		randf_range(0, 360),
		randf_range(0, 360)
	)
	


func _process(delta: float) -> void:
	if aumentou_velocidade:
		pass
	pass

func _physics_process(delta: float) -> void:
	if clicou:
		clicou = false
		# Obtém o estado atual do espaço 3D para fazer consultas de física
		var space_state := get_world_3d().direct_space_state
		
		# Obtém a posição atual do mouse na janela de visualização (em pixels)
		var mousepos := get_viewport().get_mouse_position()
		
		# Calcula o ponto de ORIGEM do raio no mundo 3D baseado na posição do mouse
		# (Converte coordenada 2D do mouse para um ponto 3D na câmera)
		var origin := camera_3d.project_ray_origin(mousepos)
		
		# Calcula o ponto FINAL do raio:
		# 1. Obtém a direção normalizada do raio a partir da câmera
		# 2. Multiplica pela extensão máxima do raio (RAY_LENGTH)
		# 3. Soma com a origem para obter o ponto final no mundo 3D
		var end := origin + camera_3d.project_ray_normal(mousepos) * 1000.0
		
		# Cria os parâmetros para a consulta de raycast físico:
		# - Define os pontos de início (origin) e fim (end) do raio
		var query := PhysicsRayQueryParameters3D.create(origin, end)

		# Configura se o raycast deve detectar colisões com ÁREAS (Area3D):
		# - false = detecta apenas corpos físicos (PhysicsBody3D como StaticBody, RigidBody)
		# - true = detecta tanto corpos físicos quanto áreas
		#query.collide_with_areas = false
		
		# Executa efetivamente o raycast com os parâmetros configurados
		# Retorna um dicionário com informações da colisão ou vazio se não houve colisão
		var result = space_state.intersect_ray(query)
		
		if result:
			quantidade += 1
			numeros.text = str(quantidade)
			result.collider.queue_free()
			
func _unhandled_input(event: InputEvent) -> void:
	# Se for um toque na tela ou clique do mouse
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		clicou = true
