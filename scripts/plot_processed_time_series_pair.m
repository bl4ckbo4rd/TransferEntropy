%     din : diff(last date, end date) + 1
%       w : window length
%    step : step size
%  data_i : stock price cloumn vector of first stock 
%           extracted from data imported by import_all_time_series.m
%  data_j : stock price cloumn vecotr of second stock
%           extracted from data imported by import_all_time_series.m
% dates_i : date labels cloumn vector of first stock
%           extracted from dates by convert_dates_to_num.m
% dates_j : date labels column vector of second stock
%           extracted from dates by convert_dates_to_num.m
%  choice : 1 if want to use stock price;
%           2 if want to use AAFT randomised stock price;
%           3 if want to use daily geometric return;
%           4 if want to use randomised daily geometric return;
%           5 if want to use daily geometric return of AAFT randomised stock price;
%           6 if want to use steply geometric return;
%           7 if want to use steply geometric return of AAFT randomised stock price;

function plot_processed_time_series_pair(din,w,step,i,j,data,dates,choice)

data_i = data(i).data(:,1);
data_j = data(j).data(:,1);
dates_i = dates{i};
dates_j = dates{j};

%check if the two stocks existed for long enough
if length(data_i) >= din+w-1 && length(data_j) >= din+w-1
    
    %extract data on common days
    [~,A] = ismember(dates_i(din:din+w-1),dates_j(din:din+w-1));
    common_data_j = flipud(data_j(din+nonzeros(A)-1,1))';    %flip and convert into row
    [B,~] = find(A);
    common_data_i = flipud(data_i(din+B-1,1))';              %flip and convert into row
    size_common_days = length(B);
    
    %check if there are at least 80% of common days in the window
    if size_common_days >= 0.8*w
        
        %return processed stock price time series
        if choice == 1
            figure
            plot(common_data_i,'b');
            hold on
            plot(common_data_j,'r');
            %scatter(common_data_i(2:end-1)-common_data_i(1:end-2),common_data_j(3:end)-common_data_j(2:end-1));
            
        %return AAFT randomised processed stock price time series
        elseif choice == 2
            %make sure number of common days is even
            if mod(size_common_days,2)
                common_data_i = common_data_i(2:end);
                common_data_j = common_data_j(2:end);
            end
            figure
            plot(AAFT(common_data_i),'b');
            hold on
            plot(AAFT(common_data_j),'r');
            
        %return processed daily geometric return time series
        elseif choice == 3
            %compute the daily geometric return from processed stock price
            geometric_return_i = zeros(1,size_common_days-1);    %create placeholder for speed
            geometric_return_j = zeros(1,size_common_days-1);    %create placeholder for speed
            for k = 1:size_common_days-1
                geometric_return_i(k) = log(common_data_i(k+1)) - log(common_data_i(k));
                geometric_return_j(k) = log(common_data_j(k+1)) - log(common_data_j(k));
            end
            figure
            plot(geometric_return_i,'b');
            hold on
            plot(geometric_return_j,'r');
            %scatter(geometric_return_i(2:end-1)-geometric_return_i(1:end-2),geometric_return_j(3:end)-geometric_return_j(2:end-1));
            
        %return randomised processed daily geometric return time series
        elseif choice == 4
            %compute the dialy geometric return from processed stock price
            geometric_return_i = zeros(1,size_common_days-1);    %create placeholder for speed
            geometric_return_j = zeros(1,size_common_days-1);    %create placeholder for speed
            for k = 1:size_common_days-1
                geometric_return_i(k) = log(common_data_i(k+1)) - log(common_data_i(k));
                geometric_return_j(k) = log(common_data_j(k+1)) - log(common_data_j(k));
            end
            figure
            plot(geometric_return_i(randperm(length(geometric_return_i))),'b');
            hold on
            plot(geometric_return_j(randperm(length(geometric_return_j))),'r');
            
        %return daily geometric return from AAFT randomised processed stock price time series
        elseif choice == 5
            %make sure number of common days is even
            if mod(size_common_days,2)
                common_data_i = common_data_i(2:end);
                common_data_j = common_data_j(2:end);
                size_common_days = size_common_days-1;
            end
            %generate AAFT randomised processed stock price
            AAFT_common_data_i = AAFT(common_data_i);
            AAFT_common_data_j = AAFT(common_data_j);
            %compute the daily geometric return from AAFT randomised processed stock price
            geometric_return_i = zeros(1,size_common_days-1);    %create placeholder for speed
            geometric_return_j = zeros(1,size_common_days-1);    %create placeholder for speed
            for k = 1:size_common_days-1
                geometric_return_i(k) = log(AAFT_common_data_i(k+1)) - log(AAFT_common_data_i(k));
                geometric_return_j(k) = log(AAFT_common_data_j(k+1)) - log(AAFT_common_data_j(k));
            end
            figure
            plot(geometric_return_i,'b');
            hold on
            plot(geometric_return_j,'r');
            
        %return processed steply geometric return time series
        elseif choice == 6
            %compute the steply geometric return from processed stock price
            geometric_return_i = zeros(1,size_common_days-step);    %create placeholder for speed
            geometric_return_j = zeros(1,size_common_days-step);    %create placeholder for speed
            for k = 1:size_common_days-step
                geometric_return_i(k) = log(common_data_i(k+step)) - log(common_data_i(k));
                geometric_return_j(k) = log(common_data_j(k+step)) - log(common_data_j(k));
            end
            figure
            plot(geometric_return_i,'b');
            hold on
            plot(geometric_return_j,'r');
            
        %return steply geometric return from AAFT randomised processed stock price time series
        elseif choice == 7
            %make sure number of common days is even
            if mod(size_common_days,2)
                common_data_i = common_data_i(2:end);
                common_data_j = common_data_j(2:end);
                size_common_days = size_common_days-step;
            end
            %generate AAFT randomised processed stock price
            AAFT_common_data_i = AAFT(common_data_i);
            AAFT_common_data_j = AAFT(common_data_j);
            %compute the steply geometric return from AAFT randomised processed stock price
            geometric_return_i = zeros(1,size_common_days-1);    %create placeholder for speed
            geometric_return_j = zeros(1,size_common_days-1);    %create placeholder for speed
            for k = 1:size_common_days-step
                geometric_return_i(k) = log(AAFT_common_data_i(k+step)) - log(AAFT_common_data_i(k));
                geometric_return_j(k) = log(AAFT_common_data_j(k+step)) - log(AAFT_common_data_j(k));
            end
            figure
            plot(geometric_return_i,'b');
            hold on
            plot(geometric_return_j,'r');
        end
    end
end