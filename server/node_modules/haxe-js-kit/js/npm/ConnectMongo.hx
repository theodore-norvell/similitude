package js.npm;

import js.node.http.ClientRequest;
import js.node.http.ServerResponse;
import js.npm.express.Session;
import js.npm.mongoose.Connection;
import js.support.Callback;
import js.npm.express.Middleware;

typedef ConnectMongoOptions = {
	?mongooseConnection : Connection,
	?db : Dynamic,
	?url : String,
	?mongoOptions : Dynamic,
	?host : String,
	?port : Int,
	?username : String,
	?password : String,
	?autoReconnect : Bool,
	?w : Int,
	?ssl : Bool,
	?ttl : Int,
	?autoRemove : String,
	?autoRemoveInterval : Int,
	?collection : Dynamic,
	?stringify : Bool,
	?serialize : Dynamic,
	?unserialize : Dynamic,
	?hash : {salt: String, algorithm: String}
};

extern class ConnectMongo
implements js.npm.express.Session.SessionStore #if !haxe3 , #end
implements npm.Package.Require<"connect-mongo","^0.6.0"> {
	public static inline function construct( session : Class<Dynamic> , options : ConnectMongoOptions ) : ConnectMongo {
		return untyped __new__( __new__( ConnectMongo , session ) , options );
	}

	public function get(sid : String, callback : Callback<{}> ) : Void;
	public function set(sid : String, session : {}, callback : Callback0 ) : Void;
	public function destroy(sid : String, callback : Callback0 ) : Void;	

}