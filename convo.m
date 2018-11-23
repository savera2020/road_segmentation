function out1 = convo(coe,in1)


for i =1:length(in1)-1
    
    out1(i) = in1(i)*coe(1) + in1(i+1)*coe(2);
    
end

out1(length(in1)) = in1(end);