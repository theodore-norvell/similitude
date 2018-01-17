package js.npm.arangojs;
import js.support.Either;

extern class GraphVertexCollection extends Collection
{
	public function vertex<T>(documentHandle : Either<String, {}>, cb : ArangoCallback<T>) : Void;
	public function save(data : {}, cb : ArangoCallback<{}>) : Void;
}
