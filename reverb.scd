s.boot;
s.reboot;

(
SynthDef.new(\drops, {
	arg freqMin=100, freqMax=1000, gate=1,  amp=0.3, out=0;
	var sig, trigEnv, env, freq, trig;

	freq = LFNoise1.kr(0.3!2).exprange(freqMin, freqMax);
	sig = SinOsc.ar(freq);

	trig = Dust.ar(1!2);
	trigEnv = EnvGen.ar(Env.perc(0.002, 0.1), trig);
	sig = sig * trigEnv;

	env = EnvGen.kr(Env.asr(0.01, 1, 1, -1), gate, doneAction:2);
	sig = sig * env * amp;

	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in=0, out=0;
	var sig, reverb;

	sig = In.ar(in, 2);
	reverb = sig.(in,2);

	reverb = GVerb.ar(reverb, 250, 4);
	reverb = LPF.ar(reverb, 900);
	sig = (sig + reverb) * 0.5;

	Out.ar(out, sig);
}).add;
)

~bus = Bus.audio(s, 2);
~srcGroup = Group.new;
~fxGroup = Group.new(~srcGroup, \addAfter);

d = Synth.new(\drops, [\out, ~bus], ~srcGroup);
r = Synth.new(\reverb, [\in, ~bus], \fxGroup);

~srcGroup.set(\gate, 0);

