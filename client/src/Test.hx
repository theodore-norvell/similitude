package ;

import haxe.Unserializer;
import haxe.Serializer;
import haxe.Unserializer;
import com.mun.model.enumeration.ORIENTATION;
import tjson.TJSON;
import js.RegExp;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.CircuitDiagram;
import tjson.TJSON;
import com.mun.controller.controllerState.FolderState;
import js.jquery.JQuery;
import tjson.TJSON;
import js.html.DOMElement;
import js.Browser;
import com.mun.model.component.Component;
import haxe.Serializer;
import haxe.Unserializer;


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
        Serializer.USE_CACHE=true;
        Serializer.USE_ENUM_INDEX=true;
        var o = Serializer.run(folderState.circuitDiagram);
        trace(o);
        trace("test00");
        trace(Type.getClass(Unserializer.run(o)));
        trace("test01");
        var tempJson = {circuit: o};
        var exp= ~/\s+/;
        var check=~/^\w*$/;
        var cdname=exp.replace(folderState.circuitDiagram.get_name(),"_");
        if(check.match(cdname)){
            trace("pass");
            JQuery.ajax( { type:"post",
                url: "http://127.0.0.1:3000/app/users?username=test&new=false&folder=root/test/abc&fileName="+cdname,
                contentType: "application/json",
                data:haxe.Json.stringify(tempJson)}
            )
            .done( function (text) {
                trace(text);
                trace(Type.getClass(Unserializer.run(text)));
//            trace(Type.getClass(TJSON.parse(text)));
            folderState.load(Unserializer.run(text));

            });
        }
        else{
            trace("name error");
        }
    }
    static public function main() {
        var folderState:FolderState = new FolderState() ;
        var test:Test = new Test(folderState);

//        var serializer = new Serializer();
//        serializer.serialize(ORIENTATION.EAST);
//        trace(Type.getClass(Serializer.run(ORIENTATION.EAST)));
//        trace("abc");



    }
}
