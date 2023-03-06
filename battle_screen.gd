extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var p1 = $player1
onready var p2 = $player2

# Called when the node enters the scene tree for the first time.
func _ready():
	p1.find_node("question").generate_question()
	p2.find_node("question").generate_question()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
