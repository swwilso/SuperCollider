s.boot;

(
SynthDef.new(\ocean, {
	arg freq=100, atk=0.01, rel=1, pan=0;
	var sig, env;
	env = EnvGen.kr(
		Env.new(
			[0,1,0],
			[atk,rel],
			[0,-4]
		),
		doneAction:2
	);
	sig = Pulse.ar(freq * [1, 1.01], 0.5, 0.04);
	sig = SinOsc.ar(freq * 1.5 * [1, 1.004], 0 , 0.15);
	// sig = sig + BrownNoise.ar(0.04!2);
	sig = sig * Line.ar(0, 1, 10);
	// sig = sig * env;
	sig = Pan2.ar(sig, pan);
	Out.ar(0, sig);
}).add;
)

(
r = Routine.new({
	var note = rrand(48, 72);
	var pan = rrand(-0.5, 0.5);
	{
	Synth(\ocean, [\freq, note.midicps, \pan, rrand(-0.5, 0.5)]);
	wait(exprand(0.02, 0.5));
	}.loop;
});
)

r.reset; r.play;
r.stop;

s.meter;
