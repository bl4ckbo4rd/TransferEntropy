%Amplitude Adjusted Fouries Transform (AAFT)
%Here we take a period + noise signal and we compute
%its Fourier transform.
%then, we modify its Fouries by random phases
%and we antitransform.
%In this way we get a random signal which has the same 
%power spectrum of the original one.

function Xr = AAFT (X)

L  = length(X);        % Length of signal

Y  = fft(X);

%this is to plot the power spectrum of the signal
%P2 = abs(Y/L);
%P1 = P2(1:L/2+1);
%P1(2:end-1) = 2*P1(2:end-1);
%f  = Fs*(0:(L/2))/L;
%plot(f,P1)

%we add a common phase to destroy long scale patterns
mu = rand*L;
r_phi = mu*ones(1,L/2-1) + randn(1,L/2-1);
%r_phi = L*rand(1,L/2-1) + randn(1,L/2-1);
Yr(1) = Y(1);
Yr(2:L/2) = Y(2:L/2) .* exp(1i*r_phi); 
Yr(L/2+1) = Y(L/2+1);
Yr(L/2+2:L) = Y(L/2+2:end) .* exp(-1i*fliplr(r_phi));

Xr = ifft(Yr);
