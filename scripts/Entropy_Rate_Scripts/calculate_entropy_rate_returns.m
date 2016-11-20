%calculate the entropy rate of the return of individual stock

import_all_time_series;

din  = 1;   %diff(final_day,end_date)+1
w    = 350; %window length
step = 1;   %time scale

h_x_return_matrix = zeros(97,3);

for i = 1:97
    TS = fliplr(data(i).data(din:din+w-1,1)');  %create time series
    TS_ran = TS(randperm(length(TS)));          %generate randomised time series
    
    TS_return = zeros(1,w-1);                   %create place holder for return time series
    TS_ran_return = zeros(1,w-1);               %create place holder for return of randomised time series
    
    for j = 1:w-1       %calculate return time series
        TS_return(j) = log(TS(j+1)) - log(TS(j));
    end
    
    TS_return_ran = TS_return(randperm(length(TS_return))); %generate randomised return time series
    
    for k = 1:w-1       %calculate return of randomised time series
        TS_ran_return(k) = log(TS_ran(k+1)) - log(TS_ran(k));
    end
    
    h_x_return_matrix(i,1) = Sh_x(step,TS_return);
    h_x_return_matrix(i,2) = Sh_x(step,TS_return_ran);
    h_x_return_matrix(i,3) = Sh_x(step,TS_ran_return);
end
disp(h_x_return_matrix)