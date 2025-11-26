class_name ObjectPool
extends Node3D

@export var max_size: int = 75
@export var initial_size: int = 10

var pool: Array[Node3D] = []
var count_all: int = 0

var count_active: int:
	get:
		return count_all - pool.size()

var count_inactive: int:
	get:
		return pool.size()

var on_create_object: Callable
var on_get_object: Callable
var on_release_object: Callable
var on_destroy_object: Callable


func setup_pool(capacity: int) -> void:
	if not _is_callable_valid(on_create_object):
		printerr("ObjectPool: Cannot initialize, on_create_object callable is not set.")
		return

	var amount: int = mini(capacity, max_size)
	pool.resize(amount)
	
	for i in range(amount):
		if count_all >= max_size:
			break
			
		var obj := on_create_object.call() as Node3D
		if obj == null or not is_instance_valid(obj):
			printerr("ObjectPool: Failed to create object during initialization.")
			break
			
		if _is_callable_valid(on_release_object):
			on_release_object.call(obj)

		pool.append(obj)
		count_all += 1


func get_object() -> Node3D:
	var object: Node3D = _get_valid_object_from_pool()
	
	if object == null:
		object = _create_object_if_possible()
	
	if object != null:
		if _is_callable_valid(on_get_object):
			on_get_object.call(object)
			
	return object


func release_object(object: Node3D) -> void:
	if not is_instance_valid(object) or pool.has(object):
		return
		
	if _is_callable_valid(on_release_object):
		on_release_object.call(object)
	
	if pool.size() < max_size:
		pool.append(object)
	else:
		count_all = maxi(0, count_all - 1)
		if _is_callable_valid(on_destroy_object):
			on_destroy_object.call(object)


## Clear all current objects from the pool
func clear() -> void:
	var object_to_destroy: Array[Node3D] = pool.duplicate()
	pool.clear()
	count_all = 0
	
	for obj in object_to_destroy:
		if is_instance_valid(obj) and _is_callable_valid(on_destroy_object):
			on_destroy_object.call(obj)


## Check if the pool contains this object
func has(object: Node3D) -> bool:
	return pool.has(object)


## Helper to check if callable is valid
func _is_callable_valid(callable: Callable) -> bool:
	return callable != null and callable.is_valid()


## Helper to create object
func _create_object_if_possible() -> Node3D:
	if count_all >= max_size:
		printerr("ObjectPool: Max capacity reached, cannot provide object.")
		return null

	if not _is_callable_valid(on_create_object):
		printerr("ObjectPool: No on_create_object available to produce new objects.")
		return null

	var obj := on_create_object.call() as Node3D
	if is_instance_valid(obj):
		count_all += 1
		return obj

	printerr("ObjectPool: Factory returned an invalid object.")
	return null


## Helper to get object from pool
func _get_valid_object_from_pool() -> Node3D:
	while not pool.is_empty():
		var current = pool.pop_back()
		if is_instance_valid(current):
			return current
		else:
			count_all = maxi(0, count_all - 1)
			
	return null
