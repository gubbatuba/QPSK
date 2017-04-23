wordstring = 'beees words words words words words';
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

    address='30C628D';
%       tx = comm.SDRuTransmitter('Platform','B210','SerialNum',address,'Gain', 200,'CenterFrequency',2.5e9)
    p = ones(100,1);
    [r,c] = size(totalresult);
    
    for i = 1:20
        for col = 1:c
            data = 0.5*(totalresult(:,c));
            tmp = repmat(data,100,1); % lengthens matrix
            tmp = upsample(tmp,100); % to prevent switching too fast
            x = conv(tmp,p); % to make an actual square wave
                step(tx,x);
        end
    end


