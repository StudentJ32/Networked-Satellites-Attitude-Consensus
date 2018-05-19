function [ q ] = crossq( q1,q2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    q(1:3,:) = q1(4)*q2(1:3)+q2(4)*q1(1:3)+cross(q1(1:3,:),q2(1:3,:));
    q(4,:) = q1(4)*q2(4)-transpose(q1(1:3))*q2(1:3);
    
end

