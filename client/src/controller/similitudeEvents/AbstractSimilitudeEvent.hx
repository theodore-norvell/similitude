package controller.similitudeEvents;

/**
 * This class is not to be instantiated.
 * It consists of the event framework that will be inherited as common by other events
 * @author AdvaitTrivedi
 */
class AbstractSimilitudeEvent
{
	public var eventType( default, null): EventTypesEnum;

	public function new( eventType: EventTypesEnum ) {
		this.eventType = eventType ;
	}
}