function [ cq ] = conjq( q )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    qv = -transpose(q(1:3,:));
    cq = transpose([qv q(4)]);

end

