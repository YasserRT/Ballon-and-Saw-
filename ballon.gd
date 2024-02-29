extends CharacterBody2D
#Da acceso a las propiedades del nodo HurtBox
@onready var hurt_box: Area2D = $HurtBox


#Se ejecuta una vez al iniciar el programa
func _ready():
	#Permite conectarse a la información de si la capa de colisión ha sido superpuesta por otra
	hurt_box.body_entered.connect(_on_hurt_box_body_entered)
	pass

#Maneja todos los procesos de físicas y movimiento
func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") #Detecta y clasifica los movimientos
	velocity = input_vector * 150 #Aplica la velocidad dependiendo del eje y del signo	
	move_and_slide() #Necesario para moverse

#Procesa que la capa HurtBox ha sido entrada
func _on_hurt_box_body_entered(body): #Detecta la colisión
	Events.ballon_popped.emit() #Emite la señal de fulminación
	queue_free() #Fulmina al jugador


