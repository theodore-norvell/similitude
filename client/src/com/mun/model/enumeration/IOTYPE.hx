package com.mun.model.enumeration;

/**
 * Distinguish the input and output type for the gates
 * such as AND gate havs input and output
 * flip-flop have R S Q QN
 * @author wanhui
 *
 */
enum IOTYPE {
    //below are inputs
    INPUT;//COMMON INPUT
    S;// MUX
    D;//FLIP-FLOP
    CLK; //CLOCK FOR FLIP-FLOP

    //below are outputs
    OUTPUT;//COMMON OUTPUT
    Q;//FLIP-FLOP
    QN;//QN MEANS Q NOT
}