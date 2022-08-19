extends Node2D

var viewport_size := Vector2()
var paddle_size := Vector2()

var velocity := 500

func _ready():
	var viewport := get_viewport()
	viewport_size = viewport.size
	
	var sprite := get_node("Sprite")
	var rect: Rect2 = sprite.get_rect()
	var transform: Transform2D = sprite.get_transform()
	paddle_size = rect.size * transform.get_scale() * get_transform().get_scale()

func _input(_event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var transform = get_transform()
	var paddle_top = transform.get_origin().y - paddle_size.y/2
	var paddle_bottom = transform.get_origin().y + paddle_size.y/2
	
	var direction := Vector2()
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y += -1
	if paddle_top <= 0:
		direction.y = max(direction.y, 0)
	if paddle_bottom >= viewport_size.y:
		direction.y = min(direction.y, 0)

	translate(direction*velocity*delta)
