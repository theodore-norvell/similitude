package js.npm.engineio;

import js.node.http.ClientRequest;
import js.node.http.ServerResponse;
import js.support.Callback;

typedef ServerOptions = {
	?pingTimeout : Int,
	?pingInterval : Int,
	?maxHttpBufferSize : Int,
	?allowRequest : js.node.http.ClientRequest -> Callback<Bool> -> Void,
	?transports : Array<String>,
	?allowUpgrades : Bool,
	?cookie : String
}

typedef ServerAttachOptions = {
	?path : String,
	?destroyUpgrade : Bool,
	?destroyUpgradeTimeout : Int
}

extern class Server
extends js.node.events.EventEmitter<Server>
implements npm.Package.RequireNamespace<"engine.io","1.4.3">
{
	public static var protocol (default,null) : Int;
	public static var transports (default,null) : Dynamic<Transport>;

	public function new( ?srv : js.node.http.Server , ?opts : ServerOptions ) : Void;
	public function listen( port : Int , ?opts : ServerOptions , ?cb : Callback0 ) : Server;
	public function attach( srv : js.node.http.Server , ?opts : ServerAttachOptions ) : Server;

	public var clients (default,null) : Dynamic<Socket>;
	public var clientsCount (default,null) : Int;

	public function close() : Server;
	public function handleRequest(req:ClientRequest, res:ServerResponse) : Server;
	public function handleUpgrade(req:ClientRequest, stream:js.node.net.Socket, buffer:js.node.Buffer ) : Server;

}
