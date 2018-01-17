package ;

import js.Browser;
import js.html.DOMElement;
import js.jquery.JQuery;
import tjson.TJSON;

class Changepassword {

    var b:DOMElement;
    public function new() {
        b= Browser.document.getElementById("login");
        b.addEventListener('click', regist, false);
    }

    public function regist(){
        var oldpass:String = new JQuery('#old_pass').val();
        if(username != ''){
            var u:User = new User(username,null,null) ;
            var o = TJSON.encode(u);
            JQuery.ajax( { type:"post",
                url: "http://127.0.0.1:3000/forgot/users?username="+username,
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
                        Browser.location.assign("http://127.0.0.1:3000/");
                    };
                }
                if(text == "n"){
                    trace("fail");
                    new JQuery('#nametag').html("user don't exist");
                    //new JQuery('#nametag').text("*Username   username already existed");
                }
            })
            .fail( function( jqXHR, testStatus, errorThrown ) {} ) ;
        }
    }

    static public function main()

    {
        var main = new Changepassword();
    }
}
