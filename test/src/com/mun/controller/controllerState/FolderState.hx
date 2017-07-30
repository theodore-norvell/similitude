package com.mun.controller.controllerState;

import js.Browser;
import js.html.Blob;
import js.html.URL;
import haxe.Json;
import js.jquery.JQuery;
import js.Browser;
import js.html.DOMElement;
import com.mun.controller.componentUpdate.UpdateCanvas;
import com.mun.controller.componentUpdate.UpdateToolBar;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Folder;
import com.mun.model.component.FolderI;
import com.mun.model.enumeration.F_STATE;
class FolderState {
    var currentState:F_STATE;

    var folder:FolderI;
    var circuitDiagram:CircuitDiagramI;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var updateToolBar:UpdateToolBar;
    var updateCanvas:UpdateCanvas;
    var sideBar:SideBar;
    var controllerCanvasContext:ControllerCanvasContext;

    var updateCircuitDiagramMap:Map<CircuitDiagramI, UpdateCircuitDiagram>;
    var updateToolBarMap:Map<CircuitDiagramI, UpdateToolBar>;
    var updateCanvasMap:Map<CircuitDiagramI, UpdateCanvas>;
    var sideBarMap:Map<CircuitDiagramI, SideBar>;
    var controllerCanvasContextMap:Map<CircuitDiagramI, ControllerCanvasContext>;

    var circuitDiagramArray:Array<CircuitDiagramI>;
    var previouseCircuitDiagramArray:Array<CircuitDiagramI>;
    var currentIndex:Int = -1;

    var searchName:String;
    public function new() {
        updateCircuitDiagramMap = new Map<CircuitDiagramI, UpdateCircuitDiagram>();
        updateToolBarMap = new Map<CircuitDiagramI, UpdateToolBar>();
        updateCanvasMap = new Map<CircuitDiagramI, UpdateCanvas>();
        sideBarMap = new Map<CircuitDiagramI, SideBar>();
        controllerCanvasContextMap = new Map<CircuitDiagramI, ControllerCanvasContext>();

        circuitDiagramArray = new Array<CircuitDiagramI>();
        previouseCircuitDiagramArray = new Array<CircuitDiagramI>();

        folder = new Folder();
        currentState = F_STATE.IDLE;
        checkState();

        Browser.document.getElementById("createNewCircuitDiagram").onclick = function(){
            currentState = F_STATE.CREATE;
            checkState();
        };

        Browser.document.getElementById("previouseCD").onclick = function(){
            currentState = F_STATE.PREVIOUS;
            checkState();
        };

        Browser.document.getElementById("nextCD").onclick = function(){
            currentState = F_STATE.NEXT;
            checkState();
        };
        new JQuery("#search_circuitdiagram").bind('input porpertychange', function(){
            searchName = new JQuery(Browser.document.getElementById("search_circuitdiagram")).val();

            currentState = F_STATE.SEARCH;
            checkState();
        });
        new JQuery("#nameofcd").bind('input porpertychange', function(){
            var success:Bool = folder.changeCircuitDiagramName(circuitDiagram.get_name(),new JQuery(Browser.document.getElementById("nameofcd")).val(), circuitDiagram);
            if(success){
                new JQuery("#nameofcddiv").removeClass("has-error").addClass("has-success");
                Browser.document.getElementById("nameofcdlabel").innerText = "Success!";
                new JQuery("#nameofcdspan1").removeClass("glyphicon-remove").addClass("glyphicon-ok");
            }else{
                new JQuery("#nameofcddiv").removeClass("has-success").addClass("has-error");
                Browser.document.getElementById("nameofcdlabel").innerText = "Failed!";
                new JQuery("#nameofcdspan1").removeClass("glyphicon-ok").addClass("glyphicon-remove");
            }
        });

        Browser.document.getElementById("download").onclick = function(){
            var blob:Blob = new Blob([Json.stringify(circuitDiagram.createJSon())], {type: "application/json"});
            var a:DOMElement = Browser.document.createAnchorElement();
            var url = URL.createObjectURL(blob);
            var filename = circuitDiagram.get_name()+'.json';
            a.setAttribute("href", url);
            a.setAttribute("download", filename);
            a.click();
            URL.revokeObjectURL(url);
        };
    }

