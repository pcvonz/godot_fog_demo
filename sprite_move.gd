extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 10

var move = Vector2(speed, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().render_target_clear_mode = get_viewport().CLEAR_MODE_NEVER

func _physics_process(delta):
	if position.x > 800:
		move = Vector2(-speed, 0)
	elif position.x < 40:
		move = Vector2(speed, 0)
	self.position += move