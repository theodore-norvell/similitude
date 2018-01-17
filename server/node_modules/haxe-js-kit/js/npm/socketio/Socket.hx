package js.npm.socketio;

import haxe.web.Request;
import js.node.events.EventEmitter;
import js.support.Callback.Callback0;

extern class Socket implements Dynamic extends EventEmitter<Socket>
{
	var rooms: Array<String>;
	var client: Client;
	var conn: Socket;
	var request: Request;
	var id: String;
	var json: Socket;
	var volatile: Socket;
	var broadcast: Socket;

	//function emit(name: String,?arg1:Dynamic,?arg2:Dynamic,?arg3:Dynamic): Socket;
	function join(name: String, ?fn: Callback0): Socket;
	function leave(name: String, ?fn: Callback0): Socket;
	function to(room: String): Socket;
	@:native("in")
	function in_(room: String): Socket;

	function send(data: Dynamic): Socket;
	function write(data: Dynamic): Socket;
	function disconnect(close: Bool): Socket;
}

typedef Client = {
	conn: Socket,
	request: Request
}
