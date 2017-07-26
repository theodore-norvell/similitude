package com.mun.controller.file;

import js.Browser;
import js.jquery.JQuery;
import js.html.DOMElement;
import com.mun.model.component.CircuitDiagramI;
class FileSystem {
    var circuitDiagram:CircuitDiagramI;
    var downLoadButton:DOMElement;
    var downLoad_a:DOMElement;

    public function new(circuitDiagram:CircuitDiagramI) {
        this.circuitDiagram = circuitDiagram;

        downLoadButton = Browser.document.getElementById("download");
        downLoadButton.onclick = download;

        downLoad_a = Browser.document.getElementById("download_a");
    }

    function download(){
        var xmlDoc = Xml.createDocument();
        xmlDoc.addChild(circuitDiagram.createXML());
        trace(xmlDoc.toString());

//        var blob:Blob = new Blob([xml.toString()]);
//        downLoad_a.setAttribute("download", circuitDiagram.get_name());
//        downLoad_a.setAttribute("href", URL.createObjectURL(blob));
//        downLoad_a.click();

    }

    public function disableDownLoadButton(disable:Bool){
        if(disable){
            downLoadButton.setAttribute("disabled", "disabled");
        }else{
            new JQuery(downLoadButton).removeAttr("disabled");
        }
    }
}
