(

~stringPattern = Pbindef(
	\stringPattern,
	\instrument, \string,
	\midinote, Pseq([
		[67,62,58,51,46],
		[33],
		[67,62,58,51],
		[33],
		[67,62,58,51],
		[33],

		[66, 60, 58, 51, 46],
		[33],
		[66, 60, 58, 51],
		[33],
		[66, 60, 58, 51],
		[33],

		[65, 60, 58, 51, 48, 41],
		[33],
		[65, 60, 58, 51, 48, 41],
		[33],
		[65, 60, 58, 51, 48, 41],
		[33],

		[65, 62, 56, 53, 46, 41],
		[33],
		[65, 62, 56, 53, 46, 41],
		[33],
		[65, 62, 56, 53, 46],
		[33]

	], inf),
	//\freq, 69.midicps,
	\amp, Pseq([0.01, Rest(), 0.01, Rest(), 0.01, Rest()], inf),
	\atk, Pwhite(0.002, 0.005, inf),
	\dec, Pwhite(0.03, 0.06, inf),
	\rel, Pwhite(0.04, 0.06, inf),
	\dur,Pseq.new([0.5, 0.375, 0.25, 0.375, 0.5, 6], inf),
	\pan, -0.3

);

~backgroundPattern = Pbindef(
	\backgroundPattern,
	\instrument, \flute,
	\midinote, Pseq([
		[58,51,46, 41],
		[33],
		[62,58],
		[33],
		[67],
		[33],
		[62],
		[33],
		[58],
		[33],
		[67,62],
		[33],


		[58,51,46, 41],
		[33],
		[58,51],
		[33],
		[66],
		[33],
		[60],
		[33],
		[58],
		[33],
		[66,60],
		[33],


		[58,51,48, 41],
		[33],
		[60,58],
		[33],
		[65],
		[33],
		[60],
		[33],
		[58],
		[33],
		[65,60],
		[33],


		[56,53,46, 41],
		[33],
		[62,56],
		[33],
		[65],
		[33],
		[62],
		[33],
		[56],
		[33],
		[65,62],
		[33],

	], inf),
	\amp, Pseq([0.75, Rest(),0.75, Rest(), 0.75, Rest(), 0.75,Rest(), 0.75, Rest(),0.75, Rest()], inf),
	\atk, Pwhite(0.002, 0.005, inf),
	\dec, Pwhite(0.03, 0.06, inf),
	\rel, Pwhite(0.04, 0.06, inf),
	\dur,Pseq.new([0.5, 0.25, 0.25, 0.5, 0.625, 0.375, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25], inf),
	\pan, -0.3,
	\rout, ~reverbBus
);


~kickPattern = Pbindef(
	\kickPattern,
	\instrument, \kick,
	\amp, Pseq([0.5, 0.5, 0.5, Rest()], inf).trace, // use trace to poll pattern output
	\dur,Pseq.new([1.5,1,1,0.5], inf),
);

~snarePattern = Pbindef(
	\snarePattern,
	\instrument, \snare,
	\amp, Pseq([Rest(),Rest(), 0.5, Rest(),Rest(),Rest(), 0.5, Rest()], inf).trace, // use trace to poll pattern output
	\dur,Pseq.new([0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5], inf),
	\pan, 0.3
);

~guitar1 = Pbindef(
	        \guitar1,
			\instrument, \play,
	        \dur, 224,
			\amp, 0.3,
			\bufnum, ~soundsDictionary["track1.wav"],
	        \out, ~flangBus
		);

~guitar2 = Pbindef(
	        \guitar2,
			\instrument, \play,
	        \dur, 224,
			\amp, 0.5,
			\bufnum, ~soundsDictionary["track2.wav"],
	        \out, ~reverbBus
		);

~bass = Pbindef(
	        \bass,
			\instrument, \play,
	        \dur, 224,
			\amp, 0.95,
			\bufnum, ~soundsDictionary["bass.wav"]

		);

~melody = Pbindef(
	        \melody,
			\instrument, \play,
	        \dur, 224,
			\amp, 0.75,
			\bufnum, ~soundsDictionary["melody.wav"],
		);

)
