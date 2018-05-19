function [ tau ] = tau_m( u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
     
    w = u(1:3,1:6);
    q = u(4:7,1:6);
    tau = zeros(3,6);
    for i=1:6
        tau(1:3,i) = -kG*veq(crossq(conjq(qr),q(:,i)))-DG*w(:,i);
        for j = 1:6
            tau(1:3,i) = tau(1:3,i)-(a*veq(crossq(conjq(q(:,j)),q(:,i)))+b*(w(:,i)-w(:,j)));
            
        end
        
    end

end

