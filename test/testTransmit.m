% address='30C628D';
% tx = comm.SDRuTransmitter('Platform','B210','SerialNum',address,'Gain', 200,'CenterFrequency',2.5e9)
% tx = comm.SDRuTransmitter('Platform','B210','SerialNum',address,'Gain', 200,'CenterFrequency',2.5e9,'InterpolationFactor',128,'MasterClockRate',2*32000000);

dat = sign(randn(1e3,1));
dat_us = upsample(dat, 100);
p = 0.5*ones(100,1);
tmp = conv(dat_us, p);
x = zeros(1e3+length(tmp),1);
x(1e3+1:end)  = tmp;
step(tx,x);
