extends KinematicBody2D

const MOVE_SPEED = 300

onready var raycast = $RayCast2D
var moc
var tem

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	
	tem = get_parent().get_child(3)

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	moc = move_and_collide(move_vec * MOVE_SPEED * delta)
	
	if $".".position.x < 1:
		$".".position.x = 1
	elif $".".position.x > 1024:
		$".".position.x = 1024
	if $".".position.y < 1:
		$".".position.y = 1
	elif $".".position.y > 600:
		$".".position.y = 600
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("shoot"):
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			
			print("win ", get_parent().get_child(2).get_child_count()) 
			if !tem.go && get_parent().get_child(2).get_child_count() == 1:
				tem.get_node("hud/Label").set_text("You WIN máquina")
				tem.get_node("TimerGO").start(2)
				tem.go = true
#				.get_child_count() == 1
#				print("game_over", get_parent().get_child(2).get_node("TimerGO")) 
			coll.kill()

func kill():
#	print("game_over",tem.go)
	if !tem.go:
#		print("game_over", get_parent().get_child(2).get_node("TimerGO"))
		tem.get_node("hud/Label").set_text("Game Over por Zormbie")
		tem.get_node("TimerGO").start(2)
		tem.go = true
#	moc = get_tree().reload_current_scene()
#	print(get_tree().reload_current_scene())
