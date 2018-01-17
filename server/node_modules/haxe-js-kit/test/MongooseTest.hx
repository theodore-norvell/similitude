package test;

import js.npm.mongoose.macro.Model;

typedef StuffData = {
	test : String,
	foo : Int,
	?bar : {
		hello : String,
		world : Array<Dynamic>
	}
}

// declare the model
// the typedef fields will be "copied" to Stuff instance
@:schemaOptions({
    autoIndex: true
})
class Stuff extends Model<StuffData>{}
class StuffManager extends js.npm.mongoose.macro.Manager<StuffData,Stuff>{}

class MongooseTest implements util.Async {

	static function main(){
		// connect
		var db = new js.npm.mongoose.Mongoose();
		db.connect("mongodb://localhost/test_mongoose");
		
		// build the model
		var stuff = StuffManager.build(db, "Stuff");
		
		// use the model
		trace("running test");
		var err = @async stuff.remove({});

		trace("cleared DB");
		var d = {
			test : "test",
			foo : 1
		};

		var err,doc = @async stuff.create( d );
		trace("CREATE 1", err,doc);
		var err,doc = @async stuff.create( { test : "test", foo : 13 } );
		trace("CREATE 2", err,doc);

		stuff.update( {test:"test"}, {foo:2}, {multi:true}, function(err,response){
			js.Node.console.log(js.Kit.arguments);
		});
		

		trace("foo", doc.foo);
		trace("test",doc.test);

	}

}
