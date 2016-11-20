%this function plots the step at which the effective number of links
%extracted from the daily geometric returns STE matrix is highest as a function of time

function plot_step_din_daily_returns(w,w_step,m,clop)

%-----output-----
%  figure of best step vs time

%-----input-----
%      w : window length
% w_step : window step
%      m : number of past days for conditional probabilities
%   clop : 1 if want to use close price;
%          2 if want to use open price;

step_members = [1 5 10 15 20 25 30 35 40 45 50];
din_members = 1:w_step:4000-w+1;

step_matrix = zeros(length(step_members),length(din_members));

i = 1;
for step = step_members;
    
    j = 1;
    for din = din_members;
        
        if clop == 1
            S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_daily_returns_din=',num2str(din),'.mat');
        elseif clop ==2
            S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_daily_returns_din=',num2str(din),'.mat');
        end
        
        load(S1);
        step_matrix(i,j) = sum(LINKS(:));
        j = j + 1;
    end
    i = i + 1;
end

[~,best_step_index] = max(step_matrix);
best_step = fliplr(step_members(best_step_index));

%we use stock 68 as a reference for it has the longest time series
data = importdata('../FTSE_Collection/RBS.csv');
dates = datenum(data.textdata(2:end,6));
t = flipud(dates(din_members));

figure
plot(t,best_step);
xlim([t(1) t(end)])
datetick('x','mmm/yy','keepticks')
oldticksX = get(gca,'xtick');
oldticklabels = cellstr(get(gca,'xtickLabel'));
set(gca,'xticklabel',[])
tmp = text(oldticksX, zeros(size(oldticksX)), oldticklabels, 'rotation',-90,'horizontalalignment','left');