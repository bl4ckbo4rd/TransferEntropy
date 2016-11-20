%TS has to be a matrix where columns are different observations (time)
%and rows are different items (different stocks, counties and so on)

%input variables: step, TS

%step is the time scale
%TS is a matrix whose first row is the first time series
%and whose second row is the second time series. 
%we look at the influence 2 -> 1.
%is v_j causing v_i ?
function TE = STE(step,m,TS)
%m is the number of present + past observations 

v_i=1;
v_j=2;

mn1=m-1;
mn2=mn1+1;

len=size(TS,2);
nrows=len-step*mn2;

p  = perms(linspace(1,m,m));
s  = size(p, 1);

for k=1:s
    for Idx=1:m+1
        c=false(1,size(p,2)+1);
        c(Idx)=true;
        pdk=nan(size(c));
        pdk(~c)=p(k,:);
        pdk(c)=m+1;
        pd{k}(Idx,:)=pdk;
    end
end

sd = size(pd{k},1);

v_ran1=zeros(nrows,m);
v_ran2=zeros(nrows,m);
v_ran3=zeros(nrows,m+1);
for i=1:nrows
    [~,ranks1]=sort(TS(v_i,i:step:i+step*mn1));
    [~,ranks2]=sort(TS(v_j,i:step:i+step*mn1));
    [~,ranks3]=sort(TS(v_i,i:step:i+step*mn2));
    
    v_ran1(i,:)=ranks1;
    v_ran2(i,:)=ranks2;
    v_ran3(i,:)=ranks3;
end

probabilities_v1;    %call script to compute experimental probabilites from time series

%prob_tot contains all the possible occurrences of r_x, r_y and s_x
%(defined in probabilities) with the corresponding value of
%prob(s_x, r_x, r_y), prob(s_x | r_x, r_y), prob(s_x | r_x).
prob_tot=[prob,prob_c2(:,2*m+(m+1)+1),prob_c1(:,2*m+(m+1)+1)];

nz = prob_tot(:,2*m+(m+1)+2).*prob_tot(:,2*m+(m+1)+3);

%since prob = p(s_x, r_x, r_y) = p(s_x | r_x, r_y) p (r_x, r_y)
%if prob_c2 is zero also prob is zero.
%By the way we also want to exclude those cases when prob_c1 is 0.
%Thus, in the sum contained in the TE definition, we need to sum only over 
%the rows nz.
tmp = prob_tot(nz>0,2*m+(m+1)+1:2*m+(m+1)+3);

TE=sum(tmp(:,1).*log2(tmp(:,2)./tmp(:,3)));