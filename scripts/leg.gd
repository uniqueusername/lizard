extends Skeleton2D

@export var step_distance: float = 30
@export var step_offset: float = step_distance * 0.8
@export var height: float = 10
@onready var parent: Sprite2D = get_parent()
@export var hind_leg: bool = false
var target_target: Vector2

func _process(delta: float) -> void:
	global_position = parent.global_position
	
	if not parent.moving_right:
		$RayCast2D.position.x = -step_offset
		var mod1: SkeletonModification2DTwoBoneIK = get_modification_stack().get_modification(0)
		var mod2: SkeletonModification2DTwoBoneIK = get_modification_stack().get_modification(1)
		mod1.enabled = true if hind_leg else false
		mod2.enabled = false if hind_leg else true
		
		get_modification_stack().set_modification(0, mod1)
		get_modification_stack().set_modification(1, mod2)
	else:
		$RayCast2D.position.x = step_offset
		var mod1: SkeletonModification2DTwoBoneIK = get_modification_stack().get_modification(0)
		var mod2: SkeletonModification2DTwoBoneIK = get_modification_stack().get_modification(1)
		mod1.enabled = false if hind_leg else true
		mod2.enabled = true if hind_leg else false
		
		get_modification_stack().set_modification(0, mod1)
		get_modification_stack().set_modification(1, mod2)
	
	if (parent.global_position - target_target).length() > step_distance:
		target_target = $RayCast2D.get_collision_point()
		
	$RayCast2D/target.position = $RayCast2D/target.position.lerp(target_target, 0.7);
