%% Adjust signal into real and imaginary
y_adjust_real = real(y_adjust) * -1; % since it's flipped based off the square waves
y_adjust_imag = imag(y_adjust);

%% Extract bits from adjusted signal
bits_real = zeros(1,ceil(length(y_adjust_real)/100));
bits_num = 1;
for bit_sample = 50:100:length(y_adjust_real)
   bits_real(bits_num) = sign(y_adjust_real(bit_sample));
   bits_num = bits_num + 1;
end

bits_imag = zeros(1,ceil(length(y_adjust_imag)/100));
bits_num = 1;
for bit_sample = 50:100:length(y_adjust_imag)
   bits_imag(bits_num) = sign(y_adjust_imag(bit_sample));
   bits_num = bits_num + 1;
end

%% Combine real and imaginary bits
all_bits = zeros(1,(length(bits_imag) + length(bits_real)));
all_bits_counter = 1
for bit = 1:(length(bits_imag))
    all_bits(all_bits_counter) = bits_real(bit);
    all_bits(all_bits_counter+1) = bits_imag(bit);
    all_bits_counter = all_bits_counter + 2;
end

all_bits(all_bits == -1) = 0;


