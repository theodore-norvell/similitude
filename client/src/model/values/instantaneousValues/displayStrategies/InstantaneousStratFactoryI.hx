package model.values.instantaneousValues.displayStrategies;

/**
 * @author AdvaitTrivedi
 */
interface InstantaneousStratFactoryI 
{
	public function getHighStrat() : InstantaneousDrawStrategyI;
	public function getLowStrat() : InstantaneousDrawStrategyI;
	public function getTriStateStrat() : InstantaneousDrawStrategyI;
	public function getDontCareStrat() : InstantaneousDrawStrategyI;
	public function getErrorStrat() : InstantaneousDrawStrategyI;
}