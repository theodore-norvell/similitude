package js.npm.socketio;

import js.npm.socketio.Listener;
import js.npm.express.Middleware.MiddlewareNext;
import js.support.Callback.Callback0;
import js.support.DynamicObject;

extern
class Namespace implements Dynamic{

	public var name : String;
  public var connected:DynamicObject<Socket>;

  function use(fn: Socket -> MiddlewareNext -> Void): Namespace;

  /*public var adapter: Adapter;
  public var handshake (default,null) : HandshakeData; 
  public var broadcast (default,null) : Namespace;

//  public static function SocketNamespace (socket : Dynamic, name : String) : Void;
  public function send(data : Dynamic, fn : Dynamic) : Namespace;
  public function disconnect () : Namespace;

  // from js.Node.NodeEventEmitter
  public function addListener(event:String,fn:Listener):Dynamic;

  @:overload(function(event:String,fn:CallbackListener) : Dynamic{ } )
  public function on(event:String,fn:Listener):Dynamic;

  @:overload(function(event:String,fn:CallbackListener) : Void{ } )
  public function once(event:String,fn:Listener):Void;
  public function removeListener(event:String,listener:Listener):Void;
  public function removeAllListeners(event:String):Void;
  public function listeners(event:String):Array<Listener>;
  public function setMaxListeners(m:Int):Void;

	@:overload(function(name : String) : Namespace{ } )
  public function emit(event:String,?arg1:Dynamic,?arg2:Dynamic,?arg3:Dynamic):Void;

  @:overload(function(room : String) : Namespace{ } )
  public function join(room:String, callback: Callback0):Namespace;
  public function leave(room:String):Namespace;

  /*@:native("in")
  public inline function in_(room:String):Namespace return untyped this["in"](room);
  public function to(room: String):Namespace;
  

  // Not supported in 1.0.0
  //public function clients(room:String):Array<Namespace>;

  public function set<T>( key : String , value : T , ?cb : Void -> Void ) : Void;
  public function get<T>( key : String , cb : Null<String> -> T -> Void ) : Void;

  public function socket( id : String ) : Namespace;
}

extern
class Adapter
{
  public var rooms: DynamicObject<Array<String>>;*/
}


