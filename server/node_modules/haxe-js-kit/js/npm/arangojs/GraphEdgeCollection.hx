package js.npm.arangojs;
import js.support.Either;

extern class GraphEdgeCollection extends Collection
{
	public function edge<T>(documentHandle : Either<String, {}>, cb : ArangoCallback<T>) : Void;
	@:overload(function<T>(data : T, fromId : Either<String, {}>, toId : Either<String, {}>, cb : ArangoCallback<{}>) : Void {})
	public function save<T>(data : T, cb : ArangoCallback<{}>) : Void;
	public function edges(documentHandle : Either<String, {}>, cb : ArangoCallback<Array<{}>>) : Void;
	public function inEdges(documentHandle : Either<String, {}>, cb : ArangoCallback<Array<{}>>) : Void;
	public function outEdges(documentHandle : Either<String, {}>, cb : ArangoCallback<Array<{}>>) : Void;	
	public function traversal<T>(startVertex : Either<String, {}>, opts : {}, cb : ArangoCallback<T>) : Void;
}
