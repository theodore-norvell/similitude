package controller.controllerState;

/**
 * @author AdvaitTrivedi
 */
enum ControllerStateEnum 
{
	// normal canvas oriented
	CANVAS_IDLE;
	
	// links oriented states
	EDITING_LINK;
	
	// selection oriented states
	ADDING_TO_SELECTION;
	DRAGGING_SELECTION;
}