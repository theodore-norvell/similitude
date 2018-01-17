package js.npm.mongoose.types;

@:native("Types.ObjectId")
extern class ObjectId
implements npm.Package.RequireNamespace<"mongoose","^4.0.0"> {
	public function new() : Void;
	static public function createFromHexString(str : String) : js.npm.mongoose.schema.types.ObjectId;
}