extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var score = 0
var maxScore = 0
var speed = 1
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("target/button").set_action("touch")
	get_node("btnMusic").set_action("music")
	set_process(true)
	set_process_input(true)
	pass

func _input(event):
	if event.is_action_pressed("touch"):
		get_node("SamplePlayer").play("sniper")
		if get_node("target/Area2D").overlaps_area(get_node("handspinner/Area2D")) \
		or get_node("target/Area2D").overlaps_area(get_node("handspinner/Area2D1")) \
		or get_node("target/Area2D").overlaps_area(get_node("handspinner/Area2D2")):
			score += 1
			maxScore = max(maxScore, score)
		else:
			score -= 1
			if score < 0: score = 0
		speed = PI * score / 8 + 1
	if event.is_action_pressed("music"):
		if get_node("StreamPlayer").is_playing() : get_node("StreamPlayer").stop()
		else : get_node("StreamPlayer").play()

func _process(delta):
	get_node("handspinner").rotate(speed * delta)
	get_node("score").set_text("Score : " + str(score) )
	get_node("maxScore").set_text("High Score : " + str(maxScore))