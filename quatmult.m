function [r] = quatmult( q,p )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
r(1:3) = q(4)*p(1:3)+p(4)*q(1:3)+cross(q(1:3),p(1:3));
r(4) = q(4)*p(4)-dot(q(1:3),p(1:3));
end

