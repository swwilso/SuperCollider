// Read audio file (sample)

(
~path = PathName.new(thisProcess.nowExecutingPath).parentPath ++ "audio/";
~sample = Buffer.read(s, ~path ++ "sample.wav");

~sample.plot;
)