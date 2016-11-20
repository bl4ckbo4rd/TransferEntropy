% no_of_stock : the number of stocks among which to claculate the symbolic transfer entropy
%         din : diff(last date, end date) + 1
%           w : window length
%           m : number of past days for conditional probilities
%        step : step size
%        data : data matrix of all stocks imported by import_all_time_series.m
%       dates : date labels for each stock by convert_dates_to_num.m
%      choice : 1 if want to use stock price;
%               2 if want to use AAFT randomised stock price;
%               3 if want to use daily geometric return;
%               4 if want to use randomised daily geometric return;
%               5 if want to use daily geometric return of AAFT randomised stock price;
%               6 if want to use steply geometric return;
%               7 if want to use steply geometric return of AAFT randomised stock price;
%        clop : 1 if want to use close price;
%               2 if want to use open price;

function STE_matrix = calculate_STE_matrix(no_of_stock,din,w,m,step,data,dates,choice,clop)

STE_matrix = zeros(no_of_stock,no_of_stock);    %create place holder for the symbolic transfer entropies

for i = 1:no_of_stock
    for j = 1:no_of_stock
    
        %skip self STE
        if i ~= j
            data_i = data(i).data(:,clop);    %extract stock price of stock i
            data_j = data(j).data(:,clop);    %extract stock price of stock j
            dates_i = dates{i};            %extract trading days of stock i
            dates_j = dates{j};            %extract trading days of stock j
            TS = processed_time_series_pair(din,w,step,data_i,data_j,dates_i,dates_j,choice);
                
            %check if there are at least 80% of common days in the window
            if size(TS,2) >= 0.8*w
                STE_matrix(j,i) = STE(step,m,TS);
            end
        end
    end
end