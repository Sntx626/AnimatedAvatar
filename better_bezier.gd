class_name better_bezier

const p0 = Vector2.ZERO
var p1
var p2
const p3 = Vector2.ONE

var cache

func _init(p1i: Vector2, p2i: Vector2):
	p1 = p1i
	p2 = p2i
	cache = {}

func f(x):
	if x in cache:
		return cache[x]
	else:
		var new_result = _cubic_bezier(p0, p1, p2, p3, x)
		cache[x] = new_result
		return new_result

func get_cache_size():
	return len(cache)

# Ref: https://github.com/godotengine/godot/blob/e8f73124a7d97abc94cea3cf7fe5b5614f61a448/scene/resources/curve.cpp#L36-L45
# Ref: https://github.com/gilzoide/godot-cubic-bezier-controls/blob/main/addons/cubic_bezier_controls/cubic_bezier_curve.gd
static func _cubic_bezier(start: Vector2, control1: Vector2, control2: Vector2, end: Vector2, t: float) -> Vector2:
	var omt = (1.0 - t)
	var omt2 = omt * omt
	var omt3 = omt2 * omt
	var t2 = t * t
	var t3 = t2 * t
	return start * omt3 \
			+ control1 * omt2 * t * 3.0 \
			+ control2 * omt * t2 * 3.0 \
			+ end * t3

func _print():
	var out_str = ""
	for i in range(101):
		out_str += str(i) + " "
		out_str += str(f(float(i)/100).y) + " "
	print(out_str)
