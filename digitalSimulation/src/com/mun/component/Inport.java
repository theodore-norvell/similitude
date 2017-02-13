package com.mun.component;

import com.mun.emun.ValueLogic;

public class Inport extends Port {

	@Override
	void setValue(ValueLogic value) {
		this.value = value;
	}

}
