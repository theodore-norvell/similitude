package com.mun.controller.command;
/**
* interface for command, use command pattern to process some operations
* @author wanhui
**/
import com.mun.type.LinkAndComponentArray;
interface Command {
    /**
    * undo command
    **/
    public function undo():LinkAndComponentArray;

    /**
    * redo command
    **/
    public function redo():LinkAndComponentArray;

    /**
    * execute command
    **/
    public function execute():Void;
}
