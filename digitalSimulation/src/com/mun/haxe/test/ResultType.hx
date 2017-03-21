package com.mun.haxe;

import com.mun.haxe.enumeration.Clock;
import com.mun.haxe.component.Port;

typedef SignalType = {
	var port : Port;
	var clock : Clock;

}

typedef SignalTypeArray = Array<SignalType>;