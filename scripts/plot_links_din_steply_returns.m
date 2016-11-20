%this function plots the effective number of links and information for
%steply geometric returns STE matrix as a function of time

function plot_links_din_steply_returns(w,w_step,m,step,clop,time_l)

%-----output-----
%  first figure : no_of_links vs time
% second figure : information vs time

%-----input-----
%      w : window length
% w_step : window step
%      m : number of past days for conditional probabilities
%   step : step size
%      a : constant determining the slope of the Fermi-Dirac distribution
%   clop : 1 if want to use close price;
%          2 if want to use open price;
% time_l : 1 to associate to each window the end of the window considered
%          2 to associate to each window the middle of the window considered


din_members = 1:w_step:4000-w+1;
    
th_matrix = zeros(2,length(din_members));

i = 1;
for din = din_members
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_steply_returns_din=',num2str(din),'.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=6.mat');
    elseif clop ==2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_steply_returns_din=',num2str(din),'.mat');
        S2 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=6.mat');
    end
    load(S1);
    load(S2);
    th_matrix(1,i) = sum(LINKS(:));
    INFO = LINKS.*STEM;
    th_matrix(2,i) = sum(INFO(:));
    i = i + 1;
end

%create no_of_links time series and information time series in correct
%chronological order
no_of_links_TS = fliplr(th_matrix(1,:));
information_TS = fliplr(th_matrix(2,:));

%we use stock 68 as a reference for it has the longest time series
data = importdata('../FTSE_Collection/RBS.csv');
dates = datenum(data.textdata(2:end,6));

if time_l == 1 t = flipud(dates(din_members)); end
if time_l == 2 t = flipud(dates(din_members))-0.5*w; end

%figure
plot(t,no_of_links_TS,'b');
%we set the tick on the 1 March of every year
firstDays = datenum(2001:2014, 3, ones(1, 14));
set(gca, 'XTick', firstDays);
datetick('x','m/yy','keepticks')
xlim([t(1) t(end)])
%oldticksX = get(gca,'xtick');
%oldticklabels = cellstr(get(gca,'xtickLabel'));
%set(gca,'xticklabel',[])
%tmp = text(oldticksX, zeros(size(oldticksX)), oldticklabels, 'rotation',-90,'horizontalalignment','left');

%figure
%plot(t,information_TS);
%firstDays = datenum(2001:2014, 3, ones(1, 14));
%set(gca, 'XTick', firstDays);
%datetick('x','m/yy','keepticks')
%xlim([t(1) t(end)])
%oldticksX = get(gca,'xtick');
%oldticklabels = cellstr(get(gca,'xtickLabel'));
%set(gca,'xticklabel',[])
%tmp = text(oldticksX, zeros(size(oldticksX)), oldticklabels, 'rotation',-90,'horizontalalignment','left');