function STE_greater_than_returns(w,w_step,m,step,th,clop)
    
    din_members = 1:w_step:4000-w+1;
    
    greater = zeros(2,length(din_members));
    
    i = 1;
    for din = din_members
        if clop == 1
            S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=3.mat');
            S2 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=5.mat');
        elseif clop == 2
            S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=3.mat');
            S2 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=5.mat');
        end
        
        load(S1);
        STE1 = STEM;
        load(S2)
        STE2 = STEM;
        
        STE3 = STE1 >= th;
        STE4 = STE2 >= th;
        
        greater(1,i) = sum(STE3(:));
        greater(2,i) = sum(STE4(:));
        
        i = i + 1;
    end
    
    figure
    plot(fliplr(greater(1,:)),'b');
    hold on
    plot(fliplr(greater(2,:)),'r');
end