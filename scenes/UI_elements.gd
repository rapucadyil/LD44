extends Control

signal restarted

func _ready():
	pass

func _process(delta):
	if self.visible:
		if Input.is_action_just_pressed("ui_restart"):
			emit_signal("restarted")
			self.visible = false

func _on_Player_health_depleted():
	self.visible = true
