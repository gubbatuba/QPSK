%% OLD
% tx = comm.SDRuTransmitter('Platform','B210','SerialNum',address,'Gain',
% 200,'CenterFrequency',2.5e9) % default InterpolationFactor = 512
% tx = comm.SDRuTransmitter('Platform','B210','SerialNum',address,'Gain', 200,'CenterFrequency',2.5e9,'EnableBurstMode',true,'NumFramesInBurst',2655,'InterpolationFactor',256,'MasterClockRate',2*32000000);

%% RUN THIS ON START ONCE THEN COMMENT OUT
address='30C628D';
tx = comm.SDRuTransmitter('Platform','B210','SerialNum',address,'Gain', 200,'CenterFrequency',2.5e9,'InterpolationFactor',256,'MasterClockRate',1.5*32000000);

%% RUN THIS TO TRANSMIT
% dat = sign(randn(1e2,1));
% dat_us = upsample(dat, 100);
% p = 0.5*ones(100,1);
% tmp = conv(dat_us, p);
% x = zeros(1e3+length(tmp),1);
% x(1e3+1:end)  = tmp;
% step(tx,x);
