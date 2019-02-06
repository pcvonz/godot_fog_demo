extends ViewportContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Viewport.world_2d = get_node('/root').world_2d
#
#func _process(delta):
#	$Viewport/Camera2D.position = get_node('/root/dungeon/walls/troll').position