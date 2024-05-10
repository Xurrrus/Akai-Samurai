extends KinematicBody2D


const GRAVITY := 20  #gravetat
const ACCEL := 40  #acceleració
const MAX_SPEED := 400 #velocitat max
const JUMP := -550 #vel salt

var temps = 0

var _posIni:Vector2 # posició inicial al nivell
var _moviment := Vector2() 
var _personatge:AnimatedSprite
var _tocat := false


func _ready():
	_personatge = $animacions_personatge # àlies
	_posIni = self.position #pos ini
	$morir.visible = not $morir.visible #sprite passa a no visible


func _physics_process(delta:float):
	_moviment.y += GRAVITY  # efecte de gravetat
	var friccio:= false # en principi, no sotmés a fricció
	if Input.is_action_pressed("ui_right"): #movem a la dreta
		_moviment.x = min(_moviment.x + ACCEL, MAX_SPEED) # accel. amb límit
		_personatge.flip_h = false
		_personatge.play("correr")
	elif Input.is_action_pressed("ui_left"):#movem a l'esquerra
		_moviment.x = max(_moviment.x - ACCEL, -MAX_SPEED) # accel. amb límit
		_personatge.flip_h = true
		_personatge.play("correr")
	elif Input.is_action_pressed("ui_attack"):#cliquem ratolí clic esq
		_personatge.play("atacar")
		$espasa.monitoring = true
		$espasa.monitorable = true
		$espasa/CollisionShape2D.disabled = false
		$espasa/CollisionShape2D2.disabled = false
	else:
		friccio = true # activem la fricció
		_personatge.play("idle")
		
	# quan anem rebent cops es treuen els cors. 	
	if global_var.vides == 2:
			$Cors.hide()
	if global_var.vides == 1:
			$Cors2.hide()	
	if global_var.vides == 0:
			$Cors3.hide()
	
	if is_on_floor():  # només té efecte si està a terra
		
		if Input.is_action_just_pressed("ui_up"):
			_moviment.y = JUMP
		if friccio: # efecte fricció (amb interpolació lineal)
			_moviment.x = 0 
	else:  # no és a terra
		if _moviment.y < 0:  # està anant amunt
			
			_personatge.play("saltar") # animació cap amunt
		elif _moviment.y > 0: # està caient
			_personatge.play("caure") # animació cap avall
			
	
	_moviment = move_and_slide(_moviment, Vector2.UP) # indiquem vector normal
	if $espasa.monitoring == true:
		temps +=delta
		if temps > 0.5:
			$espasa.monitoring = false
			$espasa.monitorable = false
			$espasa/CollisionShape2D.disabled = true
			$espasa/CollisionShape2D2.disabled = true
			temps = 0
	
	#quan arriba a 0 vides
	if global_var.vides <= 0:
		morir()
		
	if _tocat:
		#activa animació de hit
		_personatge.play("hit")
		_tocat = false


 


func morir(): 
	#es desactiven els sprites dels cors quan es mor
	$Cors.hide()
	$Cors3.hide()
	$Cors2.hide()
	$Timer.start() #activa timer
	$morir.visible = true #activa sprite amb animacio de morir
	$animacions_personatge.visible = false #desactiva sprite amb animacions que moviem fins ara
	$morir/AnimationPlayer.play("Morir") #activa animació morir
	set_physics_process(false)#desactiva physyics process
	_personatge.stop() 
		

func _on_Timer_timeout():
	get_tree().change_scene("res://Escenes/Menu.tscn") #tornem al menú
