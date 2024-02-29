extends Node2D

const SawBladeTelegraphScene = preload("res://saw_blade_telegraph.tscn")

@onready var timer = $Timer
@onready var saw_count_label = $SawCountLabel

var saw_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout) # Función para llamar parámetro timeout de nodo Timer
	Events.ballon_popped.connect(timer.stop)
	Events.ballon_popped.connect(_reset_scene)
	Events.saw_blade_added.connect(update_saw_count)
	get_tree().paused = false
#Función que se ejecuta cada vez que timeout sucede
func _on_timer_timeout():
	var saw_blade_telegraph = SawBladeTelegraphScene.instantiate() #Declara instanciar Telegraph como variable
	saw_blade_telegraph.position = Vector2(320,180) / 2.0 # Determina posición de Telegraph
	add_child(saw_blade_telegraph) # Crea Telegraph
func update_saw_count():
	saw_count += 1
	saw_count_label.text = "Blades\n" + str(saw_count)
#Reinicia el juego cuando pierdes
func _reset_scene(): 
	get_tree().paused = true
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()

