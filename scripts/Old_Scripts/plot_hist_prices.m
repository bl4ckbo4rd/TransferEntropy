%given din, w, m and step, this function plots the histograms of the
%entries of the  STE matrix of real prices (blue) and AAFT randomized ones
%(red)

function plot_hist_prices(din,w,m,step,clop)
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=1.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=2.mat');
    elseif clop == 2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=1.mat');
        S2 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=2.mat');
    end
    
    load(S1);
    STE1 = STEM;
    load(S2)
    STE2 = STEM;
    
    [maximum,det] = max([max(STE1(:)) max(STE2(:))]);
    
    if det == 1
        [y1,x] = hist(nonzeros(STE1(:)),20);
        [y2,x] = hist(nonzeros(STE2(:)),x);
    else
        [y2,x] = hist(nonzeros(STE2(:)),20);
        [y1,x] = hist(nonzeros(STE1(:)),x);
    end
    
    figure
    plot(x,y1/sum(y1),'b',x,y2/sum(y2),'r');
    
    figure
    imagesc(STE1);
    caxis([0 maximum]);
    
    figure
    imagesc(STE2);
    caxis([0 maximum]);
end