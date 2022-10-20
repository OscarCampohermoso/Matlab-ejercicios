% Generate random numbers to 1 - 100 and create a conditional to check if that number is greater than 50.
% If it is, then print "Greater than 50" and if it is not, then print "Less than 50".
clc
clear all
close all
for i = 1:100
    x = randi(100);
    if x > 50
        disp('Greater than 50')
    else
        disp('Less than 50')
    end
end