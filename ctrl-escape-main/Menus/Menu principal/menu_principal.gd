extends Control

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"CanvasLayer/Slider musica".value = MusicManager.obter_volume_salvo()
#TODO: Colocar para aparecer mensagem de confirmaçao

func _on_exit_pressed():
	get_tree().quit();

func _on_config_pressed():
	$CanvasLayer.visible = true

func _on_x_pressed() -> void:
	$CanvasLayer.visible = false

func _on_slider_musica_value_changed(value: float) -> void:
	MusicManager.atualizar_volume(value)


func _on_slider_som_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Som")
	AudioServer.set_bus_volume_db(bus_index, value)
