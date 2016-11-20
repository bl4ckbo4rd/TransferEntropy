function STE_greater_than_prices(w,w_step,m,step,th,clop)

din_members = 1:w_step:4000-w+1;

greater = zeros(2,length(din_members));

i = 1;
for din = din_members
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
    
    greater(1,i) = sum(STE3(:));
    greater(2,i) = sum(STE4(:));
    
    i = i + 1;
end

%we use stock 68 as a reference for it has the longest time series
data = importdata('../FTSE_Collection/RBS.csv');
dates = datenum(data.textdata(2:end,6));
t = flipud(dates(din_members));

figure
plot(t,fliplr(greater(1,:)),'b');
hold on
plot(t,fliplr(greater(2,:)),'r');
xlim([t(1) t(end)])
datetick('x','mmm-yy','keepticks')