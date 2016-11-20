%this function plots the NETEVOL for prices STE matrix as a function of time

function plot_NETEVOL_din_prices(w,w_step,m,step,measure,clop)

%-----output-----
%  figure of NETEVOL vs time

%-----input-----
%       w : window length
%  w_step : window step
%       m : number of past days for conditional probabilities
%    step : step size
% measure : 1 if want to use sum_ij [LINKS_ij(t) - LINKS_ij(t-1)]^2;
%           2 if want to use sum_i [sum_j LINKS_ij(t) - sum_j LINKS_ij(t-1)]^2;
%           3 if want to use symmetrised KL divergence between p(t-1) and p(t);
%    clop : 1 if want to use close price;
%           2 if want to use open price;

din_members = 1:w_step:4000-w+1-w_step;
NETEVOL = zeros(1,length(din_members));

i = 1;
for din = din_members
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_prices_din=',num2str(din+w_step),'.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_prices_din=',num2str(din),'.mat');
    elseif clop ==2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_prices_din=',num2str(din+w_step),'.mat');
        S2 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_prices_din=',num2str(din),'.mat');
    end
    
    load(S1);
    LINKS1 = LINKS;    %LINKS(t-1)
    load(S2)
    LINKS2 = LINKS;    %LINKS(t)
    
    if measure == 1
        TEMP = (LINKS2 - LINKS1).^2;
        NETEVOL(i) = sum(TEMP(:))/numel(TEMP);
        
    elseif measure == 2
        temp = abs(sum(LINKS2,2) - sum(LINKS1,2));
        NETEVOL(i) = sum(temp)/length(temp);
        
    elseif measure == 3
        p = sum(LINKS1,2)/sum(LINKS1(:));
        q = sum(LINKS2,2)/sum(LINKS2(:));
        p(find(p==0)) = min(nonzeros(p))/100;
        q(find(q==0)) = min(nonzeros(q))/100;
        temp1 = p.*log(p./q);
        temp2 = q.*log(q./p);
        NETEVOL(i) = (sum(LINKS(:))+sum(LINKS(:)))/2*(sum(temp1)+sum(temp2))/2;
    end
    
    i = i + 1;
end
    
NETEVOL = fliplr(NETEVOL);

%we use stock 68 as a reference for it has the longest time series
data = importdata('../FTSE_Collection/RBS.csv');
dates = datenum(data.textdata(2:end,6));
t = flipud(dates(din_members));

figure
plot(t,NETEVOL);
xlim([t(1) t(end)])
datetick('x','mmm/yy','keepticks')
oldticksX = get(gca,'xtick');
oldticklabels = cellstr(get(gca,'xtickLabel'));
set(gca,'xticklabel',[])
tmp = text(oldticksX, zeros(size(oldticksX)), oldticklabels, 'rotation',-90,'horizontalalignment','left');