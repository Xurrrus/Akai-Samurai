extends KinematicBody2D

#per girar sprite de l'esquelet
var esquerra = true

var iniciat = false
var gravetat = 10 
var direccio = Vector2(0,0) #sentit en el que va 
var vides = 3
 
var velocitat = 32

#esquelet camina
func _ready():
	$AnimationPlayer.play("caminar")
	
	
func _process(delta):
	
	#si ataca o rep cop es para i no avaná nomes fa l'animació
	if $AnimationPlayer.current_animation == "atacar":
		return
	if $AnimationPlayer.current_animation == "hit":
		return
	#si mor
	if vides <=0:
		if iniciat:
			 morir()#metode de morir 
		else:
			 iniciat = true 
			 $Timer.start()
			
		if $Timer.is_stopped(): #quan el timer arriba a 0 s'esborra l'esquelet i es para el process
			get_parent().remove_child(self)
			set_process(false)
		else:
			pass
	
	#moure i detectarquan ha de girar
	move_character()
	detect_turn_arround()
	
#moure el personatge
func move_character():
	direccio.x = -velocitat if esquerra else velocitat	
	
	direccio.y +=gravetat
	
	direccio = move_and_slide(direccio,Vector2.UP)		

#detectar quan gira el personatge fent que si la fletxa del raycast no colisiona mentre estigui al terra giri el sprite
func detect_turn_arround():
	if not $RayCast2D.is_colliding() and is_on_floor():
		esquerra = !esquerra
		scale.x = -scale.x




#per apagar i encendre area de hit per a que no detecti sempre que el jugador esta en aquesta
func hit():
	$hit_jug.monitoring = true
	
func final_hit():
	$hit_jug.monitoring = false
	
	

func caminar():#caminar
	$AnimationPlayer.play("caminar")



func _on_detector_jug_body_entered(body):#animacio atacar
	$AnimationPlayer.play("atacar")


func _on_hit_jug_body_entered(body):
	#hit al jugador de part d'un enemic
	#agafem el path i el numero de l'escena actual per saber si es un hit al nivell1 o al nivell2
	var jug = get_node("/root/Nivell" + str(int(get_tree().current_scene.name)) + "/Personatge")
	jug._tocat = true
	global_var.vides-=1
	print(global_var.vides)
	


func _on_dany_enemic_body_entered(body):
	if body.name == "Personatge": #animació de hit i resta una vida
		$AnimationPlayer.play("hit")
		vides-=1
	


func _on_dany_enemic_body_exited(body):
	if body.name == "Personatge":#si es personatge para i comença animació de caminar
		$AnimationPlayer.stop()
		$AnimationPlayer.play("caminar")
		
		
func morir():
	#comença animació de morir
	$AnimationPlayer.play("morir")





func _on_dany_enemic_area_entered(area):
	#quan entra espasa
	if area.name == "espasa": #animació de hit i resta una vida
		$AnimationPlayer.play("hit")
		vides-=1


func _on_dany_enemic_area_exited(area):
	if area.name == "espasa":#si es personatge para i comença animació de caminar
		$AnimationPlayer.stop()
		$AnimationPlayer.play("caminar")
