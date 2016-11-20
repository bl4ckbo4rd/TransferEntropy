%TS has to be a matrix where columns are different observations (time)
%and rows are different items (different stocks, counties and so on)

%input variables: v_i, v_j, TS
%is v_j causing v_i ?

mn1=m-1;
mn2=mn1+delta;

len=size(TS,2);
nrows=len-step*mn2;

p  = perms(linspace(1,m,m));
pd = perms(linspace(1,m+delta,m+delta));
s  = size(p, 1);
sd = size(pd,1);


v_ran1=[];
v_ran2=[];
v_ran3=[];
for i=1:nrows
    [values1,ranks1]=sort(TS(v_i,i:step:i+step*mn1));
    [values2,ranks2]=sort(TS(v_j,i:step:i+step*mn1));
    [values3,ranks3]=sort(TS(v_i,i:step:i+step*mn2));
    
    v_ran1=[v_ran1;ranks1];
    v_ran2=[v_ran2;ranks2];
    v_ran3=[v_ran3;ranks3];
end

vvv=[v_ran1, v_ran2, v_ran3];

probabilities;

%prob_tot contains all the possible occurrences of r_x, r_y and s_x
%(defined in probabilities) with the corresponding value of
%prob(s_x, r_x, r_y), prob(s_x | r_x, r_y), prob(s_x | r_x).
prob_tot=[prob,prob_c2(:,2*m+m+delta+1),prob_c1(:,2*m+m+delta+1)];

%nz is the vector of non zeros prob_c1 and prob_c2
tmp1 = prob_tot(:,2*m+m+delta+2).*prob_tot(:,2*m+m+delta+3);
nz   = find(tmp1 > 0);

%since prob_c1 = p(s_x | r_x)
%and   prob_c2 = p(s_x | r_x, r_y)
%if the former is zero, the second is zero as well.
%by the way the opposite is not true, so we control both prob_c2 and
%prob_c1
%Moreover since prob = p(s_x, r_x, r_y) = p(s_x | r_x, r_y) p (r_x, r_y)
%if prob_c2 is zero also prob is zero.
%Thus, in the sum contained in the TE definition, we need to sum only over 
%the rows nz.
tmp = prob_tot(nz,2*m+m+delta+1:2*m+m+delta+3);

TE_j_to_i=sum(tmp(:,1).*log2(tmp(:,2)./tmp(:,3)));

TE=TE_j_to_i;