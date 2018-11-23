% data1= load('data');
% 
% data = data1.data;

function data1 = randmize_data(data)

[m,n] = size(data);
data1 = zeros(m,n);
%index = [];

l=length(data(:,1));

%index = floor(l*rand(l,1));   % randomize data1 and save it as data.

for i = 1:l
    
  index = randi(l);  
  
  data1(i,:) = data(index,:);
end



%data1 = data(index,:);

end