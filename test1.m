n = 7;             % Codeword length
k = 4;             % Message length
dmin = 3;           % Minimum distance
EbNo = 1:10;        % Eb/No range (dB)

berBlk = bercoding(EbNo,'block','hard',n,k,dmin);

berfit(EbNo,berBlk)
ylabel('Bit Error Probability')
title('BER Upper Bound vs. Eb/No, with Best Curve Fit')