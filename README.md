# QPSK
QPSK with USRP

<h2>Intro</h2>
This repo is for our Spring 2017 Introduction to Analog and Digital Communications final project, where we want to use USRP boxes to 
transmit data wirelessly using QPSK.

<h2>How It Works</h2>
This is not a fully-functional implementation of QPSK. The transmitting side of things should work using the __TransmitQPSKEncoding.m__ script in Matlab, and the receiving end works to some degree but does not ultimately decode the original signal.

To run the receiving end of things, open up the __testReceive.m__ file in the _test_ folder. From there, initiate the address and setup the reeiver by uncommenting lines 1 and 5 and running the script to start listening/receiving. Should you want to try receiving again, re-comment lines 1 and 5 as those only have to be setup once per session.

Once you have the raw received signal, run __testReceive_adjustableFactor.m__ to get the adjusted received signal that accounts for the frequency offset. 

To extract the bits, run __extractBits.m__

There is a lot of hardcoding involved, so tweaks may be necessary to get this working for you.
