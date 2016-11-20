%calculate the entropy rate of the arithmetic return of individual stock

%import_all_time_series;

%din  = 1;   %diff(final_day,end_date)+1
w    = 350; %window length
step = 1;   %time scale

h_x_a_return_matrix = zeros(97,2);

for i = 1:97
    if size(data(i).data(:,1),1) >= (din+w-1)
        TS = fliplr(data(i).data(din:din+w-1,1)');  %create time series
        
        TS_a_return = zeros(1,w-1);                   %create place holder for arithmetic return time series
        
        for j = 1:w-1       %calculate geometric return time series
            TS_a_return(j) = TS(j+1) - TS(j);
        end
        
        TS_a_return_ran = TS_a_return(randperm(length(TS_a_return))); %generate randomised arithmetic return time series
        
        h_x_a_return_matrix(i,1) = Sh_x(step,TS_a_return);
        h_x_a_return_matrix(i,2) = Sh_x(step,TS_a_return_ran);
    end
end
disp(h_x_a_return_matrix)