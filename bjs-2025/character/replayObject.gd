extends Node
class_name ReplayObject

#character
var position: Vector2
var velocity: Vector2
var animation: String
#crates
var crates: Array[Dictionary] = []
#pressurePlates
var pressurePlates: Array[Dictionary] = []



func to_dict(character: Character, root: SceneTree) -> Dictionary:
	return {
		"position": position,
		"velocity": velocity,
		"animation": animation,
		"crates": crates.duplicate(true),
		"pressurePlates": pressurePlates.duplicate(true),
	}


func getAllObjects(root: SceneTree)-> Array[Dictionary]  :
	var result : Array[Dictionary]
	for object in root.get_nodes_in_group("Object"):
			var crates : Dictionary[String, Vector2] = {}
			crates[object.name] = object.global_position 
			result.append(crates)
	return result	
	
func getAllPlates(root: SceneTree)-> Array[Dictionary] :
	var result : Array[Dictionary]
	for plate in root.get_nodes_in_group("Plate"):
		var pressurePlates : Dictionary[String, bool] = {}
		pressurePlates[plate.name] = plate.is_pressed
		result.append(pressurePlates)
	return result	
	
func from_dict(data: Dictionary) -> void:
	position = parse_vector2(data.get("position", Vector2.ZERO))
	velocity = parse_vector2(data.get("velocity", Vector2.ZERO))
	animation = data.get("animation", "")
	crates = cast_array_of_dicts(data.get("crates", []))
	pressurePlates = cast_array_of_dicts(data.get("pressurePlates", []))

func cast_array_of_dicts(arr) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	if typeof(arr) == TYPE_ARRAY:
		for item in arr:
			if typeof(item) == TYPE_DICTIONARY:
				var new_item = item.duplicate(true)
				if new_item.has("position"):
					new_item["position"] = parse_vector2(new_item["position"])
				result.append(new_item)
	return result

func parse_vector2(input) -> Vector2:
	match typeof(input):
		TYPE_VECTOR2:
			return input
		TYPE_DICTIONARY:
			return Vector2(input.get("x", 0), input.get("y", 0))
		TYPE_STRING:
			var s = input.strip_edges()
			s = s.replace("Vector2(", "").replace("(", "").replace(")", "")
			var parts = s.split(",", false)
			if parts.size() == 2:
				var x = parts[0].strip_edges().to_float()
				var y = parts[1].strip_edges().to_float()
				return Vector2(x, y)
	return Vector2.ZERO
