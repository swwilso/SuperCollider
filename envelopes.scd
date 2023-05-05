s.boot;

(
f = {
	arg t_gate=1;
	var sig, env;
	env = EnvGen.kr(
		Env.adsr(0.01,0.3,0.5,1),
		t_gate,
		doneAction:2
	);
	sig = Saw.ar(80);
	sig = LPF.ar(sig, 1000);
	sig = sig * 0.2;
	sig = sig * env;
	sig = sig!2;
}
)

x = f.play(args:[\t_gate, 0])
x.set(\t_gate, 1);
s.scope;

s.options.numOutputBusChannels = 8;
s.reboot;
s.meter;