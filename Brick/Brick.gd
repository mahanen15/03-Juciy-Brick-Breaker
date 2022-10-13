extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position
	if score >= 100:
		$ColorRect.color = Color8(173,181,189)
	elif score >= 90:
		$ColorRect.color = Color8(105,219,124)
	elif score >= 80:
		$ColorRect.color = Color8(253,126,20)
	elif score >= 70:
		$ColorRect.color = Color8(255,212,59)
	elif score >= 60:
		$ColorRect.color = Color8(66,99,235)
	elif score >= 50:
		$ColorRect.color = Color8(247,131,172)
	elif score >= 40:
		$ColorRect.color = Color8(102,217,232)
	else:
		$ColorRect.color = Color8(240,62,62)

func _physics_process(_delta):
	if dying and not $confetti.emitting:
		queue_free()

func hit(_ball):
	var Brick_sound = get_node_or_null("/root/Game/Brick_Sound")
	if Brick_sound != null:
		Brick_sound.play()
	die()

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	$confetti.emitting = true
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instance()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
