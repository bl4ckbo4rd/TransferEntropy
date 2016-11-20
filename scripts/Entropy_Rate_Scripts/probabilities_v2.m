%Be x(t) a time series
%Given {x(t) x(t+D)} we denote by r_x(t) the vector {1 2} if x(t+D)>x(t)
%and the vector {2 1} otherwise. It is called rank vector.
%Moreover, given {x(t) x(t+D) x(t+2*D)}, s_x(t) is the vector of the
%corresponding ranks.

%---------------------------------occ(s_x, r_x) for h_x
%what we need is a matrix similar to prob_c1 in probabilities.m
%in fact, we need a simplier version of it

rows1=zeros(nrows,1);
rows3=zeros(nrows,1);

prob=zeros(s*sd,m+m+delta+1);

kk=1;
for i=1:s
    for k=1:sd
        for ii=1:nrows
            rows1(ii)=isequal(v_ran1(ii,:),p(i,:));
            rows3(ii)=isequal(v_ran3(ii,:),pd(k,:));
        end

        sums=sum([rows1,rows3],2);
                    
        prob(kk,:)=[p(i,:),pd(k,:),numel(sums(sums==2))];
        kk=kk+1;
    end
end

%---------------------------------occ(s_x | r_x) for h_x
%obviously, what we need is the exact same matrix prob_c3
%we just need to normalise it differently
prob_c=prob;

%-------------------normalize probabilities

prob(:,m+m+delta+1)=prob(:,m+m+delta+1)./sum(prob(:,m+m+delta+1));

for pp=1:s
    prob_c(1+(pp-1)*sd:pp*sd,m+m+delta+1)=prob_c(1+(pp-1)*sd:pp*sd,m+m+delta+1)./sum(prob_c(1+(pp-1)*sd:pp*sd,m+m+delta+1));
end