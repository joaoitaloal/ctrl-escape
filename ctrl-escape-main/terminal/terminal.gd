class_name Terminal
extends Control

# TODO checar o comportamento de todos esses comandos pra ver se tão certos
# TODO acho que tá faltando vários feedbacks qnd o comando não é completado com sucesso

var ACTIONS = {
	"clear": clear,
	"echo": echo,
	"cd" : cd,
	"ls": ls,
	"mkdir": mkdir,
	"touch": touch
}

func _ready():
	%DisplayPath.text = %FileSystem.cur_path;

# Função de uso interno, o texto tem que ser sanitizado por causa do BBcode
func t_print(text_: String):
	%Output.append_text(text_);
	%Output.newline();

func clear(_args: PackedStringArray):
	%Output.clear();

func echo(args: PackedStringArray):
	var text = " ".join(args);
	text = text.replace("[", "[lb]")
	t_print(text);

func cd(args: PackedStringArray):
	%FileSystem.navigate("".join(args));
	%DisplayPath.text = %FileSystem.cur_path;

func ls(args: PackedStringArray):
	var path = "".join(args);
	var folders = %FileSystem.list_folders(path);
	var files = %FileSystem.list_files(path);
	
	var tokens = PackedStringArray();
	for folder: Folder in folders:
		tokens.push_back("[color=#A0A0FF]%s[/color]" % folder.folder_name);
	for file: File in files:
		tokens.push_back("[color=#FFA0A0]%s[/color]" % file.file_name);
	tokens.sort();
	t_print(" ".join(tokens));

func mkdir(args: PackedStringArray):
	%FileSystem.create_folder("".join(args));

func touch(args: PackedStringArray):
	%FileSystem.create_file("".join(args));

func _on_submit_pressed():
	var args: PackedStringArray =  %Input.text.split(" ");
	var cmd = args[0]; # args é um PackedStringArray então não tem pop_front
	args.remove_at(0);
	
	if(ACTIONS.get(cmd)):
		ACTIONS[cmd].call(args);
	else:
		echo(PackedStringArray(["O comando %s não existe" % cmd]));
	
	%Input.text = "";


func _on_input_text_submitted(_new_text):
	_on_submit_pressed();
