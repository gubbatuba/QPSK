%% 
%The purpose of this script is to take the signal take find the optimal 
%adjusting factor, and adjust the received signal to account for the offset

%% Extract data component
ii = find(abs(double(Y))>1e3); %eyeballed off of plot of real(Y)
y_trim = Y(min(ii-100):max(ii));
y_trim = y_trim(1:floor(length(y_trim))/2);
% figure;
% plot(y);

%% Squared to take away +/- effect
%y_squared = y.^(2);
y_quart = y_trim.^(4);
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
n = length(y_trim);
% fshift = (-n/2:n/2-1)*(fs/n);
fshift = linspace(-pi,pi*((n-1)/n),n);
powershift = abs(y_shift);
plot(fshift,powershift);
[peak1,peak1_ind] = max(powershift);
peak1_freq = fshift(peak1_ind);

%% SIDDHARTAN'S VERSION MODIFIED
max_factor = 500;
search_width = 2;
rmss = zeros(1,max_factor);
vars = zeros(1,max_factor);
counter = 1;

f_diff = fshift(search_width)-fshift(1); % this is the spacing between successive bins in the FFT 
f_adjustments = linspace(-f_diff, f_diff, max_factor); % these are the adjustments to check 
t = [0:n-1];

for k = 1:length(f_adjustments)
    adjust = exp((peak1_freq+f_adjustments(k))*t*1i/4)';
    y_adjust = y_trim.*adjust/(nthroot(peak1,4));
    plot(real(y_adjust));
%   keyboard
    rmss(counter) = rms(abs(real(y_adjust)));
    vars(counter) = var(abs(real(y_adjust)));
    counter = counter + 1;
end

[min_var, min_var_index] = min(vars)

optimal_adjuster = f_adjustments(min_var_index);
subplot(2,1,1);
plot(f_adjustments,rmss);
title('RMS');
subplot(2,1,2);
plot(f_adjustments,vars);
title('Variances');


figure
    adjust = exp((peak1_freq+optimal_adjuster)*t*1i/4)';
    y_adjust = y_trim.*adjust/(nthroot(peak1,4));
    plot(real(y_adjust)); % this is half, and the other half can be viewed using imag(y_adjust)

xlabel('Adjustment Factors');