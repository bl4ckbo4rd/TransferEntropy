function plot_NETSIM_din_returns(w,w_step,m,step,criterion,clop)

%this function plots the NETSIM, number of removed links and number of
%formed links for returns as a function of time

%         w : window length
%    w_step : window step
%         m : number of past days for conditional probabilities
%      step : step size
% criterion : 1 if want to use max area two w_step average AAFT matrix;
%             2 if want to use max area all AAFT matrices;
%             3 if want to use max area twenty-one w_step AAFT matrices;
%      clop : 1 if want to use close price;
%             2 if want to use open price;
    
din_members = 1+w_step:w_step:4000-w+1-2*w_step;
NETSIM = zeros(1,length(din_members));
NO_REMOVED_LINKS = zeros(1,length(din_members));
NO_FORMED_LINKS = zeros(1,length(din_members));

i = 1;
for din = din_members
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/criterion=',num2str(criterion),'/LINKS_returns_din=',num2str(din+w_step),'.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/criterion=',num2str(criterion),'/LINKS_returns_din=',num2str(din),'.mat');
    elseif clop ==2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/criterion=',num2str(criterion),'/LINKS_returns_din=',num2str(din+w_step),'.mat');
        S2 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/criterion=',num2str(criterion),'/LINKS_returns_din=',num2str(din),'.mat');
    end
    
    load(S1);
    LINKS1 = LINKS;    %LINKS(t-1)
    load(S2)
    LINKS2 = LINKS;    %LINKS(t)
    
    COMMON_LINKS = LINKS1 .* LINKS2;
    REMOVED_LINKS = LINKS1 - COMMON_LINKS;
    FORMED_LINKS = LINKS2 - COMMON_LINKS;
    
    no_removed_links = sum(REMOVED_LINKS(:));
    no_formed_links = sum(FORMED_LINKS(:));
    
    weight = 0.5*(((no_removed_links - no_formed_links)/(no_removed_links + no_formed_links)) + 1);
    trouble1 = no_removed_links + no_formed_links;
    
    if trouble1 ~= 0
        trouble2 = ismember(0,[no_removed_links no_formed_links]);
        if trouble2 == 1
            NETSIM(i) = 1;
        else
            NETSIM(i) = weight*no_removed_links/sum(LINKS1(:)) + (1-weight)*no_formed_links/sum(LINKS2(:));
        end
    end
    
    NO_REMOVED_LINKS(i) = no_removed_links;
    NO_FORMED_LINKS(i) = no_formed_links;
    i = i + 1;
end

NETSIM = fliplr(NETSIM);
NO_REMOVED_LINKS = fliplr(NO_REMOVED_LINKS);
NO_FORMED_LINKS = fliplr(NO_FORMED_LINKS);

figure
plot(NETSIM);

figure
plot(NO_REMOVED_LINKS);

figure
plot(NO_FORMED_LINKS);