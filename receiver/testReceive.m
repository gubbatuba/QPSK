%% Extract the real component
ii = find(abs(double(Y))>.5e4);
y_trim = Y(min(ii):min(ii)+1.01e4);
y = y_trim;
% figure;
% plot(y);

%% Squared to take away +/- effect
y_squared = y.^(2);
% figure;
% plot(y_squared);

%% Take the FFT of the squared
fft_res = fft(y_squared);
figure;
% Take abs because it's complex
plot(abs(fft_res));

y_shift = fftshift(fft_res);
fs = 1;
n = length(y);
% fshift = (-n/2:n/2-1)*(fs/n);
fshift = linspace(-pi,pi*((n-1)/n),n);
powershift = abs(y_shift);
plot(fshift,powershift);
[peak1,peak1_ind] = max(powershift);
peak1_freq = fshift(peak1_ind);
peak_adjusted =(fshift(2) - fshift(1))/3.5;
t = [0:n-1];
adjust = exp((peak1_freq+peak_adjusted)*t*j/2)';
y_adjust = y.*adjust/(sqrt(peak1));
plot(real(y_adjust));


% %% Find the peak (location of spike = 2*frequency offset)
% peak1 = max(abs(fft_res));
% peak1_offset = find(abs(fft_res)==peak1);
% half_offset = 0.5*peak1_offset;
% 
% %% Extract original signal
% sampling_f = 0;
% y_original = y .* exp(2j*pi*half_offset/sampling_f*(0:length(y)-1));
    
