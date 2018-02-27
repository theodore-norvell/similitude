package ;

import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.CircuitDiagram;
import tjson.TJSON;
import com.mun.controller.controllerState.FolderState;
import js.jquery.JQuery;
import tjson.TJSON;
import js.html.DOMElement;
import js.Browser;
import com.mun.model.component.Component;


// TODO Rename this class to ClientMain
class Test {
    var folderState:FolderState;
    var b:DOMElement;

    public function new(f:FolderState){
        folderState=f;
        b= Browser.document.getElementById("upload");
        b.addEventListener('click', regist, false);
    }

    public function regist(){
        var o = TJSON.encode(folderState.circuitDiagram);
//        trace(o);
//        trace(folderState.circuitDiagram.get_name());
        JQuery.ajax( { type:"post",
            url: "http://127.0.0.1:3000/app/users?username=test&new=true&folder=root/abc/dd/cd&fileName="+folderState.circuitDiagram.get_name(),
            contentType: "application/json",
            dataType:"text",
            data:o}
        )
        .done( function (text) {
            trace(text);
//            trace(text);
//            trace( "This is the text" + text ) ;
//            trace( "It is a " + Type.getClass( text ) ) ;
//            trace(TJSON.parse(haxe.Json.stringify(text)));
//            trace(Type.getClass(TJSON.parse(haxe.Json.stringify(text))));
//            var t=cast(TJSON.parse(text),CircuitDiagramI);
//            trace(t);
//            for(i in t.get_componentIterator()){
//                trace(i.get_componentKind());
//            }
            trace(Type.getClass(TJSON.parse(text)));
            folderState.load(TJSON.parse(text));

        });
    }
    static public function main() {
        var folderState:FolderState = new FolderState() ;
        var test:Test = new Test(folderState);


    }
}
