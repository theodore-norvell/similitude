package model.values.instantaneousValues.displayStrategies.digitalWaveformStrategies;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class DigitalWaveFactory implements InstantaneousStratFactoryI
{
	var highStrategy : DigitalWaveformStratI = new HighDigitalWaveStrat();
	var lowStrategy: DigitalWaveformStratI = new LowDigitalWaveStrat();
	var dontCareStrategy: DigitalWaveformStratI = new DontCareDigitalWaveStrat();
	// TODO : Add the remaining strategies, and update their getter functions.
	
	public function new() {}
	
	public function getHighStrat() : InstantaneousDrawStrategyI {
		return highStrategy;
	}
	
	public function getLowStrat() : InstantaneousDrawStrategyI {
		return lowStrategy;
	}
	
	public function getTriStateStrat() : InstantaneousDrawStrategyI {
		return null;
	}
	
	public function getDontCareStrat() : InstantaneousDrawStrategyI {
		return dontCareStrategy;
	}
	
	public function getErrorStrat() : InstantaneousDrawStrategyI {
		return null;
	}
}