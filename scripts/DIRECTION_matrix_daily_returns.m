function DIRECTION_matrix_daily_returns(w,w_step,m,step,clop)
    
din_members = 1+w_step:w_step:4000-w+1-w_step;
DIRECTION = zeros(97,length(din_members));

i = 1;
for din = din_members
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=3.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/DIRECTION_time_matrices/w=',num2str(w),'_step=',num2str(step),'_DIR_daily_returns.mat');
    elseif clop ==2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=3.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/DIRECTION_time_matrices/w=',num2str(w),'_step=',num2str(step),'_DIR_daily_returns.mat');
    end
    
    load(S1);
    STEM = STEM;
    
    out = sum(STEM,2);
    in = sum(STEM,1)';
    d = out - in;
    
    DIRECTION(:,i) = d;
    
    i = i + 1;
end

DIRECTION = fliplr(DIRECTION);
save(S2,'DIRECTION');