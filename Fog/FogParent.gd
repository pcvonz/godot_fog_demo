extends Node

onready var grid = get_node('../floor')
var floor_rect
var iso_to_cart = Transform2D().scaled(Vector2(1, .5)) * Transform2D.rotated(PI/4)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Setup fog
	var tile_bounds = calculate_bounds(grid)
	floor_rect = grid.get_used_rect()
	var rect_size = floor_rect.size * Vector2(92, 92) # The size of the artwork as if it were the affine_inverse of iso_to_cart
	# Set the correct size of the texture rect
	$FogTarget/TextureRect.rect_size = rect_size
	# Apply isometric transformation
	$FogTarget.transform = iso_to_cart
	# Set the correct size of the viewport
	$Fog/Viewport.size = rect_size

func calculate_bounds(tilemap):
	var cell_bounds = tilemap.get_used_rect()
	# create transform
	var cell_to_pixel = get_tilemap_transform(tilemap)
	# apply transform
	return Rect2(cell_to_pixel * cell_bounds.position, cell_to_pixel * cell_bounds.size)

func get_tilemap_transform(tilemap):
	return Transform2D(Vector2(tilemap.cell_size.x * tilemap.scale.x, 0), Vector2(0, tilemap.cell_size.y * tilemap.scale.y), Vector2())

func grid_to_viewport(grid_pos):
	var grid_scale_x = grid_pos.x / grid.get_used_rect().size.x
	var grid_scale_y = grid_pos.y / grid.get_used_rect().size.y
	var grid_scale = Vector2(grid_scale_x, grid_scale_y)
	return $Fog/Viewport.size * grid_scale

func _process(delta):
	var clip_sprite = get_node('Fog/Viewport/Node2D/Sprite')
	var grid_pos = grid.world_to_map(get_parent().get_node("walls/troll").position)
	# lerp smoothes the transition
	clip_sprite.position = lerp(clip_sprite.position, grid_to_viewport(grid_pos), .5)

