extends Control

onready var health_over = $health_over
onready var health_under = $health_under
onready var update_tween = $update_tween
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _update_health(health):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	update_tween.start()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
