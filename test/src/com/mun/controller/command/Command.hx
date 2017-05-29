package com.mun.controller.command;
/**
* interface for command, use command pattern to process some operations
* @author wanhui
**/
import com.mun.type.Type.Object;
interface Command {
    /**
    * undo command
    **/
    public function undo():Object;

    /**
    * redo command
    **/
    public function redo():Object;

    /**
    * execute command
    **/
    public function execute():Void;
}
