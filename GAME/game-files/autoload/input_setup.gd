extends Node

func _ready():
    if not InputMap.has_action("interact"):
        InputMap.add_action("interact")
        var event = InputEventKey.new()
        event.keycode = KEY_E
        InputMap.action_add_event("interact", event)
    
    if not InputMap.has_action("throw"):
        InputMap.add_action("throw")
        var event = InputEventKey.new()
        event.keycode = KEY_Q
        InputMap.action_add_event("throw", event)