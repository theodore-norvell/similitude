package js.npm.socketio;
import js.npm.socketio.IAdapter;

extern class Adapter
extends js.node.events.EventEmitter<Adapter>
implements IAdapter
implements npm.Package.Require<"socket.io-adapter","0.3.1">
{
	public function new(nsp:String) : Void;
	public function add(id : String, room : String , fn : Void->Void ) : Void;
	public function del(id : String, room : String , fn : Void->Void ) : Void;
	public function delAll(id : String, fn : Void->Void ) : Void;
	public function broadcast( packet : Dynamic, opts : PacketOptions ) : Void;
}
