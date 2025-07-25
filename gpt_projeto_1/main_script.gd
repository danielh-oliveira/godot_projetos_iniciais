extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var viewport = get_viewport()
@onready var numeros: Label = $"info cliques/numeros"
@onready var perdidos: Label = $"info cliques/perdidos"
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var trilha: AudioStreamPlayer = $trilha
var mostrou_perdeu := false

var quantidade := 0
var morte_gatos := 10
var clicou := false
var aumentou_velocidade := false
var velocidade_base := 0.3
var velocidade_atual := 0.3
var posicao_toque := Vector2.ZERO

const tipos_de_miado_inicio := [0.24, 3.05, 5.29, 7.45]
const tipos_de_miado_final := [1.18, 4.01, 6.25, 8.28]
var miado_escolhido := 0

# Sistema de progressão de velocidade
var limites_velocidade := [5, 10, 20, 35, 50, 70, 95, 125, 160, 200]
var incremento_velocidade := 0.25
var nivel_velocidade_atual := 0

var cubo = preload("res://cubo.tscn")
var mensagem_aviso = preload("res://boasorte.tscn")
var puff = preload("res://puff_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perdidos.text = str(morte_gatos)
	numeros.text = str(quantidade)
	velocidade_atual = velocidade_base
	trilha.play(50.50)

func notifica_morte_gato() -> void:
	morte_gatos -= 1
	if morte_gatos >= 0:
		perdidos.text = str(morte_gatos)
		# Escala normal
		perdidos.scale = Vector2.ONE
		
		# Estudar para entender o tween melhor
		var tween = get_tree().create_tween()
		# Aumenta suavemente
		tween.tween_property(perdidos, "scale", Vector2(1.1, 1.1), 0.10).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		# Depois diminui suavemente
		tween.tween_property(perdidos, "scale", Vector2(1.0, 1.0), 0.10).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		
func _on_timer_timeout() -> void:
	adiciona_cubo()

func verifica_aumento_velocidade() -> bool:
	# Verifica se ainda existem níveis para aumentar
	if nivel_velocidade_atual >= limites_velocidade.size():
		return false
	
	# Verifica se atingiu o próximo limite
	var proximo_limite = limites_velocidade[nivel_velocidade_atual]
	if quantidade >= proximo_limite:
		nivel_velocidade_atual += 1
		velocidade_atual += incremento_velocidade
		return true
	
	return false

func adiciona_aviso_velocidade() -> void:
	var msg_instancia = mensagem_aviso.instantiate()
	
	# Vibração tátil para aumentar o feedback
	# Vibração mais intensa conforme o nível aumenta
	var duracao_vibracao = min(200 + (nivel_velocidade_atual * 50), 500) # 200ms base + 50ms por nível (máx 500ms)
	Input.vibrate_handheld(duracao_vibracao)
	
	# Mensagem mais informativa baseada no nível
	match nivel_velocidade_atual:
		1:
			msg_instancia.mensagem = "VELOCIDADE +!"
		2:
			msg_instancia.mensagem = "MAIS RÁPIDO!"
		3:
			msg_instancia.mensagem = "ACELERANDO!"
		4:
			msg_instancia.mensagem = "MUITO RÁPIDO!"
		5:
			msg_instancia.mensagem = "SUPER VELOCIDADE!"
		6:
			msg_instancia.mensagem = "HIPER VELOCIDADE!"
		7:
			msg_instancia.mensagem = "MÁXIMA VELOCIDADE!"
		8:
			msg_instancia.mensagem = "IMPOSSÍVEL!"
		_:
			msg_instancia.mensagem = "INSANO!"
	
	add_child(msg_instancia)

func adiciona_cubo() -> void:
	# Isso garante que cada vez que você rodar o jogo, 
	# os valores aleatórios sejam realmente diferentes (senão, eles sempre saem igual na primeira vez).
	randomize()
	
	var cubo_instanciado: Node3D = cubo.instantiate()

	# CORREÇÃO: Método mais direto para posicionamento uniforme
	# Gera posição X aleatória diretamente no espaço 3D
	var largura_mundo = 6.0 # Ajuste conforme necessário para sua tela
	var pos_x = randf_range(-largura_mundo / 2, largura_mundo / 2)
	
	# Altura fixa onde os cubos aparecem
	var altura_y = 8.5
	
	# Profundidade aleatória
	var profundidade_z = randf_range(0.0, -10.0)
	
	# Ajuste de altura baseado na profundidade (como você tinha)
	if profundidade_z < -5.0:
		altura_y += 5.0
	
	# Define a posição final
	var world_position = Vector3(pos_x, altura_y, profundidade_z)
	
	if verifica_aumento_velocidade():
		aumentou_velocidade = true
		adiciona_aviso_velocidade()
	
	# Define a velocidade do cubo (sempre usa a velocidade atual)
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
		aumentou_velocidade = false # Reset da flag

	if audio_stream_player.playing:
		if audio_stream_player.get_playback_position() >= tipos_de_miado_final[miado_escolhido]:
			audio_stream_player.stop()
			
	if trilha.get_playback_position() >= 94.0:
		trilha.stop()
		trilha.play(20.0)
		
	if morte_gatos == 0:
		fim_jogo()

func _physics_process(delta: float) -> void:
	if clicou:
		clicou = false
		# Obtém o estado atual do espaço 3D para fazer consultas de física
		var space_state := get_world_3d().direct_space_state
		
		# Obtém a posição atual do mouse na janela de visualização (em pixels)
		#var mousepos := get_viewport().get_mouse_position()
		var mousepos : Vector2 = posicao_toque
		
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
			
			var tween = get_tree().create_tween()
			# Aumenta suavemente
			tween.tween_property(numeros, "scale", Vector2(1.05, 1.05), 0.10).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			# Depois diminui suavemente
			tween.tween_property(numeros, "scale", Vector2(1.0, 1.0), 0.10).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			
			miado_escolhido = randi_range(0, tipos_de_miado_inicio.size() - 1)
			audio_stream_player.play(tipos_de_miado_inicio[miado_escolhido])
			audio_stream_player.pitch_scale = randf_range(0.5, 2.5)
			Input.vibrate_handheld(50, 0.1)
			
			var pufie = puff.instantiate()
			add_child(pufie)
			pufie.global_position = mousepos
			
			result.collider.queue_free()
			
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		clicou = true;
		posicao_toque = event.position
	pass
#func _unhandled_input(event: InputEvent) -> void:
	## Se for um toque na tela ou clique do mouse
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#clicou = true
	#if event is InputEventScreenDrag and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#clicou = true

func fim_jogo() -> void:
	if !mostrou_perdeu:
		mostrou_perdeu = true
		
		# Pausa o jogo
		get_tree().paused = true
		
		var msg_instancia = mensagem_aviso.instantiate()
		msg_instancia.mensagem = "PERDEU!!"
		# Define que a mensagem pode processar mesmo com o jogo pausado
		msg_instancia.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		add_child(msg_instancia)
		trilha.stop()
		
		var timer = Timer.new()
		timer.wait_time = 1.0
		timer.one_shot = true
		timer.timeout.connect(_on_timer_final)
		# Define que o timer pode processar mesmo com o jogo pausado
		timer.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		add_child(timer)
		timer.start()

func _on_timer_final() -> void:
	Global.quantidade_gatos = quantidade
	
	# Despausa o jogo antes de mudar de cena (opcional, mas boa prática)
	get_tree().paused = false
	
	var fim_jogo_scene = preload("res://fim_jogo_menu.tscn")
	get_tree().change_scene_to_packed(fim_jogo_scene)
