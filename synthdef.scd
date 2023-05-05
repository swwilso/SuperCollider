s.boot;
s.meter;

(
SynthDef.new(\ocean, {
	arg freq=100, gate=1;
	var sig, env;
	env = EnvGen.kr(
		Env.asr(3, 1, 3, [1, -1]),
		gate,
		doneAction:2
	);
	sig = Pulse.ar(freq * [1, 1.01], 0.5, 0.04);
	sig = SinOsc.ar(freq * 1.5 * [1, 1.004], 0 , 0.15);
	sig = sig + BrownNoise.ar(0.04!2);
	sig = sig * Line.ar(0, 1, 10);
	sig = sig!2;
	Out.ar(0, sig);
}).add;
)

x = Synth.new(\ocean);
x.set(\gate, 0);
x.free;