
(SynthDef(\DhString, { arg i_out, freq = 200, gate = 1, pan, amp=0.1;
    var out, eg, fc, osc, a, b, w;
    fc = LinExp.kr(LFNoise1.kr(Rand(0.25, 0.5)), -1, 1, 500, 3000);
    osc = Mix.fill(8, {LFSaw.ar(freq * [Rand(0.98, 1.02), Rand(0.98, 1.02)], 0, amp) }).distort * 0.2;
    eg = EnvGen.kr(Env.asr(1, 1, 1), gate, doneAction: Done.freeSelf);
    out = eg * RLPF.ar(osc, fc, 0.4);
    #a, b = out;
    Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+0.3])));
}).add;)

t = Tuning.wcGamma;
t.ratios;
t.ratios.collect(_.round(0.001));

(Pbind(\scale, Scale.prometheus, //kurd for long, prometheus short
	\degree, Pxrand((0..15), inf),
	\dur, 0.75, // 0.75short, 2long
	\instrument,
	\DhString//(Pxrand(0..15),inf) how2callargs
).play);


