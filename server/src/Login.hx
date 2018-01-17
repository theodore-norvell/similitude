package ;

import haxe.Json;
import js.html.DOMElement;
import js.Browser;
import js.jquery.JQuery;
import tjson.TJSON;

class Login {
    var b:DOMElement;
    public function new() {
        b= Browser.document.getElementById("login");
        b.addEventListener('click', regist, false);
    }

    public function regist(){
        var username:String = new JQuery("#username").val();
        var password:String = new JQuery("#password").val();
        if(username!=""&&password!=""){
            var u:User = new User(username,password,null) ;
            //new JQuery("#regist_username").hide();
            var s = {
                username: username,
                password: password
            };
            var o = TJSON.encode(u);
            trace(o);
            //var db = new HaxeLow('db.json');
            //var user = db.col(User);
            //user.push(u);
            //db.save();

            JQuery.ajax( { type:"post",
                url: "http://127.0.0.1:3000/",
                contentType: "application/json",
                data:o}
            )
            .done( function( text : String ) {
                if( text == "y" ) {
                    trace( "logged in") ;
                    new JQuery('#alert').css('opacity', 0.5).fadeIn();
                    new JQuery('#alert2').css('opacity', 1).fadeIn();
                    new JQuery('#text1').css('opacity', 1).fadeIn();
                    new JQuery('#text2').css('opacity', 1).fadeIn();
                    var yourTimer:haxe.Timer = new haxe.Timer(5000);
                    yourTimer.run = function():Void{
                        Browser.location.assign("http://127.0.0.1:3000/app/users?username="+username);
                    };
                }
                if(text == "n"){
                    trace("fail");
                    new JQuery('#nametag').html("Incorrect username or password");
                    //new JQuery('#nametag').text("*Username   username already existed");
                }
            })
            .fail( function( jqXHR, testStatus, errorThrown ) {} ) ;


        }
    }

    static public function main()

    {
        var main = new Login();
    }


}
