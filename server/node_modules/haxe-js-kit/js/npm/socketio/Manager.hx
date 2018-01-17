package js.npm.socketio;

import js.browser.SocketIo.ManagerOpts;

extern class Manager{
	public function new(url: String, opts: ManagerOpts);

	public function reconnection(?v: Bool): Manager;
	public function reconnectionAttemps(?v: Int): Manager;
	public function reconnectionDelay(?v: Int): Manager;
	public function reconnectionDelayMax(?v: Int): Manager;
	public function timeout(?v: Int): Manager;
}

/*typedef Manager = {

	var sockets(default,null) : Namespace;

	var store(default, null) : Dynamic;
	var log(default, null) : Dynamic;
	@:native("static") var static_(default, null) : Dynamic;

	function get(key : Dynamic) : Dynamic;
	function set(key : Dynamic, value : Dynamic) : Manager;
	function use(fn: Namespace -> Dynamic -> Void) : Manager;
	function enable(key : Dynamic) : Manager;
	function disable(key : Dynamic) : Manager;

	function enabled(key : Dynamic) : Bool;
	function disabled(key : Dynamic) : Bool;

	@:overload(function(fn : Void -> Void):Manager {})
	@:overload(function(fn : Manager -> Void):Manager {})
	function configure(env : Dynamic, fn : Manager -> Void) : Manager;

	function of(nsp : Dynamic) : Namespace;
}*/
