extends Node2D

const SawScene =preload("res://saw_blade.tscn")#Carga la escena SawBlade para instanciarla con código

@onready var arrow_2d_2 = $Arrow2D2 #Acceso a parametros de Arrow2D2
@onready var timer = $Timer #Acceso a parametros de Timer

var direction =Vector2.RIGHT.rotated(randf_range(0, TAU))

# Called when the node enters the scene tree for the first time.
func _ready():
	arrow_2d_2.rotation = direction.angle() #Define el ángulo de rotación
	timer.timeout.connect(_on_timer_timeout) 
	Events.ballon_popped.connect(timer.stop)

#Función para generar una sierra nueva pasado un tiempo
func _on_timer_timeout():
	Events.saw_blade_added.emit() # Emite señal de generación para aumentar el conteo de sierras
	var saw = SawScene.instantiate()
	saw.position = position
	saw.linear_velocity = direction * 100
	get_tree().current_scene.add_child(saw)
	queue_free()
