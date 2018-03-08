package ;

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
        var exp= ~/\s+/;
        var check=~/^\w*$/;
        var cdname=exp.replace(folderState.circuitDiagram.get_name(),"_");
        if(check.match(cdname)){
            JQuery.ajax( { type:"post",
                url: "http://127.0.0.1:3000/app/users/folder?username=test&new=false&folder=root/test/abc&fileName="+cdname,
                contentType: "application/json",
                dataType:"text",
                data:o}
            )
            .done( function (text) {
                trace(text);
//            trace(Type.getClass(TJSON.parse(text)));
//            folderState.load(TJSON.parse(text));

            });
        }
    }
    static public function main() {
        var folderState:FolderState = new FolderState() ;
        var test:Test = new Test(folderState);

        var r = ~/\s+/;
        var t = ~/^\w*$/;
        trace(r.match("ABC    "));
        var a=r.replace("ABC 123","_");
        trace(r.replace("ABC 123","_"));
        trace(t.match(a));


    }
}
