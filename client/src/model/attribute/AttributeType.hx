package model.attribute;

class AttributeType {
    var uid : String ;

    public function new( uid : String ) {
        this.uid = uid ;
    }
	
	public function getUid() : String {
		return this.uid;
	}

}