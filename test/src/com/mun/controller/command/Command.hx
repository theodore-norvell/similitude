package com.mun.controller.command;
/**
* interface for command, use command pattern to process some operations
* @author wanhui
**/
interface Command {
    /**
    * undo command
    **/
    public function undo():Void;

    /**
    * redo command
    **/
    public function redo():Void;

    /**
    * execute command
    **/
    public function execute():Void;
}
