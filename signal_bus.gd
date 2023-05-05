extends Node

signal on_health_changed(node : Node, amount_changed : int)

signal on_digbox_entered(node: Node, visible: int)

signal on_sniffbox_entered(node: Node, visible: int)

signal on_truffle_exit(node: Node, visible: int)
