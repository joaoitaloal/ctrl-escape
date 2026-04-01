class_name Terminal
extends Control

var ACTIONS = {
	"clear": clear,
	"echo": echo
}

func _process(_delta):
	if(%Input.has_focus() && Input.is_action_just_pressed("ui_text_submit")):
		_on_submit_pressed();

# Função de uso interno
func t_print(text: String):
	%Output.add_text(text);
	%Output.newline();

func clear(_args: PackedStringArray):
	%Output.clear();

func echo(args: PackedStringArray):
	t_print(" ".join(args));

func _on_submit_pressed():
	var args: PackedStringArray =  %Input.text.split(" ");
	var cmd = args[0]; # args é um PackedStringArray então não tem pop_front
	args.remove_at(0);
	
	if(ACTIONS.get(cmd)):
		ACTIONS[cmd].call(args);
	else:
		t_print("O comando %s não existe" % cmd);
	
	%Input.text = "";
