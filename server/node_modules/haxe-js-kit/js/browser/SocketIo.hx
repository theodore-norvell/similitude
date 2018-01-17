package js.browser;

import js.npm.socketio.Listener;
//import js.npm.socketio.Manager;
//import js.npm.socketio.Socket;
//import js.npm.socketio.Namespace;

import js.node.events.EventEmitter.Event;
import haxe.Constraints.Function;

@:native("io")
extern
class SocketIo {

  public static function connect(?url : String, ?opts : ManagerOpts) : Socket;
  public static var version : String;
  public static var protocol : Int;
  public static var transports : Array<Dynamic>;

// all above functions are nodejs only (dunno if there's a define for that):
  public static function Socket() : Void;
  //public static function Manager(url: String, ?opts: ManagerOpts) : Manager;
  public static function Emitter(): Void;
/*
     * Expose Transport
     * @api public
    io.Transport = require('./transport').Transport;

     * Expose all transports
     * @api public
    io.Transport.XHR = require('./transports/xhr').XHR;
*/
}

extern
class Socket implements Dynamic{
  public static function Socket(options : Dynamic) : Void;

  public var connected : Bool;
  public var open : Bool;
  public var connecting : Bool;
  public var reconnecting : Bool;
  public var namespaces : Dynamic;
  public var buffer : Array<Dynamic>;
  public var doBuffer : Bool;


  //public function of(name : String) : Namespace;
  public function connect(?fn : Void -> Void) : Socket;
  public function packet(data : Dynamic) : Socket;
  public function disconnect() : Socket;

  // from js.Node.NodeEventEmitter
  public function addListener<T:Function>(event:Event<T>,fn:T):Dynamic;
  public function on<T:Function>(event:Event<T>,fn:T):Dynamic;
  public function once<T:Function>(event:Event<T>,fn:T):Void;
  public function removeListener<T:Function>(event:Event<T>,listener:T):Void;
  public function removeAllListeners<T:Function>(event:Event<T>):Void;
  public function listeners<T:Function>(event:Event<T>):Array<T>;
  public function setMaxListeners(m:Int):Void;
  public function emit<T:Function>(event:Event<T>,args:haxe.extern.Rest<Dynamic>):Void;
}

/*extern
class Flag {
  public function send() : Void;
  public function emit() : Void;
}*/

typedef ManagerOpts = {
  ?multiplex: Bool,
  ?reconnection: Bool,
  ?reconnectionDelay: Int,
  ?reconnectionDelayMax: Int,
  ?timeout: Int
}