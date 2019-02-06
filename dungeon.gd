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

onready var iso_to_cart = Transform2D().scaled(Vector2(1, 0.5)) * Transform2D(PI/4, Vector2()) # Scale a transformation then rotate it (or maybe rotate then scale, not sure how it worked exactly..) onready var cart_to_iso = tile_to_world.affine_inverse() # Inverse
onready var cart_to_iso = iso_to_cart.affine_inverse()
func _ready():
	f = get_node('floor')
	t = get_node("TextureRect")
#	var sprite = $Sprite
	vp = get_viewport()
	fog_vp = $Fog/Viewport
	map_rect = f.get_used_rect()
	map_size = Vector2(map_rect.size.y, map_rect.size.x) * f.cell_size
	fog_vp.size = map_size
	map_position = f.map_to_world(map_rect.position)
	var end_coord = f.map_to_world(map_rect.end)
	t.margin_right = end_coord.x
	t.margin_bottom = end_coord.y
#	t.rect_position = map_position

func _physics_process(delta):
	get_node('Fog/Viewport/Node2D/Sprite').position = $walls/troll.position - Vector2(400, 128)