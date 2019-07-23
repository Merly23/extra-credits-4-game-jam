extends State

var host : Boy

func enter(host: Boy) -> void:
	host.play_anim("attack")
	self.host = host