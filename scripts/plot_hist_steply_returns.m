%given din, w, m and step, this function plots the histograms of the
%entries of the STE matrix of the real steply geometric returns (blue) and
%that of the randomized ones (red)
%nb: randomised steply geometric returns are obtained first taking the AAFT
%of the real prices, and then computing the steply geometric returns from
%this randomised time series.

function plot_hist_steply_returns(din,w,w_step,m,step,clop)

if clop == 1
    S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=6.mat');
    if din-10*w_step < 1
        for i = 1:21
            S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(1+(21-i)*w_step),'_choice=7.mat');
        end
    elseif din+10*w_step > 4000-w+1
        for i = 1:21
            S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(4000-w+1-(i-1)*w_step),'_choice=7.mat');
        end
    else
        for i = 1:21
            S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din+(11-i)*w_step),'_choice=7.mat');
        end
    end
elseif clop == 2
    S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=6.mat');
    if din-10*w_step < 1
        for i = 1:21
            S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(1+(21-i)*w_step),'_choice=7.mat');
        end
    elseif din+10*w_step > 4000-w+1
        for i = 1:21
            S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(4000-w+1-(i-1)*w_step),'_choice=7.mat');
        end
    else
        for i = 1:21
            S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din+(11-i)*w_step),'_choice=7.mat');
        end
    end
end

load(S1);
STE1 = STEM;
STE = [];
for i = 1:21
    load(S{i});
    STE = [STE STEM];
end

[~,det] = max([max(STE1(:)) max(STE(:))]);

if det == 1
    [y1,x] = hist(nonzeros(STE1(:)),20);
    [y2,x] = hist(nonzeros(STE(:)),x);
else
    [y2,x] = hist(nonzeros(STE(:)),20);
    [y1,x] = hist(nonzeros(STE1(:)),x);
end

figure
plot(x,y1/sum(y1),'b',x,y2/sum(y2),'r');

figure
imagesc(STE1);