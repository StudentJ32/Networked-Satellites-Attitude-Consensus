function du = rigid( t,u)
% ODE rigid
%  

%u is the angular velocity and quaternion of all satellite.
    global k_G D_G A B qr J
    du = zeros(24+18,1);
    
    w = zeros(3,6);q = zeros(4,6);
    dw = zeros(3,6);dq = zeros(4,6);
    for i = 1:6
        w(:,i) = u(3*i-2:3*i);
        q(:,i) = u(4*i+15:4*i+18);
    end
    
%calculate the torque
    tor = zeros(3,6);
    for i=1:6
        tor(1:3,i) = -k_G*veq(crossq(conjq(qr),q(:,i)))-D_G*w(:,i);
        for j = 1:6
            tor(1:3,i) = tor(1:3,i)-(A(i,j)*veq(crossq(conjq(q(:,j)),q(:,i)))+B(i,j)*(w(:,i)-w(:,j)));
            for k=1:3
            if abs(tor(k,i))>1
               tor(k,i)=tor(k,i)/abs(tor(k,i));
            end
            end
        end             
    end



    for i = 1:6
        % differential equations of omega
        dw(:,i) =  inv(J(3*i-2:3*i,:))*(-(cross(w(:,i),J(3*i-2:3*i,:)*w(:,i)))+tor(:,i));
        %differetial equations of quaternion
        dq(1:3,i) = -cross(w(:,i),q(1:3,i))/2+q(4,i)*w(:,i)/2;
        dq(4,i) = -dot(w(:,i),q(1:3,i))/2;
    end
    
    for i = 1:6
        du(3*i-2:3*i) = dw(:,i);
        du(4*i+15:4*i+18) = dq(:,i);
    end
    
end

