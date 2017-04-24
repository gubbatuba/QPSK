% address = '30CF996';
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181)
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',1024)
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',8192,'DecimationFactor',128,'MasterClockRate',2*32000000)
% tmp = step(rx);

%% OLD CODE
burst = 8192;
Y = zeros(burst*181,1);
Y_count=1;

% rxLog = dsp.SignalSink;
for i = 1:burst
%    data= step(rx);
%    rxLog(data);
     tmp = step(rx);
     Y(Y_count:Y_count+length(tmp)-1) = tmp;
     Y_count = Y_count+length(tmp);
end

plot(real(Y));