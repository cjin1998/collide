(
// Server configurations
s.options.sampleRate_(44100); // Set your piece's sample rate
s.options.memSize_(8192); // Default is 8192 but may need to set higher if you use more UGens or delay lines
s.options.numInputBusChannels_(2); // Based on the hardware device you choose
s.options.numOutputBusChannels_(2); // Based on the hardware device you choose

// Global variables
~parentPath = thisProcess.nowExecutingPath.dirname;
~soundsPath = ~parentPath ++ "/sounds/";
~patternsPath = ~parentPath ++"/203patterns.scd";
~scorePath = ~parentPath ++ "/203score.scd";
~synthDefsPath = ~parentPath ++ "/203synthDefs.scd";

~out = 0;

~tempo = 120;
~tempoClock = TempoClock.new(~tempo/60);

Pdef.removeAll;

//helper function to load sounds into sound dictionary
~loadSoundsFolder = {
	|soundPath|

	var createBuffers = {
		arg pathName, soundsDictionary;
		if (pathName.isFile, {
			pathName.postln;
			soundsDictionary.put(pathName.fileName, Buffer.read(s, pathName.fullPath));
		});
		if (pathName.isFolder, {
			var entries = pathName.entries, index = 0;
			while({index < entries.size}, {
				createBuffers.value(entries[index], soundsDictionary);
				index = index + 1;
			});
		});
	};
	var soundsFolderPath = PathName.new(soundPath);
	var soundsDictionary = Dictionary[];
	createBuffers.value(soundsFolderPath, soundsDictionary);
	soundsDictionary; // return the sounds Dictionary
};


// Play the piece
s.waitForBoot({
	"\nServer has now booted".postln;

	~soundsDictionary = ~loadSoundsFolder.value(~soundsPath);

	"Sounds loaded".postln;

	"...loading Synth Definitions...".postln;
	~synthDefsPath.load;
	"SynthDefs defined".postln;

	s.sync;


	 ~effects = {
		~reverbBus = Bus.audio(s, 2);
		~reverb = Synth(\reverb, [\in, ~reverbBus]);
		~flangBus = Bus.audio(s, 1);
        ~flang = Synth(\flanger, [\in, ~flangBus]);
	};

	~effects.value;

	s.sync;

	~patternsPath.load;

	"Patterns instantiated".postln;

	~scorePath.load; // Load score

	"Begin piece".postln;

	~tempoClock.beats_(-1); // Start the piece with a beat silence to begin
	~printTime.value(~tempoClock);
	~score.value;
});
)

