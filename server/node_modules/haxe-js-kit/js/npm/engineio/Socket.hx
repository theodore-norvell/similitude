package js.npm.engineio;

import js.support.Callback;

@:enum
abstract SocketReadyState(String) {
	var Opening = "opening";
	var Open = "open";
	var Closing = "closing";
	var Closed = "closed";
}

typedef SocketMessage = Dynamic;

extern class Socket
extends js.node.events.EventEmitter<Socket>
implements npm.Package.RequireNamespace<"engine.io","1.4.3">
{
	public var id (default,null) : String;
	public var server (default,null) : Server;
	public var request (default,null) : js.node.http.ClientRequest;
	public var upgraded (default,null) : Bool;
	public var readyState (default,null) : SocketReadyState;
	public var transport (default,null) : Transport;

	public function send( message : SocketMessage , ?cb : Callback0 ) : Socket;
	public function close() : Socket;
}
