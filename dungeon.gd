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

onready var iso_to_cart = Transform2D().scaled(Vector2(1, .5)) * Transform2D.rotated(PI/4) # Scale a transformation then rotate it (or maybe rotate then scale, not sure how it worked exactly..)

func _ready():
	var tile_bounds = calculate_bounds(get_node('floor'))
	$Node2D/TextureRect.rect_size = tile_bounds.size
	$Node2D.transform = iso_to_cart

func calculate_bounds(tilemap):
    var cell_bounds = tilemap.get_used_rect()
    # create transform
    var cell_to_pixel = Transform2D(Vector2(tilemap.cell_size.x * tilemap.scale.x, 0), Vector2(0, tilemap.cell_size.y * tilemap.scale.y), Vector2())
    # apply transform
    return Rect2(cell_to_pixel * cell_bounds.position, cell_to_pixel * cell_bounds.size)

func _physics_process(delta):
	get_node('Fog/Viewport/Node2D/Sprite').position = iso_to_cart.xform_inv($walls/troll.position)