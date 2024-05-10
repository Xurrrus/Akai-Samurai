extends Node


var vides = 3
var _nivells :=  ["res://Escenes/Nivell2.tscn","res://Escenes/Nivell3.tscn","res://Escenes/Menu.tscn"]
var nvll_Act = 0

#per a passar de nivell, retorna com a últim obj la ruta al menu per tornar al menu principal
func passar_nivell():
	var ruta = _nivells[nvll_Act]
	nvll_Act+=1
	return ruta

#reset de vides i el nivell. Quan sortim al menu es crida aquest mètode
func reset():
	vides = 3
	nvll_Act = 0
