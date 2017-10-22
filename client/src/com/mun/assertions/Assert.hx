package com.mun.assertions;


class Assert {
    static public function assert( e:Bool ) {
        if( !e ) throw new AssertionFailure() ;
    }
}


class AssertionFailure {
    public function new() { }

    public function toString() {
        return "Assertion failure" ;
    }
}