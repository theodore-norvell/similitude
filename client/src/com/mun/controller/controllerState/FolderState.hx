package com.mun.controller.controllerState;

import com.mun.model.gates.CompoundComponent;
import haxe.Unserializer;
import Std;
import tjson.TJSON;
import js.html.KeyboardEvent;
import js.jquery.Event;
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import js.Browser;
import haxe.Json;
import js.html.FileReader;
import js.html.Blob;
import js.html.URL;
import js.jquery.JQuery;
import js.html.DOMElement;
import com.mun.controller.componentUpdate.UpdateCanvas;
import com.mun.controller.componentUpdate.UpdateToolBar;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Folder;
import com.mun.model.component.FolderI;
import com.mun.model.enumeration.F_STATE;
import com.mun.global.Constant.*;
import haxe.Serializer;
import haxe.Unserializer;
import com.dongxiguo.continuation.Async;


class FolderState implements Async{
    var currentState:F_STATE;

    var folder:FolderI;
    public var circuitDiagram:CircuitDiagramI;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var updateToolBar:UpdateToolBar;
    var updateCanvas:UpdateCanvas;
    var sideBar:SideBar;
    var controllerCanvasContext:ControllerCanvasContext;
    var canvas:CanvasElement;
    var context:CanvasRenderingContext2D;

    var updateCircuitDiagramMap:Map<CircuitDiagramI, UpdateCircuitDiagram>;
    var updateToolBarMap:Map<CircuitDiagramI, UpdateToolBar>;
    var updateCanvasMap:Map<CircuitDiagramI, UpdateCanvas>;
    var sideBarMap:Map<CircuitDiagramI, SideBar>;
    var controllerCanvasContextMap:Map<CircuitDiagramI, ControllerCanvasContext>;
    var canvasMap:Map<CircuitDiagramI, CanvasElement>;
    var contextMap:Map<CircuitDiagramI, CanvasRenderingContext2D>;

    var circuitDiagramArray:Array<CircuitDiagramI>;
    var previouseCircuitDiagramArray:Array<CircuitDiagramI>;
    var currentIndex:Int = -1;

    var fileListCount:Int =0;

    var searchName:String;

