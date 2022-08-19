extends Node2D

var viewport_size := Vector2()
var ball_size := Vector2()

var velocity := 500
var direction := Vector2()

var rng := RandomNumberGenerator.new()

func _ready():
	var viewport := get_viewport()
	viewport_size = viewport.size
	
	var sprite := get_node("Sprite")
	var rect: Rect2 = sprite.get_rect()
	var transform: Transform2D = sprite.get_transform()
	ball_size = rect.size * transform.get_scale() * get_transform().get_scale()
	
	rng.randomize()
	direction = Vector2(rng.randf(), rng.randf()).normalized()

func _process(delta):
	var origin = get_transform().get_origin()
	var ball_top: float = origin.y - ball_size.y/2
	var ball_bottom: float = origin.y + ball_size.y/2
	var ball_left: float = origin.x - ball_size.x/2
	var ball_right: float = origin.x + ball_size.x/2

	if ball_top <= 0:
		direction.y = abs(direction.y)
	if ball_bottom >= viewport_size.y:
		direction.y = -abs(direction.y)
	if ball_left <= 0:
		direction.x = abs(direction.x)
	if ball_right >= viewport_size.x:
		direction.x = -abs(direction.x)
	
	translate(direction*velocity*delta)
