import buddy.BuddySuite;
import js.npm.sequelize.DataTypes;
import js.npm.sequelize.Instance;
import js.npm.sequelize.Model;
import js.npm.sequelize.Sequelize;
using buddy.Should;


/**
 * Tests sequelize externs.
 * Needs Sqlite3 installed to run these tests.
 * 
 * @author TiagoLr
 */
class TestSequelize extends BuddySuite {
	
    public function new() {
        describe("Testing Sequelize", {
            timeoutMs = 200;
			
			var sequelize:Sequelize = null;
			var model:Model;
			var now:Date;
			
            before( function (done) {
				// Initialize the database only once
				if (sequelize != null) { 
					done();
					return;
				}
				
				now = Date.now();
				sequelize = new Sequelize( {
					logging: false,
					pool: {
						max: 5,
						min: 0,
						idle: 10000
					},
					dialect:'sqlite',
				});
				
				model = sequelize.define('model', {
					str: { type : DataTypes.STRING(24), allowNull:false, unique:true },
					str2: { type : DataTypes.STRING(), allowNull :false},
					text: { type: DataTypes.TEXT() },
					int: { type:DataTypes.INTEGER({unsigned:true}), defaultValue:0 },
					float: { type:DataTypes.FLOAT({unsigned:true}), defaultValue:0 },
					date: { 
						type:DataTypes.DATE(),
						validate: {isDate:true}
					},
				});
				
				sequelize.sync( { force:true } ).then(function () {
					done();
				});
            });

			
            it("should store a new entry in the database", function (done) {
				return model.create( {
					str:'_str',
					str2:'_str2',
					text:'_text',
					int:123,
					float:123.123,
					date:now
				})
				.then(function () {
					return model.find( {
						'where': {
							str:'_str'
						}
					});
				})
				.then(function (i:Instance) {
					i.should.not.be(null);
					cast(i.get('str'), String).should.be('_str');
					cast(i.get('str2'), String).should.be('_str2');
					cast(i.get('text'), String).should.be('_text');
					cast(i.get('int'), Int).should.be(123);
					cast(i.get('float'), Float).should.be(123.123);
					cast(i.get('date'), Date).toString().should.be(now.toString());
					done();
				});
            });
			
			
			it("should observe changes after entry update", function (done) {
				return model.find( { 
					'where': {
						str:'_str'
					}
				}).then(function (i:Instance) {
					return i.update( { text:'new text' } );
				}).then(function (i:Instance) {
					cast(i.get('text'), String).should.be('new text');
					done();
				});
			});
			
			
			it("should throw exception if data validation fails", function(done) {
				return model.find( { 
					'where': {
						str:'_str'
					}
				}).then(function (i:Instance) {
					return i.update( { date:"invalid date string" } );
				}).then(function (i:Instance) {
					fail('Exception not thrown');
					done();
				}).Catch (function () {
					done();
				});
			});
			
			it("should remove entry after delete", function (done) {
				return model.find( { 
					'where': {
						str:'_str'
					}
				}).then(function (i:Instance) {
					return i.destroy();
				}).then(function () {
					return model.count();
				}).then(function (count:Int) {
					count.should.be(0);
					done();
				});
			});
			
        });
    }
}
	