    function checkState(){
        switch(currentState){
            case F_STATE.IDLE:{
                currentState = F_STATE.CREATE;
                checkState();

                currentState = F_STATE.CURRENT;
                checkState();
            };
            case F_STATE.CURRENT : {
                //wait for instructrion
                currentIndex = circuitDiagramArray.indexOf(circuitDiagram);
                new JQuery(Browser.document.getElementById("nameofcd")).val(circuitDiagram.get_name());

                if(circuitDiagramArray.length <= 1){
                    setButtonDisability(Browser.document.getElementById("previouseCD"), true);
                    setButtonDisability(Browser.document.getElementById("nextCD"), true);
                }else if(previouseCircuitDiagramArray.length == 0){
                    setButtonDisability(Browser.document.getElementById("previouseCD"), true);
                    if(currentIndex < circuitDiagramArray.length -1){
                        setButtonDisability(Browser.document.getElementById("nextCD"), false);
                    }else{
                        setButtonDisability(Browser.document.getElementById("nextCD"), true);
                    }
                }else if(previouseCircuitDiagramArray.length > 0){
                    setButtonDisability(Browser.document.getElementById("previouseCD"), false);
                    if(currentIndex < circuitDiagramArray.length -1){
                        setButtonDisability(Browser.document.getElementById("nextCD"), false);
                    }else{
                        setButtonDisability(Browser.document.getElementById("nextCD"), true);
                    }
                }else{//The program shouldn't step into this line.
                    setButtonDisability(Browser.document.getElementById("previouseCD"), false);
                    setButtonDisability(Browser.document.getElementById("nextCD"), false);
                }
                updateCircuitDiagram.redrawCanvas();
            };
            case F_STATE.CREATE : {//create a new circuit diagram
                if(circuitDiagram != null){
                    previouseCircuitDiagramArray.push(circuitDiagram);
                }

                createATotallyNewCircuitDiagram();

                circuitDiagramArray .push(circuitDiagram);

                currentIndex = circuitDiagramArray.length - 1;

                //reset the alert
                new JQuery("#nameofcddiv").removeClass("has-error").removeClass("has-success");
                Browser.document.getElementById("nameofcdlabel").innerText = "";
                new JQuery("#nameofcdspan1").removeClass("glyphicon-remove").removeClass("glyphicon-ok");

                currentState = F_STATE.CURRENT;

                checkState();
            };
            case F_STATE.NEXT :{
                if(currentIndex < circuitDiagramArray.length - 1){
                    previouseCircuitDiagramArray.push(circuitDiagram);
                    setToCurrentCircuitDiagram(circuitDiagramArray[currentIndex + 1].get_name());
                    currentIndex = currentIndex + 1;
                }
                currentState = F_STATE.CURRENT;

                checkState();
            };
            case F_STATE.SEARCH : {
                if(searchName != "" && searchName != null){
                    var html:String = "";
                    var recordSearchResultList:Array<CircuitDiagramI> = new Array<CircuitDiagramI>();
                    if(circuitDiagramArray.length != 0){
                        for(i in circuitDiagramArray){
                            if(i.get_name().indexOf(searchName.toLowerCase()) != -1 || i.get_name().indexOf(searchName.toUpperCase()) != -1 || i.get_name() == searchName){
                                html += "<li><a id=\""+ i.get_name() +"\"> " + i.get_name() +"</a></li>";
                                recordSearchResultList.push(i);
                            }
                        }
                    }

                    Browser.document.getElementById("circuitDiagramHintList").innerHTML = html;
                    Browser.document.getElementById("circuitDiagramHintList").style.display = "table";

                    for(i in recordSearchResultList){
                        Browser.document.getElementById(i.get_name()).onclick = function(){
                            previouseCircuitDiagramArray.push(circuitDiagram);

                            setToCurrentCircuitDiagram(i.get_name());

                            currentIndex = circuitDiagramArray.indexOf(i);

                            Browser.document.getElementById("circuitDiagramHintList").style.display = "none";
                            new JQuery(Browser.document.getElementById("search_circuitdiagram")).val("");

                            currentState = F_STATE.CURRENT;

                            checkState();
                        }
                    }
                }else{
                    Browser.document.getElementById("circuitDiagramHintList").style.display = "none";
                }

                currentState = F_STATE.CURRENT;

                checkState();
            };
            case F_STATE.PREVIOUS : {
                //go back to the previouse circuit diagram
                if(previouseCircuitDiagramArray.length != 0){
                    var cd:CircuitDiagramI = previouseCircuitDiagramArray.pop();

                    while(cd == circuitDiagram){
                        cd = previouseCircuitDiagramArray.pop();
                    }

                    setToCurrentCircuitDiagram(cd.get_name());
                    currentIndex = circuitDiagramArray.indexOf(circuitDiagram);
                }

                currentState = F_STATE.CURRENT;

                checkState();
            };
            default : {
                //do nothing.
            }
        }
    }

    function setToCurrentCircuitDiagram(name:String){
        for(i in controllerCanvasContextMap){
            i.disableAllTheEvent();
        }
        for(i in updateToolBarMap){
            i.disableAllEvent();
        }

        circuitDiagram = folder.findCircuitDiagram(name);
        updateCircuitDiagram = updateCircuitDiagramMap[circuitDiagram];
        updateToolBar = updateToolBarMap[circuitDiagram];
        updateToolBar.enableAllEvent();
        updateCanvas = updateCanvasMap[circuitDiagram];
        sideBar = sideBarMap[circuitDiagram];
        controllerCanvasContext = controllerCanvasContextMap[circuitDiagram];
        controllerCanvasContext.enableAllTheEvent();
    }

    function createATotallyNewCircuitDiagram(){
        circuitDiagram = folder.createNewCircuitDiagram();

        updateCircuitDiagram = new UpdateCircuitDiagram(circuitDiagram);
        circuitDiagram.set_commandManager(updateCircuitDiagram.get_commandManager());

        updateToolBar = new UpdateToolBar(updateCircuitDiagram);
        updateCircuitDiagram.setUpdateToolBar(updateToolBar);

        updateCanvas = new UpdateCanvas(circuitDiagram, updateCircuitDiagram.get_transform());
        updateCircuitDiagram.setUpdateCanvas(updateCanvas);

        sideBar = new SideBar(updateCircuitDiagram);

        controllerCanvasContext = new ControllerCanvasContext(circuitDiagram, updateCircuitDiagram, sideBar, updateToolBar);
        sideBar.setControllerCanvasContext(controllerCanvasContext);

        pushToMap();
    }

    function pushToMap(){
        updateCircuitDiagramMap.set(circuitDiagram, updateCircuitDiagram);
        updateToolBarMap.set(circuitDiagram, updateToolBar);
        updateCanvasMap.set(circuitDiagram, updateCanvas);
        sideBarMap.set(circuitDiagram, sideBar);
        controllerCanvasContextMap.set(circuitDiagram, controllerCanvasContext);
    }

    function setButtonDisability(button:DOMElement,disable:Bool){
        if(disable){
            button.setAttribute("disabled", "disabled");
        }else{
            new JQuery(button).removeAttr("disabled");
        }
    }
}
