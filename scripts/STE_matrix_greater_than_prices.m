function STE_matrix_greater_than_prices(din,w,m,step,th,clop)
    
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
    
    STE3 = STE1 >= th;
    STE4 = STE2 >= th;
    
    figure
    imagesc(STE3);
    caxis([0 1]);
    
    figure
    imagesc(STE4);
    caxis([0 1]);
end