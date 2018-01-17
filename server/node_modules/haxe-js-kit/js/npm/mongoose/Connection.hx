package js.npm.mongoose;

typedef Db = Dynamic;

extern class Connection
implements npm.Package.RequireNamespace < "mongoose", "^4.3.3" > {
	
	public var db(default,null):Db;	
	public var readyState(default,null):Int;
	
	public function modelNames():Array<String>;
}