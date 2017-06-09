package com.mun.type;

import com.mun.model.component.Port;
import com.mun.model.component.Component;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Link;
typedef Coordinate = {
    var xPosition:Float;
    var yPosition:Float;
}

typedef Object = {
    var link:Link;
    var component:Component;
    var endPoint:Endpoint;
    var port:Port;
}

typedef LinkAndComponentArray = {
    var linkArray:Array<Link>;
    var componentArray:Array<Component>;
}

typedef LinkAndComponentAndEndpointArray = {
    var linkArray:Array<Link>;
    var componentArray:Array<Component>;
    var endpointArray:Array<Endpoint>;
}


