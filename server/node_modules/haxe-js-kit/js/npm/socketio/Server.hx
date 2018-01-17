package js.npm.socketio;

import js.npm.express.Middleware.MiddlewareNext;
import js.npm.socketio.Namespace;

extern class Server 
extends Channel 
implements npm.Package.Require<"socket.io","1.0">
{

	function new(?srv: js.node.http.Server, ?port: Int, ?opts: ServerOpts);

	var sockets: Namespace;

	function adapter(v: Adapter): Server;
	function origins(v: String): Server;
	function attach(port: Int, ?opts: ServerOpts): Server;
	function listen(port: Int, ?opts: ServerOpts): Server;
	function onconnection(socket: Socket): Server;
	function of(nsp: String): Namespace;
	function use(fn: Socket -> MiddlewareNext -> Void): Namespace;
}

typedef ServerOpts = {
	?serveClient: Bool,
	?path: String
}