% cosvec = [-1,-1,-1,-1,-1,-1,-1, -1];
% sinvec = [1,1,1,1,1,1,1,1];

newvect = zeros(1,2*length(cosvec));
newvect(1:2:end-1) = cosvec;
newvect(2:2:end) = sinvec;

newvect(newvect == -1) = 0;

D = [];

for i = 1:length(newvect)
   if mod(i,8) ~= 0
       D = [D, newvect(i)] 
   end
end

A = char(D + '0');

words=char(bin2dec(reshape(A,7,[]).'));