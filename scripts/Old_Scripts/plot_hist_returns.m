%given din, w, m and step, this function plots the histograms of the
%entries of the STE matrix of real returns (blue) and randomized ones (red)
%nb: randomised returns are obtained first taking the AAFT of real prices,
%and then computing returns from these randomised time series.

function plot_hist_returns(din,w,m,step,clop)
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=3.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=4.mat');
        S3 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=5.mat');
    elseif clop == 2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=3.mat');
        S2 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=4.mat');
        S3 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=5.mat');
    end
    
    load(S1);
    STE1 = STEM;
    load(S2)
    STE2 = STEM;
    load(S3)
    STE3 = STEM;
    
    [maximum,det] = max([max(STE1(:)) max(STE3(:))]);
    
    if det == 1
        [y1,x] = hist(nonzeros(STE1(:)),20);
        [y2,x] = hist(nonzeros(STE2(:)),x);
        [y3,x] = hist(nonzeros(STE3(:)),x);
    else
        [y3,x] = hist(nonzeros(STE3(:)),20);
        [y1,x] = hist(nonzeros(STE1(:)),x);
        [y2,x] = hist(nonzeros(STE2(:)),x);
    end
    
    figure
    plot(x,y1/sum(y1),'b',x,y2/sum(y2),'g',x,y3/sum(y3),'r');
    
    figure
    imagesc(STE1);
    caxis([0 maximum]);
    
    figure
    imagesc(STE3);
    caxis([0 maximum]);
end