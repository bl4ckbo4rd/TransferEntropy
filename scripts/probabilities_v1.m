%Be x(t) a time series
%Given {x(t) x(t+D)} we denote by r_x(t) the vector {1 2} if x(t+D)>x(t)
%and the vector {2 1} otherwise. It is called rank vector.
%r_y(t) is the corresponding vector for the time series y(t) at time t.
%Moreover, given {x(t) x(t+D) x(t+2*D)}, s_x(t) is the vector of the
%corresponding ranks.

%occ stands for occurrences
%---------------------------------occ(s_x, r_x, r_y)



rows1=zeros(nrows,1);
rows2=zeros(nrows,1);
rows3=zeros(nrows,1);

prob=zeros(s*s*sd,2*m+(m+1)+1);

kk=1;
for i=1:s
    for j=1:s
        for k=1:sd

            for ii=1:nrows
                rows1(ii)=isequal(v_ran1(ii,:),p(i,:));
                rows2(ii)=isequal(v_ran2(ii,:),p(j,:));
                rows3(ii)=isequal(v_ran3(ii,:),pd{i}(k,:));
            end

            sums=sum([rows1,rows2,rows3],2);
                        
            prob(kk,:)=[p(i,:),p(j,:),pd{i}(k,:),numel(sums(sums==3))];
            kk=kk+1;
        end
    end
end

%---------------------------------occ(s_x | r_x)

prob_c1=zeros(s*s*sd,2*m+(m+1)+1);

kk=1;
for i=1:s
    for j=1:s
        for k=1:sd
            for ii=1:nrows
                rows1(ii)=isequal(v_ran1(ii,:),p(i,:));
                rows3(ii)=isequal(v_ran3(ii,:),pd{i}(k,:));
            end

            sums=sum([rows1,rows3],2);
                        
            prob_c1(kk,:)=[p(i,:),p(j,:),pd{i}(k,:),numel(sums(sums==2))];
            kk=kk+1;
        end
    end
end

%---------------------------------occ(s_x | r_x, r_y)
%in order to compute these occurrences I need the same matrix computed
%for the full occurrences. the difference between the two will appear in 
%the normalizations
prob_c2=prob;

%-------------------normalize probabilities

prob(:,2*m+(m+1)+1)=prob(:,2*m+(m+1)+1)./sum(prob(:,2*m+(m+1)+1));

for kk=1:s
    prob_c1(1+(kk-1)*s*(m+1):kk*s*(m+1),2*m+(m+1)+1)=s*prob_c1(1+(kk-1)*s*(m+1):kk*s*(m+1),2*m+(m+1)+1)/sum(prob_c1(1+(kk-1)*s*(m+1):kk*s*(m+1),2*m+(m+1)+1));
end

not_n=isnan(prob_c1(:,2*m+(m+1)+1));
prob_c1(not_n,2*m+(m+1)+1)=0;

for ii=1:s*s
    prob_c2(1+(ii-1)*(m+1):ii*(m+1),2*m+(m+1)+1)=prob_c2(1+(ii-1)*(m+1):ii*(m+1),2*m+(m+1)+1)./sum(prob_c2(1+(ii-1)*(m+1):ii*(m+1),2*m+(m+1)+1));
end

not_n=isnan(prob_c2(:,2*m+(m+1)+1));
prob_c2(not_n,2*m+(m+1)+1)=0;