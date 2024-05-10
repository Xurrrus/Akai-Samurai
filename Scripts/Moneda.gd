extends Area2D
class_name Moneda


var ruta 

#per fer animació de moneda
func _process(delta):
	$AnimationPlayer.play("Moure_moneda")

#si es el personatge, canviem escena
func _on_Moneda_body_entered(body):
	if body.name == "Personatge":
		var ruta = global_var.passar_nivell()
		get_tree().change_scene(ruta)
