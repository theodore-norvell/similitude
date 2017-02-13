package com.mun.emun;

/**
 * Distinguish the input and output name for the gates
 * such as AND gate havs input and output
 * flip-flop have R S Q QN
 * @author wanhui
 *
 */
public enum IO {
	INPUT,//COMMON INPUT
	OUTPUT,//COMMON OUTPUT
	D,//FLIP-FLOP
	CLK, //CLOCK FOR FLIP-FLOP
	Q,//FLIP-FLOP
	QN,//QN MEANS Q NOT
	S;// MUX
}
