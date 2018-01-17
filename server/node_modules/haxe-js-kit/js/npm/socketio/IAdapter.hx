package js.npm.socketio;

typedef PacketOptions = {
	?flags : Dynamic,
	?except : Array<String>,
	?rooms : Array<String>
}

interface IAdapter 
{
	public function add(id : String, room : String , fn : Void->Void ) : Void;
	public function del(id : String, room : String , fn : Void->Void ) : Void;
	public function delAll(id : String, fn : Void->Void ) : Void;
	public function broadcast( packet : Dynamic, opts : PacketOptions ) : Void;
}