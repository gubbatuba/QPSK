%% Convert to double
y = double(Y_packet(1:floor(length(Y_packet)/4)));


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
t = [0:n-1];
adjust = exp(peak1_freq*t*j/2)';
y_adjust = y.*adjust/(sqrt(peak1));
plot(real(y_adjust));

%% Split into sections/blocks 
blocks = 4; % Divide the FFT into blocks so that we can get more accurate offsets
block_len = round(length(fft_res)/blocks)-1; % -1 just in case it rounds up instead of down

%% Find the peaks for each block (location of spike = 2*frequency offset)
fft_blocks{blocks} = [];

for i=1:(blocks-1)
    fft_blocks{i} = fft_res(((i-1)*block_len)+1:i*block_len);
end
fft_blocks{blocks} = fft_res((blocks-1)*block_len+1:end);

peaks{blocks} = [];
peak_offsets{blocks} = [];
half_offsets = zeros(1,4);

for j=1:blocks
    peaks{j} = max(abs(fft_blocks{j}));
    peak_offsets{j} = find(abs(fft_blocks{j})==peaks{j});  
    half_offsets(j) = 0.5*peak_offsets{j};
end

% 
% peak1 = max(abs(fft_res));
% peak1_offset = find(abs(fft_res)==peak1);
% half_offset = 0.5*peak1_offset;
% 
% %% Extract original signal
% sampling_f = 0;
% y_original = y .* exp(2j*pi*half_offset/sampling_f*(0:length(y)-1));
    
