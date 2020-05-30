package model.similitudeEvents;

/**
 * This class is not to be instantiated.
 * It consists of the event framework that will be inherited as common by other events
 * @author AdvaitTrivedi
 */
class AbstractSimilitudeEvent
{
	var eventTypes: EventTypesEnum;
	
	public function getEventType(): EventTypesEnum {
		return this.eventTypes;
	}
}