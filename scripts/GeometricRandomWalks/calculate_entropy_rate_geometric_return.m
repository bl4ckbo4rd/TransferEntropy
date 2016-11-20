%calculate the entropy rate of the geometric return of individual stock

%import_all_time_series;

%din  = 1;   %diff(final_day,end_date)+1
w    = 350; %window length
step = 1;   %time scale

h_x_g_return_matrix = zeros(97,2);

for i = 1:97
    if size(data(i).data(:,1),1) >= (din+w-1)
        TS = fliplr(data(i).data(din:din+w-1,1)');  %create time series
    
        TS_g_return = zeros(1,w-1);                   %create place holder for geometric return time series
    
        for j = 1:w-1       %calculate geometric return time series
            TS_g_return(j) = log(TS(j+1)) - log(TS(j));
        end
    
        TS_g_return_ran = TS_g_return(randperm(length(TS_g_return))); %generate randomised geometric return time series
    
        h_x_g_return_matrix(i,1) = Sh_x(step,TS_g_return);
        h_x_g_return_matrix(i,2) = Sh_x(step,TS_g_return_ran);
    end
end
disp(h_x_g_return_matrix)