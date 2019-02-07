extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#func calculate_offset_from_self(vec):
var f
var t
var map_rect
var map_size
var map_position
var vp
var fog_vp

onready var iso_to_cart = Transform2D().scaled(Vector2(1, 0.5)) * Transform2D.rotated(PI/4+PI/2) # Scale a transformation then rotate it (or maybe rotate then scale, not sure how it worked exactly..)
onready var cart_to_iso = iso_to_cart.affine_inverse()
func _ready():
	f = get_node('floor')
	t = get_node("Node2D")
	vp = get_viewport()
	fog_vp = $Fog/Viewport
	map_rect = f.get_used_rect()
	map_size = map_rect.size * f.cell_size
	fog_vp.size = map_size
	map_position = iso_to_cart.xform_inv(f.map_to_world(map_rect.position))
	iso_to_cart = iso_to_cart.translated(map_position)
	t.get_node("TextureRect").rect_size = map_size
	t.transform = iso_to_cart
	$Fog.transform = iso_to_cart

func _physics_process(delta):
	get_node('Fog/Viewport/Node2D/Sprite').position = iso_to_cart.xform_inv($walls/troll.position)