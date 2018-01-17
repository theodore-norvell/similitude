package js.npm.mongoose.schema.types;

@:native("Schema.Types.ObjectId")
extern class ObjectId
extends js.npm.mongoose.SchemaType
implements npm.Package.RequireNamespace<"mongoose","^4.3.3"> {
	public function new( path : String , options : {} ) : Void;
	public function equals(id : ObjectId) : Bool;
	public function toString() : String;
}
