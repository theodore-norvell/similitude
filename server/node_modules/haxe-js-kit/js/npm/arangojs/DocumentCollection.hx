package js.npm.arangojs;
import js.npm.arangojs.Collection.CollectionMetadata;

extern class DocumentCollection extends Collection
{
	public function document<T>(documentHandle : String, cb : ArangoCallback<T>) : Void;
	public function save<T>(data : T, cb : ArangoCallback<CollectionMetadata>) : Void;
}
