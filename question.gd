extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var question_label = $question_control/question_label
onready var answers = $question_control/answers_control
onready var rng = RandomNumberGenerator.new()

var answer_key
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for b in get_node("question_control/answers_control").get_children():
		b.connect("pressed", self, "_on_answer_pressed",[b])
	 # Replace with function body.

func generate_question():
	var frac = generate_fraction()
	var frac2 = generate_fraction()
	while(frac == frac2):
		frac2 = generate_fraction()
	question_label.text = str(frac[0]) + "/" + str(frac[1]) + " x " + str(frac2[0]) + "/" + str(frac2[1])
	var ans_arr_dict = generate_answers(frac, frac2)
	answer_key = ans_arr_dict[1]
	var ans_arr = ans_arr_dict[0]
	var counter = 0
	for child in answers.get_children():
		var tex = str(ans_arr[counter][0]) + "/" + str(ans_arr[counter][1])
		child.text = tex
		counter = counter + 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate_fraction():
	var nom = 100
	var denom = -1
	while (nom >= denom):
		nom = rng.randi_range(1, 9)
		denom = rng.randi_range(1, 9)
	return [nom, denom]
	

func generate_answers(f1, f2):
	var nom_res = f1[0] * f2[0]
	var denom_res = f1[1] * f2[1]
	var gcd = find_gcd(nom_res, denom_res)
	var ans = [(nom_res/gcd), (denom_res/gcd)]
	var ans_arr = []
	var ans_dict = {ans:true}
	ans_arr.append(ans)
	for _i in range(3):
		var opt = generate_fraction()
		var opt_gcd = find_gcd(opt[0], opt[1])
		var opt_min = [(opt[0]/opt_gcd), (opt[1]/opt_gcd)]
		if opt_min != ans:
			ans_arr.append(opt_min)
			ans_dict[opt_min] = false
	ans_arr.shuffle()
	return[ans_arr, ans_dict]

func find_gcd(a, b):
	if(b == 0):
		return a
	else:
		return find_gcd(b, (a % b))

func check_answer_key(key):
	return answer_key[key]

func _on_answer_pressed(button):
	var flag = check_answer_key(button.text)
	if flag:
		get_parent().attack()
	else:
		get_parent().self_destruct()
