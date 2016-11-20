%TS has to be a row vector of item (stock price, return, etc.)
%where columns are different observations (time)

%input variables: step, TS

%step is the time scale
%TS is a row vector of time series 
%we look at how much information can be extracted
%from the history of a time series to predict its future.
%expected to be small!
function h_x = Sh_x (step,TS)

%m is the number of present + past observations (set m=2)
%delta is the number of future observations (set delta=1)
m = 2;         %present + 1 past time step to predict
delta = 1;     %# of future step

v_i=1;
%v_j=2;

mn1=m-1;
mn2=mn1+delta;

len=size(TS,2);
nrows=len-step*mn2;

p  = perms(linspace(1,m,m));
pd = perms(linspace(1,m+delta,m+delta));
s  = size(p, 1);
sd = size(pd,1);


v_ran1=zeros(nrows,m);
v_ran3=zeros(nrows,m+delta);
for i=1:nrows
    [~,ranks1]=sort(TS(v_i,i:step:i+step*mn1));
    [~,ranks3]=sort(TS(v_i,i:step:i+step*mn2));
    
    v_ran1(i,:)=ranks1;
    v_ran3(i,:)=ranks3;
end

%vv=[v_ran1, v_ran3];

probabilities_v2;

%prob_h_x contains all the possible occurrences of r_x and s_x
%(defined in prob_c3) with the corresponding value of
%prob(s_x | r_x) and prob(s_x, r_x).
prob_h_x=[prob,prob_c(:,m+m+delta+1)];

%nz is the vector of non zeros prob_c
nz   = find(prob_h_x(:,m+m+delta+2) > 0);

%since prob = p(s_x, r_x) = p(s_x | r_x) p (r_x) = prob_c p(r_x)
%if prob_c is zero prob is also zero.
%Thus, in the sum contained in the h_x definition, we need to sum only over 
%the rows nz.
tmp = prob_h_x(nz,m+m+delta+1:m+m+delta+2);

h_x=-sum(tmp(:,1).*log2(tmp(:,2)));