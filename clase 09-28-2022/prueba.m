%{
A simple matlab program to calculate the percentage of a number
%}
clc
clear all
close all
x=input('Enter the number:');
y=input('Enter the percentage:');
z=(x*y)/100;
fprintf('The percentage of %d is %d',x,z)
