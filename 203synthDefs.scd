(

~noiseEnvSnare = Env.new([0, 1, 0.4, 0], [0.002, 0.05, 0.13], [-2, -2]);

~freqSweepSnare = Env.new([4000, 200, 180], [0.007, 0.1], [-3, -4]);

~ampEnvSnare = Env.new([0.5, 1, 0.5, 0], [0.005, 0.03, 0.10], [-4, -2, -4]);

SynthDef(\kick, {
    var snd;
    snd = DC.ar(0);
    snd = snd + (HPF.ar(Hasher.ar(Sweep.ar), 1320) * Env.perc(0.003, 0.03).ar * 0.5);
    snd = snd + (SinOsc.ar(XLine.ar(750, 161, 0.02)) * Env.perc(0.0005, 0.02).ar);
    snd = snd + (SinOsc.ar(XLine.ar(167, 52, 0.04)) * Env.perc(0.0005, 0.3).ar(2));
    snd = snd.tanh;
    Out.ar(\out.kr(0), Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1)));
}).add;

	SynthDef(\snare, {
	arg out=0, amp=0.8, pan=0.3;
	var ampEnv, freqSweep, noiseEnv, sine, noise, sig;

	// Envelopes
	ampEnv = EnvGen.kr(~ampEnvSnare);
	freqSweep = EnvGen.kr(~freqSweepSnare);
	noiseEnv = EnvGen.kr(~noiseEnvSnare, doneAction:2); // Noise lasts the longest so it frees synth

	// Snare thud
	sine =  SinOsc.ar(freqSweep, 0.8, ampEnv);

	// Simulates snare rattle
	noise = WhiteNoise.ar(0.2);
	noise = HPF.ar(noise, 200, 2);
	noise = BPF.ar(noise, 6900, 0.6, 3) + noise;
	noise = noise * noiseEnv;

	// Combine rattle and thud and distort slightly by clipping.
	sig = sine + noise;
	sig = sig.clip2(1) * amp;

	sig = Pan2.ar(sig, pan);

	Out.ar(out, sig);
}).add;


SynthDef(\string, {
		arg out = ~out, rout, mix = 0.5, amp = 0.3, freq = 600, pan = 0,
		atk = 2, sus = 1, rel = 2;
		var env, sig;
		env = Env([0, amp, amp, 0], [atk, sus, rel], [4, 0, -4]);
		env = EnvGen.kr(env, doneAction: 2);
		sig = Mix.fill(8, {
			Saw.ar(freq + LFNoise1.kr(Rand(0.05, 0.15), Rand(0, freq * 0.01)));
		});
		sig = Pan2.ar(sig * env, pan);
		Out.ar(out, sig);
		Out.ar(rout, sig * mix);
	}).add;


SynthDef(\reverb, {
	arg in, out = 0, reverbGain = 0.2;
	var input, predelay, earlyRef, lateRef;

	input = In.ar(in, 1);

	predelay = DelayN.ar(input, 0.048);

	earlyRef = Mix.fill(5, {CombL.ar(predelay, 0.15, LFNoise1.kr(0.1.rand, 0.04, 0.05), 3)});

	lateRef = earlyRef;
	8.do({lateRef = AllpassN.ar(lateRef, 0.050, [0.050.rand, 0.050.rand], 0.7)});

	lateRef = LPF.ar(lateRef, 1600);

	Out.ar(out, input + (reverbGain * lateRef));

}).add;


SynthDef(\play, {
	arg out = 0, bufnum, amp = 0.7;
	var sig;
	sig = PlayBuf.ar(2, bufnum, doneAction: 2) * amp;
	Out.ar(out, sig);
}).add;

SynthDef(\flanger, {
	arg in, out = 0, depth = 0.5, rate = 0.25, sweep = 0.0005, centerDelay = 0.01, amp = 1;
	var sig, sigDelayed;
	sig = In.ar(in, 2).poll;
	sigDelayed = DelayL.ar(sig, 0.2, sweep*SinOsc.kr(1/rate, 0, 1)+centerDelay, amp);
	Out.ar(out, (sig + (depth * sigDelayed))*amp);
}).add;


SynthDef(\flute, {
	arg out = 0, midinote=60, gate=1, amp=0.25;
	var env = EnvGen.kr(Env.asr(0.1, 1, 0.1), gate, doneAction:2);
	var sig = VarSaw.ar(
		midinote.midicps,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = sig * env * amp;
	Out.ar(out, sig!2);
}).add;




)