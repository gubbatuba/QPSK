%% Extract the real component
ii = find(abs(double(Y))>1e4);
y_trim = Y(min(ii):max(ii));
y = y_trim;
% figure;
% plot(y);

%% Squared to take away +/- effect
%y_squared = y.^(2);
y_quart = y.^(4);
% figure;
% plot(y_squared);

%% Take the FFT of the square/quartic
%fft_res = fft(y_squared);
fft_res = fft(y_quart);
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

%% SIDDHARTAN'S VERSION MODIFIED
max_factor = 100;
search_width = 2;
rmss = zeros(1,max_factor);
vars = zeros(1,max_factor);
counter = 1;

f_diff = fshift(search_width)-fshift(1); % this is the spacing between successive bins in the FFT 
f_adjustments = linspace(-f_diff, f_diff, max_factor); % these are the adjustments to check 
t = [0:n-1];

for k = 1:length(f_adjustments)
    adjust = exp((peak1_freq+f_adjustments(k))*t*1i/4)';
    y_adjust = y.*adjust/(nthroot(peak1,4));
    rmss(counter) = rms(real(y_adjust));
    vars(counter) = var(abs(real(y_adjust)));
    counter = counter + 1;
end

[min_var, min_var_index] = min(vars);

adj_hill = f_adjustments(min_var_index); % no clue why I named it adj_hill

subplot(2,1,1);
plot(f_adjustments,rmss);
title('RMS');
subplot(2,1,2);
plot(f_adjustments,vars);
title('Variances');
xlabel('Adjustment Factors');

%% OUR CODE

% max_factor = 500;
% search_width = 100;
% rmss = zeros(1,max_factor*2);
% vars = zeros(1,max_factor*2);
% counter = 1;

% % y_adjusts = zeros(1,max_factor);
% % y_adjusts{max_factor} = [];
% 
% all_factors = -max_factor:max_factor;
% for adj_factor=all_factors;
%     peak_adjusted = (fshift(search_width) - fshift(1))/adj_factor;
%     t = [0:n-1];
%     adjust = exp((peak1_freq-peak_adjusted)*t*1i/4)';
%     y_adjust = y.*adjust/(nthroot(peak1,4));
%     % y_adjusts{adj_factor} = y_adjust;
%     rmss(counter) = rms(real(y_adjust));
%     vars(counter) = var(abs(real(y_adjust)));
%     counter = counter + 1;
% end

% subplot(2,1,1);
% plot(all_factors,rmss);
% title('RMS');
% subplot(2,1,2);
% plot(all_factors,vars);
% title('Variances');
% xlabel('Adjustment Factors');

% plot(real(y_adjust));

%% OTHER CODE
% %% Find the peak (location of spike = 2*frequency offset)
% peak1 = max(abs(fft_res));
% peak1_offset = find(abs(fft_res)==peak1);
% half_offset = 0.5*peak1_offset;
% 
% %% Extract original signal
% sampling_f = 0;
% y_original = y .* exp(2j*pi*half_offset/sampling_f*(0:length(y)-1));