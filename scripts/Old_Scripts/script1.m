%in order to make scripts executable, please type: chmod a=r+w+x *.m
%to submit this script for execution, please type: matqsub script.m

w = 500;
step = 1;
m = 2;
%m = 3;
clop = 1;
no_of_stock = 97;
import_all_time_series;
convert_dates_to_num;

for din = (1:50:4000-w+1)
    if ~ismember(din,(1:250:4000-w+1))
        for choice = [1,2,3,4,5]
            STEM = calculate_STE_matrix(no_of_stock,din,w,m,step,data,dates,choice,clop);
            if clop == 1
                S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=',num2str(choice),'.mat');
                %S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_din=',num2str(din),'/STE_step=',num2str(step),'_choice=',num2str(choice),'.mat');
            elseif clop == 2
                S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=',num2str(choice),'.mat');
                %S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_din=',num2str(din),'/STE_step=',num2str(step),'_choice=',num2str(choice),'.mat');
            end
            save(S1,'STEM');
        end
    end
end
