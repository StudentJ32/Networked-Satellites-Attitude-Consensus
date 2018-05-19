function [ tau ] = torque( u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    global qr k_G D_G a_ij b_ij
    w = zeros(3,6);
    q = zeros(4,6);
    for i = 1:6
        w(:,i) = u(3*i-2:3*i);
        q(:,i) = u(4*i+15:4*i+18);
    end

%     w_1 = w(:,1);w_2 = w(:,2);w_3 = w(:,3);w_4 = w(:,4);w_5 = w(:,5);w_6 = w(:,6);
%     q_1 = q(:,1);q_2 = q(:,2);q_3 = q(:,3);q_4 = q(:,4);q_5 = q(:,5);q_6 = q(:,6);
    for i=1:6
        tor(1:3,i) = -k_G*veq(crossq(conjq(qr),q(:,i)))-D_G*w(:,i);
        for j = 1:6
            tor(1:3,i) = tau(1:3,i)-(a_ij*veq(crossq(conjq(q(:,j)),q(:,i)))+b_ij*(w(:,i)-w(:,j)));
            
        end
        
    end
    for i = 1:6
        tau(3*i-2:3*i) = tor(:,i);
    end

end

