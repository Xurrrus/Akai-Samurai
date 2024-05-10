tool #per executar en mode editor el codi
extends TextureButton

#var que guarda el text del botó
export var text = "Text button"
#espai entre espasa i espasa
export var marge_espasa_centre = 100


func _ready():
	setup_text()
	set_focus_mode(true)


func _process(delta):
	if Engine.editor_hint:#si estem en mode editor
		setup_text()
		amagar_espases()



func setup_text():
	$RichTextLabel.bbcode_text = "[center]" + text + "[/center]" #posem el text que tenim al export var
	

func mostrar_espases():
	for espasa in [$espasa_esquerra,$espasa_dreta]: #per cada espasa
		espasa.visible = true#mostrem
		espasa.global_position.y = rect_global_position.y + (rect_size.y / 3.0)#agafem pos global respecte texture button
		
	var centre_x = rect_global_position.x + (rect_size.x / 2) #centre 
	$espasa_esquerra.global_position.x = centre_x - marge_espasa_centre #un costat i l'altre abaix
	$espasa_dreta.global_position.x = centre_x + marge_espasa_centre


func amagar_espases(): #amagar espases quan no s'han de veure
	for espasa in [$espasa_esquerra,$espasa_dreta]:
		espasa.visible = false

#quan fem focus al botó apareixen les espases
func _on_TextureButton_focus_entered():
	mostrar_espases()

#amagar-les quan deixem de fer focus
func _on_TextureButton_focus_exited():
	amagar_espases()

#quan el retoli passa per sobre botó agafa focus.
func _on_TextureButton_mouse_entered():
	grab_focus()
