% address = '30CF996';
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181)
% rx_burst = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',1024)
Y = zeros(72401,1);
Y_count=1;
for i = 1:200
    tmp = step(rx);
    Y(Y_count:Y_count+length(tmp)-1) = tmp;
    Y_count = Y_count+length(tmp);
end

plot(real(Y));