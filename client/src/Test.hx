package ;

import com.mun.controller.controllerState.FolderState;
import com.mun.assertions.Assert;

// TODO Rename this class to Main
class Test {
    static public function main() {
        trace( "Hello") ;
        var a = 2 ;
        var b = 3 ;
        Assert.assert( a==b ) ;
        var folderState:FolderState = new FolderState() ;
    }
}
