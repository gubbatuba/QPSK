%% Extract the real component
y = double(Y);
% figure;
% plot(y);

%% Squared to take away +/- effect
y_squared = y.^(2);
% figure;
% plot(y_squared);

%% Take the FFT of the real_squared
y_squared_real = real(y_squared);
fft_res = fft(y_squared);
figure;
plot(fft_res);

%% Find the peak (location of spike = 2*frequency offset)
peak1 = max(fft_res);
peak1_offset = find(fft_res==peak1);
half_offset = 0.5*peak1_offset;

%% Extract original signal
sampling_f = 0;
y_original = y .* exp(2j*pi*half_offset/sampling_f*(0:length(y)-1));
    
