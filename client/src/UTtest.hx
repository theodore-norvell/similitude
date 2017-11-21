package ;

// TODO Rename this class to ClientMain
import com.mun.unitest.UnitTest;
class UTtest {
    static public function main() {
        var r = new haxe.unit.TestRunner();
        r.add(new UnitTest());
        // your can add others TestCase here

        // finally, run the tests
        r.run();
    }
}

