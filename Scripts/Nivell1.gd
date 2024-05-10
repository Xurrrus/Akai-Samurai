extends Node

#quan queiem per el buit reiniciem escena
func _on_area_caiguda_body_entered(body):
	global_var.vides-=1
	get_tree().reload_current_scene()
	
	
