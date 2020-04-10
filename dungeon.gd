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
var floor_rect

func _ready():
	var tilemap = get_node('floor')
	var tile_bounds = calculate_bounds(tilemap)
	floor_rect = tilemap.get_used_rect()
	var rect_size = floor_rect.size * Vector2(92, 92)
	$Node2D/TextureRect.rect_size = tile_bounds.size 
	$Node2D.transform = iso_to_cart
	$Fog/Viewport.size = rect_size
# Converts any Vector2 coordinates or motion from the cartesian to the isometric system
func cartesian_to_isometric(cartesian):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) )

func calculate_bounds(tilemap):
	var cell_bounds = tilemap.get_used_rect()
	# create transform
	var cell_to_pixel = Transform2D(Vector2(90 * tilemap.scale.x, 0), Vector2(0, 90* tilemap.scale.y), Vector2())
	# apply transform
	return Rect2(cell_to_pixel * cell_bounds.position, cell_to_pixel * cell_bounds.size)

func _physics_process(delta):
	var new_position = $walls/troll.position
	new_position = cartesian_to_isometric(new_position)
	new_position = new_position.rotated(-PI/2)
	get_node('Fog/Viewport/Node2D/Sprite').position = new_position
