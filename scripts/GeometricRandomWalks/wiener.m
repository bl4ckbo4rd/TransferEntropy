% wiener(N) simulates a one-dimensional Wiener motion on [0,1] using 
% normally distributed steps

function [W] = wiener(N)

clf;                                % clear the entire figure

t = (0:1:N)'/N;                     % t is the column vector [0 1/N 2/N ... 1]

W = [0; cumsum(randn(N,1))]/sqrt(N); % S is running sum of N(0,1/N) variables

plot(t,W);          % plot the path
hold on
plot(t,0*t,':')
axis([0 1 -2 2])
title([int2str(N) '-step version of the Wiener process and its mean'])
hold off