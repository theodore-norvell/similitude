package com.mun.controller.command;
/**
* interface for command, use command pattern to process some operations
* @author wanhui
**/
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
interface Command {
    /**
    * undo command
    **/
    public function undo():LinkAndComponentAndEndpointAndPortArray;

    /**
    * redo command
    **/
    public function redo():LinkAndComponentAndEndpointAndPortArray;

    /**
    * execute command
    **/
    public function execute():Void;
}
