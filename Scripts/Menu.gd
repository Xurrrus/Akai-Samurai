extends Node2D

func _ready():
	$VBoxContainer/VBoxContainer2/Start.grab_focus()

func _process(delta):
	global_var.reset()


#start per començar joc
func _on_Start_pressed():
	get_tree().change_scene("res://Escenes/Nivell1.tscn");

#options per anar a opcions
func _on_Options_pressed():
	get_tree().change_scene("res://Escenes/Opcions.tscn")

#exit per sortir
func _on_Exit_pressed():
	get_tree().quit()
