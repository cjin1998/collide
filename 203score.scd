//score
(
~score = {
	var beats = ~tempoClock.beatsPerBar;

	~tempoClock.schedAbs(0, {

		~kickPattern.play(~tempoClock);
		~snarePattern.play(~tempoClock);

	});

	~tempoClock.schedAbs(1 * beats, {
		~melody.play(~tempoClock);

		~guitar1.play(~tempoClock);
		~guitar2.play(~tempoClock);
		~bass.play(~tempoClock);
	});


	~tempoClock.schedAbs(5 * beats, {
		~backgroundPattern.play(~tempoClock);
	});


	~tempoClock.schedAbs(9 * beats, {

		~stringPattern.play(~tempoClock);
	});


	~tempoClock.schedAbs(17 * beats, {
		~backgroundPattern.stop;
		~stringPattern.stop;
		~kickPattern.stop;
		~snarePattern.stop；
	});

	~tempoClock.schedAbs(25 * beats, {
		~kickPattern.play(~tempoClock);
		~backgroundPattern.play(~tempoClock);
		~snarePattern.play(~tempoClock);
	});

	~tempoClock.schedAbs(49 * beats, {
		~backgroundPattern.stop;
		~kickPattern.stop;
		~snarePattern.stop；
	});


	~tempoClock.schedAbs(57 * beats, {
		~melody.stop;
		~guitar1.stop;
		~bass.stop;
		~guitar2.stop;

	});

};

)

