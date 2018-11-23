
% clear all
% 
% load N
% 
% 
% 
% imshow(N)




function [cA,cH,cV,cD] =  haar_wavelet(N);

%[C,S] = wavedec2(N,1,'haar');

[m,n] = size(N);

% keyboard()
% 
 N = double(N);
% 
% 
 LP = [.7071 .7071];  HP = [-.7071 .7071];


%[C1,S] = wavedec2(N,1,LP,HP);

% 
 N1 = N';
% 
 Nrows =N1(:)';

 
 LP1N = convo(LP,Nrows);
% 
 HP1N = convo(HP,Nrows);
 

% 
 temp = 0;
% 
 for i = 1:2:length(Nrows)
%     
     temp = temp +1;
%     
     LP1N1(temp) =  LP1N(i);
%     
    HP1N1(temp) =  HP1N(i);
%     
 end
% 
% 
 %LP1N1 = LP1N1';
 %HP1N1 = HP1N1';
% 
  Lprow =  reshape(LP1N1,round(m/2),n);
%  
  Hprow =  reshape(HP1N1,round(m/2),n);
% 
%imshow(Lprow)
% 
% %LPLP = 
% %keyboard()
 Lprow = Lprow(:);
 Hprow = Hprow(:);
% 
% 
% 
% 
LLP1N = convo(LP,Lprow);

HHP1N = convo(HP,Hprow);
% 
% 
LHP1N = convo(HP,Lprow);

HLP1N = convo(LP,Hprow);
% 
% 
% 
temp = 0;

for i = 1:2:length(Lprow)
    
    temp = temp +1;
    
    LLP(temp) =  LLP1N(i);
    
    LHP(temp) =  LHP1N(i);
    
    HLP(temp) =  HLP1N(i);
    
    HHP(temp) =  HHP1N(i);
    
end
%keyboard()

cA = reshape(LLP,round(m/2),round(n/2));
cH = reshape(LHP,round(m/2),round(n/2));
cV = reshape(HLP,round(m/2),round(n/2));
cD = reshape(HHP,round(m/2),round(n/2));
% 






