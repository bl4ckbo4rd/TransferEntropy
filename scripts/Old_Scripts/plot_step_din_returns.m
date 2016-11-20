%this function plots the th_STE, th_ratio and no_of_links for extraction of
%links from prices STE matrix as a function of step size

%         w : window length
%    w_step : window step
%         m : number of past days for conditional probabilities
% criterion : 1 if want to use max area two w_step average AAFT matrix;
%             2 if want to use max area all AAFT matrices;
%             3 if want to use max area twenty-one w_step AAFT matrices;
%      clop : 1 if want to use close price;
%             2 if want to use open price;

function plot_step_din_returns(w,w_step,m,clop)
    
    step_members = [1 5 10 15 20 25 30 35 40 45 50];
    din_members = 1+w_step:w_step:4000-w+1-w_step;
    
    step_matrix = zeros(length(step_members),length(din_members));
    
    i = 1;
    for step = step_members;
        
        j = 1;
        for din = din_members;
            
            if clop == 1
                S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/criterion=',num2str(criterion),'/LINKS_returns_din=',num2str(din),'.mat');
            elseif clop ==2
                S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/criterion=',num2str(criterion),'/LINKS_returns_din=',num2str(din),'.mat');
            end
            
            load(S1);
            step_matrix(i,j) = sum(LINKS(:));
            j = j + 1;
        end
        i = i + 1;
    end
    
    [~,best_step_index] = max(step_matrix);
    best_step = fliplr(step_members(best_step_index));
    
    figure
    plot(best_step);