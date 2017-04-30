wordstring = 'beeees';
    doubles = double(wordstring);
    binary = (dec2bin(doubles));
    
    binary = binary -'0';
  
    
    [rowbin,colbin] = size(binary);
    
    I = binary(:,1:2:end); % odds --> cos
    Q = binary(:,2:2:end); % evens --> sin
   
    I( I == 0) = -1;
    Q( Q == 1) = j;
    Q( Q == 0) = -j;
    Q = [Q j*ones(rowbin,1)];
    
    totalmatrix = I + Q;
    totalresult = flipud(rot90(totalmatrix));

    [rowtotal,coltotal] = size(totalresult)
    
    data = reshape(totalmatrix, rowtotal*coltotal,1);
    
    % Add padding so it's easier to find where it starts and know if things are flipped or not (padding with 25 1's and 0's aka 50 total) 
    padding = ones(50,1);
    
    for pad_ind=1:2:50
        padding(pad_ind) = padding(pad_ind)*(1+1i);
    end
    
    for pad_ind=2:2:50
        padding(pad_ind) = padding(pad_ind)*(-1-1i);
    end
 
    data = [padding;data];
    
    %% RUN THIS ONCE
%    address='30C628D';
%    tx = comm.SDRuTransmitter('Platform','B210','SerialNum',address,'Gain', 200,'CenterFrequency',2.5e9,'InterpolationFactor',256,'MasterClockRate',1.25*32000000);

%%
    p = 0.5*ones(100,1);

    data2 = repmat(data,10,1); % lengthens matrix
    dat_us = upsample(data2,100); % to prevent switching too fast    
    tmp = conv(dat_us,p); % to make an actual square wave
    x = zeros(1e3+length(tmp),1);
    x(1e3+1:end)=tmp;
    step(tx,x);
