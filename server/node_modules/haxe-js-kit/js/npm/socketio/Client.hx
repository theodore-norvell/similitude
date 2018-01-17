package js.npm.socketio;

extern class Client {
	var conn(default,null) : js.npm.engineio.Socket;
	var request(default,null) : js.node.http.ClientRequest;
}