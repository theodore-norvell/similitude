package model.values.instantaneousValues.displayStrategies;
import model.values.instantaneousValues.displayStrategies.digitalWaveformStrategies.DigitalWaveFactory;

/**
 * Use this class to pass the drawing strategy around when the need arises
 * @author AdvaitTrivedi
 */
class InstantaneousStratFactorySingletons 
{
	public static var DIGITAL_WAVE_FACTORY : DigitalWaveFactory = new DigitalWaveFactory();
	// TODO : Add more wave types as and when there is progress
}