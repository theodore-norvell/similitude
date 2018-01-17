import buddy.BuddySuite;
import util.Async;
using buddy.Should;


/**
 * Tests sequelize externs.
 * Needs Sqlite3 installed to run these tests.
 * 
 * @author TiagoLr
 */
class TestAsync extends BuddySuite implements Async {
	
    public function new() {
        describe("Testing @async", {
            timeoutMs = 200;
			
            it("should support methods with void parameter callback");
			it("should support methods with one parameter callback");
			it("should support methods with multiple parameters callback");
			it("should support blocks");
        });
    }
}
	
