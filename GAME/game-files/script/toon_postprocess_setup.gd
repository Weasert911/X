extends Node

@export var enabled: bool = true
@export var canvas_layer: int = 100

var canvas_layer_node: CanvasLayer
var color_rect: ColorRect
var shader_material: ShaderMaterial

func _ready():
    if enabled:
        setup_postprocess()

func setup_postprocess():
    # Create CanvasLayer
    canvas_layer_node = CanvasLayer.new()
    canvas_layer_node.layer = canvas_layer
    
    # Create ColorRect
    color_rect = ColorRect.new()
    color_rect.anchors_preset = Control.PRESET_FULL_RECT
    color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
    
    # Create ShaderMaterial
    shader_material = ShaderMaterial.new()
    shader_material.shader = load("res://GAME/game-files/shader/toon_outline_postprocess.gdshader")
    
    # Apply material to ColorRect
    color_rect.material = shader_material
    
    # Add ColorRect to CanvasLayer
    canvas_layer_node.add_child(color_rect)
    
    # Add CanvasLayer to scene
    add_child(canvas_layer_node)

func set_shader_param(param_name: String, value):
    if shader_material:
        shader_material.set_shader_parameter(param_name, value)

func cleanup():
    if canvas_layer_node:
        canvas_layer_node.queue_free()
