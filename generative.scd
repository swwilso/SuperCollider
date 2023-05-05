load(thisProcess.nowExecutingPath.dirname +/+ "grid.scd");
~wait = 1/3;
~mode = (0, 12/5..11);
~mode = (0, 12/7..11);
~mode = (0, 12/8..11);
~mode = (0, 12/9..11);
~mode = [0, 1, 3, 5, 7, 8, 10];

~def = \sine;
~def = {[\sine, \line, \perc].wchoose([0.2, 0.7, 0.1])};
~def = {[\sine, \line, \perc][~grid[50].linlin(-1, 1, 0, 2).asInt]};

~stream = Pseq((1.0!100).rand2, 0.1, 0.3).asStream;
