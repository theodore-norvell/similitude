import model.observe.* ; 

class MockObserver implements Observer {
    var map = new Map<ObservableI, Int>() ;

    public function new() { } 
    public function update(target:ObservableI,?data: Any) : Void {
        var count = if( map.exists( target ) ) map.get(target) else 0 ;
        map.set( target, count + 1 ) ;
    }

    public function count( target : ObservableI ) : Int {
        return if( map.exists( target ) ) map.get(target) else 0 ;
    }
}