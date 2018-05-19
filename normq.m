function [ normq ] = normq( q_in )
%UNTITLED Summary of this function goes here
%   normalize a matrix of quaternions
    normq = zeros(size(q_in));
    for i = 1:length(q_in)
        psi = q_in(4,i);
        normq(4,i) = cos(psi/2);
        normq(1:3,i) =  sin(psi/2)*q_in(1:3,i)/norm(q_in(1:3,i));
    end
end

