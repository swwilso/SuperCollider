Link.enable;
Link.setTempo(120, 2);

(
Ndef(\foo, {
	var gate1 = LinkLane.kr(4, 8, [0, 2, 3, 5, 7]);
	var freq1 = 40.midicps;
	var sig1 = PMOsc.ar(freq1, freq1*0.5, 2.0, 0.0, EnvGen.kr(Env.perc(0.0, 0.5, 0.3), gate1)) ! 2;

	var gate2 = LinkTrig.kr(1);
	var freq2 = 80.midicps;
	var env2 = EnvGen.kr(Env.new([0.0, 0.0, 0.3], [0.0, 0.6]), gate2);
	var	sig2 = SinOsc.ar(freq2, 0, EnvGen.kr(Env.perc(0.0, 0.1, 1.0), LinkTrig.kr(8)) * env2);

	var gate3 = LinkTrig.kr(1);
	var freq3 = VarLag.kr(TChoose.kr(gate3, [83, 88, 79, 76]).midicps, 0.2);
	var	sig3 = Mix(PMOsc.ar(freq3, freq3 * [3, 6], [1.0, 4] * LFPulse.kr(1), 0, EnvGen.kr(Env.perc(0.0, 0.3, 0.0), gate1))) ! 2;

	sig1;
	// sig1 + Pan2.ar(sig2, TRand.kr(-1.0, 1.0, gate2)) + (sig3*0.3);
	// Pan2.ar(SinOsc.ar(100, 0, EnvGen.kr(Env.perc(0.0, 0.2, 0.3), gate1)));
}).play;
)