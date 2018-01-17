package js.npm;

/**
 * ...
 * @author sledorze
 */

extern class SocketIo
implements npm.Package.Require<"socket.io","*">
{
	@:override( function( port : Int ) : js.npm.socketio.Server {} )
	public static function listen(?server : Dynamic, ?options : Dynamic, ?fn : Dynamic) : js.npm.socketio.Server;
}
