%% ALTERNATIVE METHOD FOR RECEIVING
% C:\Program Files\UHD\lib\uhd\examples>rx_samples_to_file --freq 2.5e9 --rate 187
% 500 --file C:\Users\jwei\Documents\Olin\Spring-2017\ADC\FINAL\QPSK\test\rx_data.
% dat --type float
% %  f1 = fopen('rx_data.dat', 'r');
% % y_data = fread(f1, 'float32');
% % fclose(f1);
% % y_data = y_data(1:2:end)+j*y_data(2:2:end);

%% RUN THIS ONCE
% address = '30CF996';
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181)
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',1024)
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',8192,'DecimationFactor',128,'MasterClockRate',2*32000000)
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',8192,'DecimationFactor',256,'MasterClockRate',1.5*32000000)
% tmp = step(rx);

%% RUN THIS TO RECEIVE
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