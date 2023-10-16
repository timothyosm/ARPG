extends TileMap

const CHUNK_WIDTH = 20
const CHUNK_HEIGHT = 20
const TREE_PROBABILITY = 0.05  # 5% chance to place a tree

# Updated array of tree coordinates in the tileset
var tree_coords = [
	Vector2(0, 21), Vector2(4, 22), Vector2(7, 21), Vector2(11, 21),
	Vector2(15, 22), Vector2(18, 21), Vector2(22, 21), Vector2(26, 22),
	Vector2(29, 21), Vector2(33, 21),
	Vector2(24, 9), Vector2(26, 10), Vector2(27, 9), Vector2(29, 10),
	Vector2(30, 9), Vector2(32, 10)
]

@onready var player = get_parent().get_child(1)

var terrain_data = {}

func _ready():
	randomize()  # Ensure different random results each time

func _process(delta):
	generate_chunk(player.position)

func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(CHUNK_WIDTH):
		for y in range(CHUNK_HEIGHT):
			_generate_tile(tile_pos, x, y)

func _generate_tile(tile_pos, x, y):
	var key = Vector2i(tile_pos.x - CHUNK_WIDTH / 2 + x, tile_pos.y - CHUNK_HEIGHT / 2 + y)
	if not terrain_data.has(key):
		terrain_data[key] = _place_tree_or_grass(key)

func _place_tree_or_grass(key):
	if randf() < TREE_PROBABILITY:
		return _place_tree(key)
	else:
		return _place_grass(key)

func _place_tree(key):
	# Pick a random tree coordinate from the updated array
	var random_tree_coord = tree_coords[randi() % tree_coords.size()]
	set_cell(1, key, 2, random_tree_coord)
	return random_tree_coord

func _place_grass(key):
	var x = randi() % 4
	var y = randi() % 8
	set_cell(0, key, 0, Vector2(y, x))
	return Vector2(y, x)
