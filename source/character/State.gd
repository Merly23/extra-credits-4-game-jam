extends Node
class_name State

func enter(host):
	print(host, "Enter State: ", name)
	pass

func exit(host):
	print(host, " Exit State: ", name)

func update(host, delta):
	pass

func input(host, input):
	pass