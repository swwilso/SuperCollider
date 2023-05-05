s.boot;

(
SynthDef(\pad, {
	var sig;
	sig = Saw.ar(\freq.kr(440) * ({ LFNoise2.kr(8) } ! 16 * 0.1).midiratio * [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1]);
	sig = DelayC.ar(sig, 0.01, { Rand(0, 0.01) } ! sig.size);
	sig = Splay.ar(sig);
	sig = LPF.ar(sig, \freq.kr(440) * 4);
	sig = BPeakEQ.ar(sig, \freq.kr(440) * 8, 0.1, 8);
	sig = sig * Env.asr(1, 1, 3).ar(Done.freeSelf, \gate.kr(1));
	sig = sig * \amp.kr(-20.dbamp);
	sig = sig * 0.3;
	sig = sig!2;
	Out.ar(0, sig);
}).add;

SynthDef(\fx, {
	var sig;
	sig = In.ar(0, 2);
	sig = sig + NHHall.ar(sig, 3, modDepth:1);
	sig = sig + GVerb.ar(sig, 00);
	sig = BHiShelf.ar(sig, 3000, 1, -10);
	sig = BPeakEQ.ar(sig, 240, 0.1, -8);
	sig = BPeakEQ.ar(sig, 460, 0.1, -8);
	sig = BPeakEQ.ar(sig, 820, 0.1, -8);
	sig = BLowShelf.ar(sig, 100, 1, 10);
	sig = Limiter.ar(sig);
	sig = sig * 0.3;
	Out.ar(\out.kr(0), sig);
}).add;
)


(
var chord;
chord = [60, 64, 67].collect({
	arg note, index;
	Synth(\pad, [\freq, note.midicps]);
})
)

(
Routine {
	var frequencies;
	frequencies = (40 + [12, 14, 15, 24, 26]).midicps;
	Synth.tail(nil, \fx);
	loop {
		Routine {
			var synth;
			synth = Synth(\pad, [freq: frequencies.choose]);
			rrand(8.0, 16.0).wait;
			synth.set(\gate, 0);
		}.play;
		rrand(3.0, 6.0).wait;
	};
}.play
)


