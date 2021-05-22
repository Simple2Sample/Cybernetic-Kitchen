% Problem set 8, exercise 3
% Alfonso MHC, NTNU, October 07

clear all
load vowels
p=10;

for i=1:length(v)
    coef(:,i)=lpc(v{i},p);
end

% Change vowel i for j
% vowels: a, e, i, o, u, y, ae, oe, aa.
i=1;
j=9;
sound(v{i},fs)
errorsig=filter(coef(:,i),1,v{i});
signal=filter(1,coef(:,j),errorsig);
pause(1)
sound(signal,fs)