    public function new() {
        updateCircuitDiagramMap = new Map<CircuitDiagramI, UpdateCircuitDiagram>();
        updateToolBarMap = new Map<CircuitDiagramI, UpdateToolBar>();
        updateCanvasMap = new Map<CircuitDiagramI, UpdateCanvas>();
        sideBarMap = new Map<CircuitDiagramI, SideBar>();
        controllerCanvasContextMap = new Map<CircuitDiagramI, ControllerCanvasContext>();
        canvasMap = new Map<CircuitDiagramI, CanvasElement>();
        contextMap = new Map<CircuitDiagramI, CanvasRenderingContext2D>();

        circuitDiagramArray = new Array<CircuitDiagramI>();
        previouseCircuitDiagramArray = new Array<CircuitDiagramI>();

        folder = new Folder();
        currentState = F_STATE.IDLE;
        checkState();

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
        new JQuery("#nameofcd").bind('keydown', function(key:KeyboardEvent){
            if(key.keyCode == 13){
                var oldname:String = circuitDiagram.get_name();
                var newName:String = new JQuery("#nameofcd").val();
                var success:Bool = folder.changeCircuitDiagramName(oldname, newName, circuitDiagram);
                if(success){
                    new JQuery("#nameofcddiv").removeClass("has-error").addClass("has-success");

                    changeNameForHTMLStuff(oldname, newName);
                    for(i in sideBarMap.iterator()){
                        if(i.isGateNameExist(oldname)){
                            i.removeCompoundComponentToGateNameArray(oldname);
                            i.pushCompoundComponentToGateNameArray(newName);
                        }
                    }

                }else{
                    new JQuery("#nameofcddiv").removeClass("has-success").addClass("has-error");
                }
            }
        });

        new JQuery("#nameofcd").bind("focusout", function(){
            new JQuery("#nameofcd").val(circuitDiagram.get_name());
            new JQuery("#nameofcddiv").removeClass("has-error");
        });

        Browser.document.getElementById("fileClose").onclick = function(){
            new JQuery('#alert').css('opacity', 0.5).hide();
            new JQuery('#alert2').css('opacity', 1).hide();
            new JQuery('#text1').css('opacity', 1).hide();
            new JQuery('#text2').css('opacity', 1).hide();
        }

        Browser.document.getElementById("download").onclick = function(){
            new JQuery('#alert').css('opacity', 0.5).show();
            new JQuery('#alert2').css('opacity', 1).show();
            new JQuery('#text1').css('opacity', 1).show();
            new JQuery('#text2').css('opacity', 1).show();
            var url = Browser.window.location.href.split("?");
            var username:String = (url[1].split("="))[1];
            new JQuery('#FileCollapseList').html("<a data-toggle=\"collapse\" href=\"#FileCollapseList"+Std.string(fileListCount)+"\" id=\"path"+username+"\"><img src=\"/client/src/icon/folder.png\">"+username+"</a>");

            new JQuery('#FileCollapseList').append("<div id=\"FileCollapseList"+Std.string(fileListCount)+"\" class=\"panel-collapse collapse out\" >
                            <div class=\"container-fluid\" id=\"Fieldpath_root"+username+"\">
                            </div>
                        </div>
                    </div>");
            fileListCount++;
            new JQuery('#downloadFile').hide();
            new JQuery('#versionList').hide();
            new JQuery('#deleteFile').hide();
            Browser.document.getElementById("path"+username).onclick = function(){
                new JQuery('#FolderNameLabel').show();
                new JQuery('#createFolder').show();
                new JQuery('#uploadCircuit').show();
                new JQuery('#downloadFile').hide();
                new JQuery('#versionList').hide();
                new JQuery('#deleteFile').hide();
                new JQuery('#Fieldpath_root'+username).html("");
                var path:Array<String>=new Array<String>();
                path.push("root");
                path.push(username);
                Browser.document.getElementById("createFolder").onclick= function(){
                    if(Browser.document.getElementById("FolderNameLabel").itemValue!=""){
                        createFolder(username,"root/"+username+"/"+Std.string(new JQuery('#newFolderName').val()));
                    }
                    else{

                    }
                };
                new JQuery('#selectCircuit').html("");
                for(i in circuitDiagramArray){
                    new JQuery('#selectCircuit').append("<option>"+i.get_name()+"</option>");
                }
                Browser.document.getElementById("uploadCD").onclick= function(){
                    uploadCircuit(Std.string(new JQuery('#selectList').val()),"root/"+username,username);
                };
                newCollapse(path);
            };
        };


        var CurrentUrl = Browser.window.location.href.split("?");
        var CurrentUsername:String = (CurrentUrl[1].split("="))[1];
        var CurrentfileListCount:Int = 0;
        new JQuery('#righttab').html("<a data-toggle=\"collapse\" href=\"#CurrentFileCollapseList"+Std.string(CurrentfileListCount)+"\" id=\"Currentpath"+CurrentUsername+"\"><img src=\"/client/src/icon/folder.png\">"+CurrentUsername+"</a>"
                                      +"<div id=\"CurrentFileCollapseList"+Std.string(CurrentfileListCount)+"\" class=\"panel-collapse collapse out\" >
                            <div class=\"container-fluid\" id=\"CurrentFieldpath_root"+CurrentUsername+"\">
                            </div>
                        </div>
                    </div>");
        CurrentfileListCount++;
        Browser.document.getElementById("Currentpath"+CurrentUsername).onclick = function(){
            new JQuery('#CurrentFieldpath_root'+CurrentUsername).html("");
            var Currentpath:Array<String>=new Array<String>();
            Currentpath.push("root");
            Currentpath.push(CurrentUsername);
            currentnewCollapse(Currentpath,CurrentfileListCount);
        };




        Browser.document.getElementById("import").onclick = function(){
            var files = untyped document.getElementById('selectFiles').files;

            var fr:FileReader = new FileReader();

            fr.onload = function(e) {
                var result = Json.parse(e.target.result);
                var formatted = Json.stringify(result, null, "2");
                formatted = Json.parse(formatted);
                Browser.window.console.log(formatted);
            }

            fr.readAsText(files.item(0));
        };


        Browser.document.getElementById("createNewCircuitDiagram").onclick = function(){
            new JQuery("li[id$='-li']").removeClass("active");
            new JQuery(".tab-pane[id$='-panel']").removeClass("active");
            new JQuery(".tab-pane[id$='-sidebar']").removeClass("active");
            currentState = F_STATE.CREATE;
            checkState();
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
            case F_STATE.CREATE : {//create a IntAttr circuit diagram
                if(circuitDiagram != null){
                    previouseCircuitDiagramArray.push(circuitDiagram);
                }

                createATotallyNewCircuitDiagram();

                for(i in sideBarMap.iterator()){
                    for(j in circuitDiagramArray){
                        if(i.getCircuitDiagram() != j){
                            i.pushCompoundComponentToGateNameArray(j.get_name());
                        }
                    }
                }

                currentIndex = circuitDiagramArray.length - 1;

                //reset the alert
                new JQuery("#nameofcddiv").removeClass("has-error").removeClass("has-success");
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
                            if(i.get_name().toLowerCase().indexOf(searchName.toLowerCase()) != -1 || i.get_name().toUpperCase().indexOf(searchName.toUpperCase()) != -1 || i.get_name().indexOf(searchName) != -1){
                                html += "<li><a id=\""+ i.get_name() +"-searchCircuitDiagram\"> " + i.get_name() +"</a></li>";
                                recordSearchResultList.push(i);
                            }
                        }
                    }

                    Browser.document.getElementById("circuitDiagramHintList").innerHTML = html;
                    Browser.document.getElementById("circuitDiagramHintList").style.display = "table";

                    for(i in recordSearchResultList){
                        Browser.document.getElementById(i.get_name() + "-searchCircuitDiagram").onclick = function(event:Event){
                            var id:String = untyped event.target.id;
                            id = id.substring(0, id.indexOf("-"));
                            previouseCircuitDiagramArray.push(circuitDiagram);

                            setToCurrentCircuitDiagram(id);
                            new JQuery("li[id$='-li']").removeClass("active");
                            new JQuery(".tab-pane[id$='-panel']").removeClass("active");
                            new JQuery(".tab-pane[id$='-sidebar']").removeClass("active");
                            new JQuery(".tab-pane[id^='"+id+"']").addClass("active");
                            new JQuery("li[id^='"+id+"']").addClass("active");

                            currentIndex = circuitDiagramArray.indexOf(folder.findCircuitDiagram(id));

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
        circuitDiagram = folder.findCircuitDiagram(name);
        updateCircuitDiagram = updateCircuitDiagramMap[circuitDiagram];
        updateToolBar.unbindEventListener();
        updateToolBar = updateToolBarMap[circuitDiagram];
        updateToolBar.bindEventListener();
        updateCanvas.unbindEventListener();
        updateCanvas = updateCanvasMap[circuitDiagram];
        updateCanvas.bindEventListener();
        sideBar = sideBarMap[circuitDiagram];
        controllerCanvasContext = controllerCanvasContextMap[circuitDiagram];
        controllerCanvasContext.boxTypeList();
    }

    function createATotallyNewCircuitDiagram(){
        circuitDiagram = folder.createNewCircuitDiagram();
        circuitDiagramArray .push(circuitDiagram);
        addNewCicruitDiagramTab();
        createNewCanvas(circuitDiagram.get_name());

        updateCircuitDiagram = new UpdateCircuitDiagram(circuitDiagram, folder);
        circuitDiagram.set_commandManager(updateCircuitDiagram.get_commandManager());

        updateToolBar = new UpdateToolBar(updateCircuitDiagram);
        updateCircuitDiagram.setUpdateToolBar(updateToolBar);

        updateCanvas = new UpdateCanvas(circuitDiagram, canvas, context);
        updateCircuitDiagram.setUpdateCanvas(updateCanvas);

        sideBar = new SideBar(updateCircuitDiagram, circuitDiagram, folder);

        controllerCanvasContext = new ControllerCanvasContext(circuitDiagram, updateCircuitDiagram, sideBar, updateToolBar, canvas, updateCanvas);
        sideBar.setControllerCanvasContext(controllerCanvasContext);
        updateToolBar.setControllerCanvasContext(controllerCanvasContext);

        pushToMap();
    }

    public function load(cd:CircuitDiagramI){
        new JQuery("li[id$='-li']").removeClass("active");
        new JQuery(".tab-pane[id$='-panel']").removeClass("active");
        new JQuery(".tab-pane[id$='-sidebar']").removeClass("active");
        currentState = F_STATE.CREATE;
        if(circuitDiagram != null){
            previouseCircuitDiagramArray.push(circuitDiagram);
        }

        circuitDiagram = folder.add(cd);
        circuitDiagramArray .push(circuitDiagram);
        addNewCicruitDiagramTab();
        createNewCanvas(circuitDiagram.get_name());

        updateCircuitDiagram = new UpdateCircuitDiagram(circuitDiagram, folder);
        circuitDiagram.set_commandManager(updateCircuitDiagram.get_commandManager());

        updateToolBar = new UpdateToolBar(updateCircuitDiagram);
        updateCircuitDiagram.setUpdateToolBar(updateToolBar);

        updateCanvas = new UpdateCanvas(circuitDiagram, canvas, context);
        updateCircuitDiagram.setUpdateCanvas(updateCanvas);

        sideBar = new SideBar(updateCircuitDiagram, circuitDiagram, folder);

        controllerCanvasContext = new ControllerCanvasContext(circuitDiagram, updateCircuitDiagram, sideBar, updateToolBar, canvas, updateCanvas);
        sideBar.setControllerCanvasContext(controllerCanvasContext);
        updateToolBar.setControllerCanvasContext(controllerCanvasContext);

        pushToMap();

        for(i in sideBarMap.iterator()){
            for(j in circuitDiagramArray){
                if(i.getCircuitDiagram() != j){
                    i.pushCompoundComponentToGateNameArray(j.get_name());
                }
            }
        }

        currentIndex = circuitDiagramArray.length - 1;

        //reset the alert
        new JQuery("#nameofcddiv").removeClass("has-error").removeClass("has-success");
        new JQuery("#nameofcdspan1").removeClass("glyphicon-remove").removeClass("glyphicon-ok");

        currentState = F_STATE.CURRENT;

        checkState();
    }

    function changeNameForHTMLStuff(oldName:String,newName:String){
        Browser.document.getElementById(oldName+"-a").innerHTML = ""+newName+"<span id=\""+newName+"-close\" class=\"glyphicon glyphicon-remove\"></span>";
        registerCloseButton(newName);

        Browser.document.getElementById(oldName+"-a").setAttribute("href", newName+"-panel");
        Browser.document.getElementById(oldName+"-a").setAttribute("id", newName+"-a");
        Browser.document.getElementById(oldName+"-li").setAttribute("id", newName+"-li");

        Browser.document.getElementById(oldName+"-panel").setAttribute("id", newName+"-panel");
        Browser.document.getElementById("canvas-" + oldName).setAttribute("id", "canvas-"+newName);

        Browser.document.getElementById("flist-" + oldName).setAttribute("id", "flist-" + newName);
        Browser.document.getElementById(oldName+"-buttonGroupList").setAttribute("id", newName+"-buttonGroupList");
        Browser.document.getElementById("list-" + oldName).setAttribute("id", "list-" + newName);

        Browser.document.getElementById(oldName+"-fileList").setAttribute("href", "flist-" + newName);
        Browser.document.getElementById(oldName+"-fileList").setAttribute("id", newName+"-fileList");

        Browser.document.getElementById(oldName+"-buttonList").setAttribute("href", "list-" + newName);
        Browser.document.getElementById(oldName+"-buttonList").setAttribute("id", newName+"-buttonList");

        Browser.document.getElementById(oldName+"-search").setAttribute("id", newName+"-search");
        Browser.document.getElementById(oldName+"-sidebar").setAttribute("id", newName+"-sidebar");
    }

    function addNewCicruitDiagramTab(){

        var liHtmlString:String = "<li role=\"presentation\" id=\""+circuitDiagram.get_name()+ "-li\" class=\"active\"><a id=\""+circuitDiagram.get_name()+ "-a\" href=\"#"+circuitDiagram.get_name()+"-panel\" data-toggle=\"tab\">"+ circuitDiagram.get_name() + "<span id=\""+circuitDiagram.get_name()+"-close\" class=\"glyphicon glyphicon-remove\"></span></a></li>";
        var canvasHTMLString:String = "<div class=\"tab-pane active\" id=\""+circuitDiagram.get_name()+"-panel\"><canvas id=\"canvas-"+circuitDiagram.get_name()+"\" style=\"border: 1px solid;\">update your browser to enjoy canvas</canvas></div>";

        var lefdiveHTML:String = "<div class=\"tab-pane active\" id=\""+circuitDiagram.get_name()+"-sidebar\"><div class=\"col-sm-12 col-md-12 col-lg-12\">
        <form class=\"form-search\"><input class=\"input-medium search-query\" type=\"text\" id=\""+circuitDiagram.get_name()+"-search\" placeholder=\"Search...\" style=\"width: 100%\"/>
        </form></div><div class=\"tabbable col-sm-12 col-md-12 col-lg-12\"><ul class=\"nav nav-tabs\"><li role=\"presentation\" class=\"active\"><a href=\"#list-"+circuitDiagram.get_name()+"\" data-toggle=\"tab\" id=\""+circuitDiagram.get_name()+"-buttonList\">Button List</a>
        </li><li role=\"presentation\"><a href=\"#flist-"+circuitDiagram.get_name()+"\" data-toggle=\"tab\" id=\""+circuitDiagram.get_name()+"-fileList\">File List</a></li></ul>
        <div class=\"tab-content pre-scrollable\"><div class=\"tab-pane active\" id=\"list-"+circuitDiagram.get_name()+"\"><div id=\""+circuitDiagram.get_name()+"-buttonGroupList\" class=\"btn-group-vertical\" role=\"group\" aria-label=\"...\" style=\"border: 1px solid\">
        </div></div><div class=\"tab-pane\" id=\"flist-"+circuitDiagram.get_name()+"\"><p>Files</p></div></div></div></div>";

        new JQuery("#leftdivsidebartabcontent").append(lefdiveHTML);
        new JQuery("#circuitdiagramul").append(liHtmlString);
        new JQuery("#circuitdiagramcanvas").append(canvasHTMLString);

        Browser.document.getElementById(circuitDiagram.get_name()+"-li").onclick = function(event:Event){
            var id:String = untyped event.target.id;
            id = id.substring(0, id.indexOf("-"));

            previouseCircuitDiagramArray.push(circuitDiagram);
            setToCurrentCircuitDiagram(id);
            new JQuery(".tab-pane[id$='-panel']").removeClass("active");
            new JQuery(".tab-pane[id$='-sidebar']").removeClass("active");
            new JQuery(".tab-pane[id^='"+id+"-panel']").addClass("active");
            new JQuery(".tab-pane[id^='"+id+"-sidebar']").addClass("active");

            currentIndex = circuitDiagramArray.indexOf(circuitDiagram);

            currentState = F_STATE.CURRENT;
            checkState();
        };

        registerCloseButton(circuitDiagram.get_name());
    }

    function registerCloseButton(closeButtonNamePrefix:String){
        Browser.document.getElementById(closeButtonNamePrefix+"-close").onclick = function(event:Event){
            if(Browser.window.confirm("Close this Diagram means delete it forever, do you still want to do it?")){
                var id:String = untyped event.target.id;
                id = id.substring(0, id.indexOf("-"));
                Browser.document.getElementById(id+"-li").remove();
                Browser.document.getElementById(id+"-panel").remove();
                Browser.document.getElementById(id+"-sidebar").remove();

                //all of the html stuff has been deleted.
                deleteCircuitDiagram(id);

                if(circuitDiagramArray.length == 0){
                    circuitDiagram = null;
                    currentState = F_STATE.CREATE;
                    checkState();
                }else{
                    currentState = F_STATE.PREVIOUS;
                    checkState();
                    new JQuery("[id^='"+circuitDiagram.get_name()+"']").addClass("active");

                    currentState = F_STATE.CURRENT;
                    checkState();
                }
            }
        };
    }

    function deleteCircuitDiagram(name:String){
        var tempCd:CircuitDiagramI = folder.findCircuitDiagram(name);
        folder.removeCircuitDiagram(name);
        circuitDiagramArray.remove(tempCd);
        sideBar.removeCompoundComponentToGateNameArray(name);

        sideBarMap.remove(tempCd);
        updateCircuitDiagramMap.remove(circuitDiagram);
        updateToolBarMap.remove(circuitDiagram);
        updateCanvasMap.remove(circuitDiagram);
        sideBarMap.remove(circuitDiagram);
        controllerCanvasContextMap.remove(circuitDiagram);
        canvasMap.remove(circuitDiagram);
        contextMap.remove(circuitDiagram);

        previouseCircuitDiagramArray.remove(tempCd);
    }

    function createNewCanvas(name:String){
        var canvasElement:CanvasElement= cast Browser.document.getElementById("canvas-"+circuitDiagram.get_name());
         var canvasContext:CanvasRenderingContext2D= untyped canvasElement.getContext("2d");

        var backingStoreRatioDynamic : Dynamic = Reflect.field( canvasElement, "webKitBackingStorePixelRatio" ) ;
        if( backingStoreRatioDynamic == null )
            backingStoreRatioDynamic = Reflect.field( canvasElement, "mozBackingStorePixelRatio" ) ;
        if( backingStoreRatioDynamic == null )
            backingStoreRatioDynamic = Reflect.field( canvasElement, "msBackingStorePixelRatio" ) ;
        if( backingStoreRatioDynamic == null )
            backingStoreRatioDynamic = Reflect.field( canvasElement, "oBackingStorePixelRatio" ) ;
        if( backingStoreRatioDynamic == null )
            backingStoreRatioDynamic = Reflect.field( canvasElement, "backingStorePixelRatio" ) ;
        var backingStoreRatio : Float =
        if( backingStoreRatioDynamic == null ) 1.0
        else cast( backingStoreRatioDynamic, Float ) ;

        var pixelRatio:Int = cast Browser.window.devicePixelRatio/backingStoreRatio;
        var oldWidth:Int = cast Browser.window.innerWidth;
        var oldHeight:Int =cast Browser.window.innerHeight;
        canvasElement.width = cast oldWidth * pixelRatio * 0.62;
        canvasElement.height = cast oldHeight * pixelRatio  * 0.62;
        canvasElement.style.width = oldWidth  * 0.62 + 'px';
        canvasElement.style.height = oldHeight  * 0.62 + 'px';
        // now scale the context to counter
        // the fact that we've manually scaled
        // our canvas element
        canvasContext.scale(pixelRatio, pixelRatio);
        PIXELRATIO = pixelRatio;
        this.canvas = canvasElement;
        this.context = canvasContext;

        //fix div height for HTML
        Browser.document.getElementById("left").style.height = oldHeight  * 0.62 + 'px';
        Browser.document.getElementById("right").style.height = oldHeight  * 0.62 + 'px';
    }

    function pushToMap(){
        updateCircuitDiagramMap.set(circuitDiagram, updateCircuitDiagram);
        updateToolBarMap.set(circuitDiagram, updateToolBar);
        updateCanvasMap.set(circuitDiagram, updateCanvas);
        sideBarMap.set(circuitDiagram, sideBar);
        controllerCanvasContextMap.set(circuitDiagram, controllerCanvasContext);
        canvasMap.set(circuitDiagram, canvas);
        contextMap.set(circuitDiagram, context);
    }

    function setButtonDisability(button:DOMElement,disable:Bool){
        if(disable){
            button.setAttribute("disabled", "disabled");
        }else{
            new JQuery(button).removeAttr("disabled");
        }
    }

    function newCollapse(pathArray:Array<String>){
        var path:String="";
        for(t in pathArray){
            path=path+t+"/";
        }
        path=path.substring(0,path.length-1);
        var url = Browser.window.location.href.split("?");
        var username:String = (url[1].split("="))[1];
        //trace(pathArray);
        JQuery.ajax( { type:"post",
            url: "http://127.0.0.1:3000/app/users/showfolder?username="+username+"&folder="+path,
            contentType: "application/json",
            dataType:"text",
            }
        )
        .done( function (text) {
            if(text=="fail"){}
            else{
                var list:Array<{_id:String,fileName:String,id:String,fileType:String}>=haxe.Json.parse(text);
                if(list.length!=0){
                    for(i in list){
                        var tempArray:Array<String>=new Array<String>();
                        for(k in pathArray){
                            tempArray.push(k);
                        }
                        var tempString:String="";
                        for(i in tempArray){
                            tempString=tempString+i;
                        }
                        //trace("Fieldpath_"+tempString);
                        new JQuery('#Fieldpath_'+tempString).append("<a data-toggle=\"collapse\" href=\"#FileCollapseList"+Std.string(fileListCount)+"\" id=\"path_"+tempString+i.fileName+"\">"+i.fileName+"</a>");
                        new JQuery('#Fieldpath_'+tempString).append("<div id=\"FileCollapseList"+Std.string(fileListCount)+"\" class=\"panel-collapse collapse out\" >
                            <div class=\"container-fluid\" id=\"Fieldpath_"+tempString+i.fileName+"\">

                            </div>
                        </div>
                    </div><br>");
                        fileListCount++;
                        tempArray.push(i.fileName);
                        if(i.fileType=="Folder"){
                            new JQuery('#path_'+tempString+i.fileName).html("<img src=\"/client/src/icon/folder.png\">"+i.fileName);
                            Browser.document.getElementById("path_"+tempString+i.fileName).onclick=function(){
                                new JQuery('#downloadFile').hide();
                                new JQuery('#versionList').hide();
                                new JQuery('#FolderNameLabel').show();
                                new JQuery('#createFolder').show();
                                new JQuery('#uploadCircuit').show();
                                new JQuery('#deleteFile').show();
                                new JQuery('#Fieldpath_'+tempString+i.fileName).html("");
                                Browser.document.getElementById("createFolder").onclick= function(){
                                    if(Browser.document.getElementById("FolderNameLabel").itemValue!=""){
                                        createFolder(username,path+"/"+i.fileName+"/"+Std.string(new JQuery('#newFolderName').val()));
                                    }
                                    else{

                                    }
                                };
                                new JQuery('#selectCircuit').html("");
                                for(i in circuitDiagramArray){
                                    new JQuery('#selectCircuit').append("<option>"+i.get_name()+"</option>");
                                }
                                Browser.document.getElementById("uploadCD").onclick= function(){
                                    uploadCircuit(Std.string(new JQuery('#selectCircuit').val()),path+"/"+i.fileName,username);
                                };
                                Browser.document.getElementById("deleteFile").onclick = function(){
                                    delete(i.id);
                                    Browser.document.getElementById("path_"+tempString).click();
                                };
                                newCollapse(tempArray);
                            };
                        }
                        else if(i.fileType=="Circuit"){
                            new JQuery('#path_'+tempString+i.fileName).html("<img src=\"/client/src/icon/circuit.png\">"+i.fileName);
                            Browser.document.getElementById("path_"+tempString+i.fileName).onclick=function(){
                                new JQuery('#Fieldpath_'+tempString+i.fileName).html("");
                                new JQuery('#FolderNameLabel').hide();
                                new JQuery('#createFolder').hide();
                                new JQuery('#uploadCircuit').hide();
                                selectVersion(i.id);
                                Browser.document.getElementById("deleteFile").onclick = function(){
                                    delete(i.id);
                                    Browser.document.getElementById("path_"+tempString).click();
                                };

                            };
                        }

                    }
                }
            }

        });
    }


    function currentnewCollapse(pathArray:Array<String>,CurrentfileListCount:Int){
        var path:String="";
        for(t in pathArray){
            path=path+t+"/";
        }
        path=path.substring(0,path.length-1);
        var url = Browser.window.location.href.split("?");
        var username:String = (url[1].split("="))[1];
        //trace(pathArray);
        JQuery.ajax( { type:"post",
            url: "http://127.0.0.1:3000/app/users/showfolder?username="+username+"&folder="+path,
            contentType: "application/json",
            dataType:"text",
        }
        )
        .done( function (text) {
            if(text=="fail"){}
            else{
                var list:Array<{_id:String,fileName:String,id:String,fileType:String}>=haxe.Json.parse(text);
                if(list.length!=0){
                    for(i in list){
                        var tempArray:Array<String>=new Array<String>();
                        for(k in pathArray){
                            tempArray.push(k);
                        }
                        var tempString:String="";
                        for(i in tempArray){
                            tempString=tempString+i;
                        }
                        //trace("Fieldpath_"+tempString);
                        if(i.fileType=="Folder"){
                            new JQuery('#CurrentFieldpath_'+tempString).append("<a data-toggle=\"collapse\" href=\"#CurrentFileCollapseList"+Std.string(CurrentfileListCount)+"\" id=\"Currentpath_"+tempString+i.fileName+"\">"+i.fileName+"</a>");
                            new JQuery('#CurrentFieldpath_'+tempString).append("<div id=\"CurrentFileCollapseList"+Std.string(CurrentfileListCount)+"\" class=\"panel-collapse collapse out\" >
                            <div class=\"container-fluid\" id=\"CurrentFieldpath_"+tempString+i.fileName+"\">

                            </div>
                        </div>
                    </div><br>");
                            CurrentfileListCount++;
                            tempArray.push(i.fileName);
                            new JQuery('#Currentpath_'+tempString+i.fileName).html("<img src=\"/client/src/icon/folder.png\">"+i.fileName);
                            Browser.document.getElementById("Currentpath_"+tempString+i.fileName).onclick=function(){
                                new JQuery('#CurrentFieldpath_'+tempString+i.fileName).html("");
                                currentnewCollapse(tempArray,CurrentfileListCount);
                            };
                        }
                    }
                }
            }

        });
    }


    function createFolder(username:String,path:String){
        trace(path);
        JQuery.ajax( { type:"post",
            url: "http://127.0.0.1:3000/app/users/folder?username="+username+"&new=true&folder="+path,
            contentType: "application/json",
            dataType:"text"}
        )
        .done( function (text) {

        });
    }

    function selectVersion(id:String){
        JQuery.ajax( { type:"post",
            url: "http://127.0.0.1:3000/app/users/showversion?id="+id,
            contentType: "application/json",
            dataType:"text",
        }
        )
        .done( function (text){
            if(text=="fail"){

            }
            else{
                new JQuery('#selectList').html("");
                var count:Int = Std.parseInt(text);
                var i:Int = 0;
                while(i<count){
                    new JQuery('#selectList').append("<option>"+Std.string(i)+"</option>");
                    i++;
                }
                new JQuery('#downloadFile').show();
                Browser.document.getElementById("downloadFile").onclick = function(){
                    downloadCircuit(id,Std.string(new JQuery('#selectList').val()));
                };
                new JQuery('#versionList').show();
            }
        });
    }

    function downloadCircuit(id:String,version:String){
        JQuery.ajax( { type:"post",
            url: "http://127.0.0.1:3000/app/users/download?id="+id+"&version="+version,
            contentType: "application/json",
            dataType:"text",
        }
        )
        .done( function (text){
            var cd:CircuitDiagramI = Unserializer.run(text);
            var flag:Bool=true;
            for(i in circuitDiagramArray){
                if(i.get_name()==cd.get_name()){
                    flag=false;
                }
            }
            if(flag==true){
                downloadSubCircuit(cd);
                load(cd);
            }
            else{
                trace("exited on canvas");
            }
        });
    }

    function downloadSubCircuit(cd:CircuitDiagramI){
        for(i in cd.get_componentIterator()){
            if(i.getNameOfTheComponentKind()=="CC"){
                trace(i.get_id());
                if(i.get_id()!=""){
                    JQuery.ajax( { type:"post",
                        url: "http://127.0.0.1:3000/app/users/downloadSub?id="+i.get_id(),
                        contentType: "application/json",
                        dataType:"text",
                    }
                    )
                    .done( function (text){
                        if(text!="fail"){
                            var tempcd:CircuitDiagramI = Unserializer.run(text);
                            downloadSubCircuit(tempcd);
                            cast(i.get_componentKind(),CompoundComponent).loadCircuit(tempcd);
                        }
                        else{
                            cd.get_componentArray().remove(i);
                        }
                    });
                }
                else{
                    cd.get_componentArray().remove(i);
                }
            }
        }
    }

    function uploadCircuit(name:String,path:String,username:String){
        for(i in circuitDiagramArray){
            if(i.get_name()==name){
                Serializer.USE_CACHE=true;
                Serializer.USE_ENUM_INDEX=true;
                var exp= ~/\s+/;
                var check=~/^\w*$/;
                var cdname=exp.replace(i.get_name(),"_");
                if(check.match(cdname)){
                    uploadSubCircuit(i,path,username,function(){});
                    for(k in i.get_componentIterator()){
                        if(k.getNameOfTheComponentKind()=="CC"){
                            trace(k.get_id());
                        }
                    }
                    var o = Serializer.run(i);
                    var tempJson = {circuit: o};
                    JQuery.ajax( { type:"post",
                        url: "http://127.0.0.1:3000/app/users/folder?username="+username+"&new=false&folder="+path+"&fileName="+cdname,
                        contentType: "application/json",
                        data:haxe.Json.stringify(tempJson)}
                    )
                    .done( function (text) {
                        trace(text);

                    });
                }
            }
        }
    }


    @async function uploadSubCircuit(cd:CircuitDiagramI,path:String,username:String){
        for(i in cd.get_componentIterator()){
            if(i.getNameOfTheComponentKind()=="CC"){
                if(i.get_id()==""){
                    uploadSubCircuit(i.get_componentKind().getInnerCircuitDiagram(),path,username,function(){});
                    Serializer.USE_CACHE=true;
                    Serializer.USE_ENUM_INDEX=true;
                    var o = Serializer.run(i.get_componentKind().getInnerCircuitDiagram());
                    var tempJson = {circuit: o};
                    var exp= ~/\s+/;
                    var check=~/^\w*$/;
                    var cdname=exp.replace(i.get_componentKind().getInnerCircuitDiagram().get_name(),"_");
                    cdname=cdname+"_SubCircuitOf_"+exp.replace(cd.get_name(),"_");
                    if(check.match(cdname)){
                        JQuery.ajax( { type:"post",
                            url: "http://127.0.0.1:3000/app/users/folder?username="+username+"&new=false&folder="+path+"&fileName="+cdname,
                            contentType: "application/json",
                            data:haxe.Json.stringify(tempJson)}
                        )
                        .done( function (text) {
                            trace(text);
                            if(text!="fail"){
                                i.set_id(text);
                            }
                        });
                    }
                }

            }
        }
    }

    function delete(id:String){
        JQuery.ajax( { type:"post",
            url: "http://127.0.0.1:3000/app/users/delete?id="+id,
            contentType: "application/json",
            }
        )
        .done( function (text) {
            trace(text);
        });
    }

}
