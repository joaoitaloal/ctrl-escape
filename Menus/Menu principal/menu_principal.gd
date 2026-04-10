extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#TODO: Colocar para aparecer mensagem de confirmaçao
func _on_exit_pressed():
	get_tree().quit();

func _on_config_pressed():
	# colocar a tela de config
	get_tree().change_scene_to_file("res://Menu principal/menu_principal.tscn")
