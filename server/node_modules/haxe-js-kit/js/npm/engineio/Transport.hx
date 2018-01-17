package js.npm.engineio;

extern class Transport
extends js.node.events.EventEmitter<Transport> 
implements npm.Package.RequireNamespace<"engine.io","1.4.3"> {
	public function new(req:js.node.http.ClientRequest) : Void;
	// TODO
}
