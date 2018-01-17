import buddy.BuddySuite;
import buddy.internal.sys.Js;
import js.npm.mongoose.macro.Model;
import js.npm.Mongoose.mongoose;
import util.Async;
using buddy.Should;

typedef TestSchema = {
	test : String,
	foo : Int,
	?bar : {
		hello : String,
		world : Array<Dynamic>
	}
}

@:schemaOptions({autoIndex: true})
class TestModelDef extends Model<TestSchema>{}
class TestModel extends js.npm.mongoose.macro.Manager<TestSchema,TestModelDef> { }

/**
 * Tests mongoose externs.
 * Callbacks are used instead of @async since it conflicts with buddy tests and
 * generates compile time errors.
 */
class TestMongoose extends BuddySuite {

	public function new() {
		var db:js.npm.mongoose.Mongoose = null;
		var model:TestModel = null;
		
		describe("Testing mongoose connector", {
			timeoutMs = 200;
			
			before(function (done) {
				if (db != null) {
					done(); // initialize only once
					return;
				}
				
				db = mongoose.connect("mongodb://localhost/test_mongoose");
				model = TestModel.build(db, "test_model");
				untyped db.connection.on('open', function() {
					done();
				});
			});
			
			
			it("should connect to the database", {
				db.connection.readyState.should.be(1);
			});
			
			
			it("should contain created models", {
				var models = db.modelNames();
				models.length.should.be(1);
				models.should.contain("test_model");
			});
			
			
			it("should store data in the database", function(done) {
				model.create( { test : "test", foo : 13 }, function (err,doc) {
					model.find( { test:"test" }, function (err, arr) {
						arr.length.should.be(1);
						arr[0].foo.should.be(13);
						done();
					});
				});
			});
	
			
			it("should update data in the database", function (done) {
				model.update( { test:"test" }, { foo:2 }, { multi:true }, function (err, raw) {
					err.should.be(null);
					raw.nModified.should.be(1);
					done();
				});
			});
			
			
			it("should not update models with invalid data", function (done) {
				model.update( { test:"test" }, { foo:"invalid data type" }, function (err, raw) {
					err.should.not.be(null);
					raw.nModified.should.be(0);
					done();
				});
			});
			
			
			it("should clear the database", function(done) {
				model.remove( { }, function (err) {
					model.count(function (err,res) {
						res.should.be(0);
						done();
					});
				});
			});
			
			
			it("should disconnect from database at the end", function(done) {
				db.disconnect( function(err) {
					db.connection.readyState.should.be(0);
					done();
				});
			});
			
		});
		
	}

}
