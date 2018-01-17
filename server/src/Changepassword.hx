package ;

import js.jquery.JqEltsIterator;
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
        var username:String = new JQuery('#username').val();
        var oldpass:String = new JQuery('#old_pass').val();
        var newpass:String = new JQuery('#new_password').val();
        var confirm:String = new JQuery('#confirm_password').val();
        if(newpass != confirm && newpass !='' && confirm != ''){
            new JQuery('#confirm_passwordtag').html("*Confirm Password <br>
            <font color="+"red"+">password don't match</font>");
        }
        else{
        if(oldpass != '' && newpass !='' && confirm != ''){
            //var u:User = new User(username,null,null) ;
            var s = {
                oldp: oldpass,
                newp: newpass
            };
            var o = TJSON.encode(s);
            JQuery.ajax( { type:"post",
                url: "http://127.0.0.1:3000/changepassword/users?username="+username,
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
                    new JQuery('#oldpasstag').html("Wrong password");
                    //new JQuery('#nametag').text("*Username   username already existed");
                }
            })
            .fail( function( jqXHR, testStatus, errorThrown ) {} ) ;
        }
        }
    }

    static public function main()

    {
        var main = new Changepassword();
    }
}
