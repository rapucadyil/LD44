extends KinematicBody2D

var v_speed = 4
var h_speed = 4

signal health_changed(hp)
signal health_depleted

var hp = 0
export(int) var max_hp = 100

func _ready():
	hp = 50
	emit_signal("health_changed", hp)
	
func take_damage(amt):
	hp -= amt
	hp = max(0, hp)
	emit_signal("health_changed", hp)
	
func heal(amt):
	hp += amt
	hp = min(hp, max_hp)
	emit_signal("health_changed", hp)

func _process(delta):
	if Input.is_action_pressed('ui_up'):
		move_by(0, -v_speed)
	if Input.is_action_pressed('ui_down'):
		move_by(0, v_speed)
	if Input.is_action_pressed('ui_right'):
		move_by(h_speed, 0)
		draw(1)
	if Input.is_action_pressed('ui_left'):
		move_by(-h_speed, 0)
		draw(-1)
		
	
	if hp <= 0:
		emit_signal("health_depleted")
		
	if Input.is_action_just_pressed('ui_page_up'):
		heal(10)
	if Input.is_action_just_pressed('ui_page_down'):
		take_damage(10) 
	
func move_by(dx, dy):
	self.position.x += dx
	self.position.y += dy

# Will handle animatio
func draw(dir):
	if dir == 1:
		$AnimatedSprite.flip_h = false
	if dir == -1 :
		$AnimatedSprite.flip_h = true




func _on_Control_restarted():
	hp = 50
	emit_signal("health_changed", hp)
