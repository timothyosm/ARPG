extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 128
var height = 128
@onready var player = get_parent().get_child(1)

func _ready():
	altitude.seed = randi()
	altitude.frequency = 0.005


func _process(delta):
	generate_chunk(player.position)
	

func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10

			if alt < 2:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 3, Vector2(1, 0))
			else:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 3, Vector2(0,0))
