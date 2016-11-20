%this function plots the th_STE, th_ratio and no_of_links for extraction of
%links from geometric returns STE matrices as a function of time

%         w : window length
%    w_step : window step
%         m : number of past days for conditional probabilities
%      step : step size
%     lower : lower bound of th_STE
%     upper : upper bound of th_STE
% criterion : 1 if want to use max area two w_step average AAFT matrix;
%             2 if want to use max area all AAFT matrices;
%             3 if want to use max area twenty-one w_step AAFT matrices;
%      clop : 1 if want to use close price;
%             2 if want to use open price;

function plot_links_din_returns(w,w_step,m,step,lower,upper,criterion,clop)
    
    din_members = 1+w_step:w_step:4000-w+1-w_step;
    
    th_matrix = zeros(3,length(din_members));
    
    if ismember(criterion,[1 3])
        STE = 0;
    elseif criterion == 2
        STE = [];
        for din = 1:w_step:4000-w+1
            load(strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=5.mat'));
            STE = [STE STEM];
        end
    end
    
    i = 1;
    for din = din_members
        th_matrix(:,i) = extract_links_returns(din,w,w_step,m,step,lower,upper,criterion,clop,STE)';
        i = i + 1;
    end
    
    th_STE_TS = fliplr(th_matrix(1,:));
    th_ratio_TS = fliplr(th_matrix(2,:));
    no_of_links_TS = fliplr(th_matrix(3,:));
    
    figure
    plot(no_of_links_TS);
    
    figure
    plot(th_ratio_TS);
    
    figure
    plot(th_STE_TS);