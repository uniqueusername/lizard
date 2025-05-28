extends Node

var client = SocketIOClient
var backendURL: String

func _ready() -> void:
	backendURL = "http://kaylee.hyperbeam.sh:3000/socket.io"
	client = SocketIOClient.new(backendURL,{ "token": "" })

	client.on_engine_connected.connect(on_socket_ready)
	client.on_connect.connect(on_socket_connect)
	client.on_event.connect(on_socket_event)
	add_child(client)
	
func _exit_tree():
	client.socketio_disconnect()

func on_socket_ready(_sid: String):
	client.socketio_connect()

func on_socket_connect(_payload: Variant, _name_space, error: bool):
	if error:
		push_error("failed to connect to backend!")
	else:
		print("socket connected")

func on_socket_event(event_name: String, payload: Variant, _name_space):
	if event_name == "drop food":
		Global.drop_food()
		
	print("received ", event_name, " ", payload)
	client.socketio_send("hello", "world")
