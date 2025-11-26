extends Effect

@export var cooldown: float = 2

@onready var timer: Timer = $Timer


func _ready() -> void:
	if owner is Player:
		(owner as Player).hit_wall.connect(play_effect)


func play_effect() -> void:
	if timer.is_stopped():
		timer.start(cooldown)
		$Sound.play()
