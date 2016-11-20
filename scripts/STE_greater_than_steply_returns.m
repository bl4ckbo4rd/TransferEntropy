%this function plots, for a given threshold th, the ratio of the number of
%pairs for which STE is greater than th in the real dataset over the ratio
%of the number of pairs for which STE is greater that th in the surrogate
%dataset.


function STE_greater_than_steply_returns(w,w_step,m,step,th,clop)

din_members = 1:w_step:4000-w+1;

greater = zeros(2,length(din_members));

i = 1;
for din = din_members
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=6.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=7.mat');
    elseif clop == 2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=6.mat');
        S2 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=7.mat');
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

%we use stock 68 as a reference for it has the longest time series
data = importdata('../FTSE_Collection/RBS.csv');
dates = datenum(data.textdata(2:end,6));
t = flipud(dates(din_members))-0.5*w;

figure
plot(t,fliplr(greater(1,:)./greater(2,:)),'k');
%hold on
%plot(t,fliplr(greater(2,:)),'r');

%we set the tick on the 1 March of every year
firstDays = datenum(2001:2014, 3, ones(1, 14));
set(gca, 'XTick', firstDays);
datetick('x','m/yy','keepticks')
xlim([t(1) t(end)])

%xlim([t(1) t(end)])
%datetick('x','mmm-yy','keepticks')