%Be x(t) a time series
%Given {x(t) x(t+D)} we denote by r_x(t) the vector {1 2} if x(t+D)>x(t)
%and the vector {2 1} otherwise. It is called rank vector.
%r_y(t) is the corresponding vector for the time series y(t) at time t.
%Moreover, given {x(t) x(t+D) x(t+2*D)}, s_x(t) is the vector of the
%corresponding ranks.

%occ stands for occurrences
%---------------------------------occ(s_x, r_x, r_y)


prob=[];
for i=1:s
    for j=1:s
        for k=1:sd
            rows1=[];
            for ii=1:nrows
                rows1=[rows1;isequal(v_ran1(ii,:),p(i,:))];
            end

            rows2=[];
            for ii=1:nrows
                rows2=[rows2;isequal(v_ran2(ii,:),p(j,:))];
            end

            rows3=[];
            for ii=1:nrows
                rows3=[rows3;isequal(v_ran3(ii,:),pd(k,:))];
            end

            sums=sum([rows1,rows2,rows3]');
                        
            prob=[prob;p(i,:),p(j,:),pd(k,:),numel(sums(sums==3))];
        end
    end
end

%---------------------------------occ(s_x | r_x)

prob_c1=[];
for i=1:s
    for j=1:s
        for k=1:sd
            rows1=[];
            for ii=1:nrows
                rows1=[rows1;isequal(v_ran1(ii,:),p(i,:))];
            end

            rows3=[];
            for ii=1:nrows
                rows3=[rows3;isequal(v_ran3(ii,:),pd(k,:))];
            end

            sums=sum([rows1,rows3]');
                        
            prob_c1=[prob_c1;p(i,:),p(j,:),pd(k,:),numel(sums(sums==2))];
        end
    end
end

%---------------------------------occ(s_x | r_x, r_y)
%in order to compute these occurrences I need the same matrix computed
%for the full occurrences. the difference between the two will appear in 
%the normalizations
prob_c2=prob;

%-------------------normalize probabilities

prob(:,2*m+m+delta+1)=prob(:,2*m+m+delta+1)./sum(prob(:,2*m+m+delta+1));

for kk=1:s
    prob_c1(1+(kk-1)*s*sd:kk*s*sd,2*m+m+delta+1)=s*prob_c1(1+(kk-1)*s*sd:kk*s*sd,2*m+m+delta+1)/sum(prob_c1(1+(kk-1)*s*sd:kk*s*sd,2*m+m+delta+1));
end

for ii=1:s*s
    prob_c2(1+(ii-1)*sd:ii*sd,2*m+m+delta+1)=prob_c2(1+(ii-1)*sd:ii*sd,2*m+m+delta+1)./sum(prob_c2(1+(ii-1)*sd:ii*sd,2*m+m+delta+1));
end