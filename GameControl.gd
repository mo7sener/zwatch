extends Node

var score
var enemies_killed
var headshoot_score

var wave_size
var wave_number

var enemies_alive

var spawner_node

var Tower = null

var endPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	enemies_killed = 0
	headshoot_score = 0
	
	wave_size = 1
	wave_number = 1
	enemies_alive = wave_size

func set_spawner(spawner):
	spawner_node = spawner

func incr_score(val):
	score += val
	
func incr_headshootscore(val):
	headshoot_score += val	

func decr_score(val):
	score -= val

func enemy_killed():
	enemies_killed +=1
	enemies_alive -= 1
	incr_score(1)
	if enemies_alive <= 0:
		yield(get_tree().create_timer(10), "timeout")
		spawn_wave()

func spawn_wave():
	get_tree().call_group("enemies", "queue_free")
	spawner_node.spawn_wave(wave_size)
	wave_number += 1
	enemies_alive = wave_size
	wave_size = 1

func reg_bullet():
	wave_size += 1

func set_tower(tower):
	Tower = tower

func set_healthbar(bar):
	if Tower:
		Tower.set_healthbar(bar)

func lose():
	endPanel.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
