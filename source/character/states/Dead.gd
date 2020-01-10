extends State

func enter(host: Character) -> void:
	host.anim_player.play("die")