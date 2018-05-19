% main function

clc
clear all

%% set ups
global k_G D_G A B qr J
I_3 = eye(3);
D_G = 2*I_3;
qr = [0 0 0 1]'; %reference quaternion
Adj = [0 1 0 0 0 0;1 0 1 0 0 0;0 1 0 0 0 0;0 0 0 0 1 0;0 0 0 1 0 1;0 0 0 0 1 0]; %adjacent matrix
%subcase 1
k_G = 1;
A = 5*Adj;
B = 10*Adj;
% subcase 2
% k_G = 0;
% A = 5*Adj;
% B = 10*Adj;

%% Laplacian Matrix 
L = zeros(6,6);
for i=1:6
    L(i,i) = sum(A(i,:));
end
L = L-A;

%% satelittes specification
J_1 = [1 0.1 0.1;0.1 0.1 0.1;0.1 0.1 0.9];
J_2 = [1.5 0.2 0.3;0.2 0.9 0.4;0.3 0.4 2];
J_3 = [0.8 0.1 0.2;0.1 0.7 0.3;0.2 0.3 1.1];
J_4 = [1.2 0.3 0.7;0.3 0.9 0.2;0.7 0.2 1.4];
J_5 = [0.9 0.15 0.3;0.15 1.2 0.4; 0.3 0.4 1.2];
J_6 = [1.1 0.35 0.45;0.35 1 0.5;0.45 0.5 1.3];

J(1:3,1:3) = J_1; J(4:6,1:3) = J_2; J(7:9,1:3) = J_3;
J(10:12,1:3) = J_4; J(13:15,1:3) = J_5; J(16:18,1:3) = J_6;
%% initial states
q_0 = normq([9 6 1 2;5 6 3 4;7 6 2 6.54;4 3 7 2.4;7 9 1 8.3; 3 7 8 9]'); % initial quaternion
w_0 = zeros(3,6); % initial angular velocity
for i = 1:6
        u0(3*i-2:3*i) = w_0(:,i);
        u0(4*i+15:4*i+18) = q_0(:,i);
end

%% ode solver
[T,U] = ode45(@rigid,[0 40],u0);

%% plot
for i = 1:6
    w_x(:,i) = U(:,3*i-2);
    w_y(:,i) = U(:,3*i-1);
    w_z(:,i) = U(:,3*i);
    q_i(:,i) = U(:,4*i-3+18);
    q_j(:,i) = U(:,4*i-2+18);
    q_k(:,i) = U(:,4*i-1+18);
    q_s(:,i) = U(:,4*i+18);
end

figure(1)
subplot(3,1,1)
plot(T,w_x);
legend('j=1','j=2','j=3','j=4','j=5','j=6')
xlabel('Time (s)');ylabel('\omega_{j}^{x} (rad/s)')
grid on
subplot(3,1,2)
plot(T,w_y);
legend('j=1','j=2','j=3','j=4','j=5','j=6')
xlabel('Time (s)');ylabel('\omega_{j}^{y} (rad/s)')
grid on
subplot(3,1,3)
plot(T,w_z);
legend('j=1','j=2','j=3','j=4','j=5','j=6')
xlabel('Time (s)');ylabel('\omega_{j}^{z} (rad/s)')
grid on
%set(gca,'FontSize',20,'fontWeight','bold')

set(findall(gcf,'type','text'),'FontSize',20)

figure(2)
subplot(4,1,1)
plot(T,q_i);
legend('j=1','j=2','j=3','j=4','j=5','j=6')
xlabel('Time (s)');ylabel('q_{j}^{1}')
grid on
subplot(4,1,2)
plot(T,q_j);
legend('j=1','j=2','j=3','j=4','j=5','j=6')
xlabel('Time (s)');ylabel('q_{j}^{2}')
grid on
subplot(4,1,3)
plot(T,q_k);
legend('j=1','j=2','j=3','j=4','j=5','j=6')
xlabel('Time (s)');ylabel('q_{j}^{3}')
grid on
subplot(4,1,4)
plot(T,q_s);
legend('j=1','j=2','j=3','j=4','j=5','j=6')
xlabel('Time (s)');ylabel('q_{j}^{4}')
grid on
set(findall(gcf,'type','text'),'FontSize',15)