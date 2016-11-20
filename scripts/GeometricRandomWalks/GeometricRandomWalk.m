%We want to solve the equation:
%dx/x=mu dt + sigma dW
%where dW is a Wiener process, dW/dt=n, where n~N(0,1).

N=1000;
mu=0.001;
sigma=1/sqrt(N);

t = (0:1:N)';                     % t is the column vector [0 1 2 ... N]

Y=randn(N,1);
W = [0; cumsum(Y)];               % S is the running sum of N(0,1) variables

%exact solution to the stochastic equation
plot(t,exp( (mu-sigma^2/2)*t + sigma*W) )

hold on

%We solve the stochastic equation by using a Euler-like method
S(1)=1;
for i=1:N
    S(i+1)=S(i)*(1+mu) + sigma*S(i)*Y(i);
end

plot(t,S,'g')

%We solve the stochastic equation by using a Runge Kutta-like method
S(1)=1;
for i=1:N
    G      = S(i) + mu * S(i) + sigma * S(i);
    S(i+1) = S(i) + mu * S(i) + sigma * S(i) * Y(i) + 0.5 * sigma * (G-S(i)) * (Y(i).^2 - 1);
end

plot(t,S,'r')

%------------------------------------------------------------------------

N = 1000;
t = (0:1:N)';

Y1 = randn(N,1);
Y2 = randn(N,1);

mu1   = 0.0025;
mu2   = 0.002;
sigma = 1/sqrt(N);
J     = 1;

%We solve the stochastic equation by using a Euler-like method
S1(1)=1;
S1(2)=S1(1)*(1+mu1) + sigma*S1(1)*Y1(1);
S2(1)=1;
S2(2)=S2(1)*(1+mu2) + sigma*S2(1)*Y2(1);

for i=1:N-1
    S1(i+2)=S1(i+1)*(1+mu1) + sigma*S1(i+1)*Y1(i+1) + J * (S2(i+1)-S2(i));
    S2(i+2)=S2(i+1)*(1+mu2) + sigma*S2(i+1)*Y2(i+1);
end

plot(t,S1,'r')
hold on
plot(t,S2,'b')

TS=[S1;S2];
m=2;
delta=1;
step=1;

v_j=2;
v_i=1;
STE
TE

v_j=1;
v_i=2;
STE
TE

%----------------------------------------------------------------------

