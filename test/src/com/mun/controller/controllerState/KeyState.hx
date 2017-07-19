package com.mun.controller.controllerState;
import flash.events.KeyboardEvent;
import js.Browser;
import com.mun.model.enumeration.KEY;
import com.mun.model.enumeration.K_STATE;
class KeyState {
    var keyState:K_STATE;
    var key:KEY;

    public function new() {
        keyState = K_STATE.IDLE;

        Browser.document.addEventListener("keydown", keyDown, false);
        Browser.document.addEventListener("keyup", keyUp, false);
    }

    function keyDown(event:KeyboardEvent){
        keyState = K_STATE.KEY_DOWN;
        if(event.altKey){
            key = KEY.ALT_KEY;
        }
    }

    function keyUp(event:KeyboardEvent){
        keyState = K_STATE.KEY_UP;
        if(event.altKey){
            key = KEY.ALT_KEY;
        }
    }

    public function get_keyState():K_STATE {
        return keyState;
    }

    public function get_key():KEY {
        return key;
    }

}
