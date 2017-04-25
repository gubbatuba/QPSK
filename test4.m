y_bits_real = sign(real(y_adjust));
y_bits_imag = sign(imag(y_adjust));
y_bits_real_down = downsample(y_bits_real,100,50);
y_bits_imag_down = downsample(y_bits_imag,100,50);
plot(y_bits_real_down);