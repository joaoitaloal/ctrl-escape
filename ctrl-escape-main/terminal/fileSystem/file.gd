class_name File
extends Node

# Classe que representa um arquivo

# Não vai ter como diferenciar extensão, pelo menos por enquanto
var file_name;

var content; # Só texto?

func _init(name_: String):
	file_name = name_;
