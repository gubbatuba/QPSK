%% RUN THIS ONCE TO INITIALIZE THE RECEIVER
% address = '30CF996';
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',8192,'DecimationFactor',256,'MasterClockRate',1.5*32000000)

%% OTHER VARIATIONS OF rx THAT WE TRIED
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181)
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',1024)
% rx = comm.SDRuReceiver('Platform','B210','SerialNum',address,'Gain',20,'CenterFrequency',2.5e9,'SamplesPerFrame',181,'EnableBurstMode',true,'NumFramesInBurst',8192,'DecimationFactor',128,'MasterClockRate',2*32000000)

%% RUN THIS TO RECEIVE
% burst = 2*8192;
% Y = zeros(burst*181,1);
% Y_count=1;
% 
% for i = 1:burst
%      tmp = step(rx);
%      Y(Y_count:Y_count+length(tmp)-1) = tmp;
%      Y_count = Y_count+length(tmp);
% end
% 
% plot(real(Y));

%% ALTERNATIVE METHOD FOR RECEIVING
% IN THE COMMAND LINE
% C:\Program Files\UHD\lib\uhd\examples>rx_samples_to_file --freq 2.5e9 --rate 187500 --file C:\Users\jwei\Documents\Olin\Spring-2017\ADC\FINAL\QPSK\test\rx_data.dat --type float
% IN MATLAB
!rx 
f1 = fopen('rx_data.dat', 'r');
y_data = fread(f1, 'float32');
fclose(f1);
y_data = y_data(1:2:end)+j*y_data(2:2:end);