extends Node3D

@export var shader: Shader

func _ready():
    if shader == null:
        push_error("No shader assigned!")
        return

    apply_shader_recursive(self)


func apply_shader_recursive(node: Node):
    for child in node.get_children():

        # If it's a mesh
        if child is MeshInstance3D:
            var mat := ShaderMaterial.new()
            mat.shader = shader

            child.material_override = mat

        # Recurse
        apply_shader_recursive(child)