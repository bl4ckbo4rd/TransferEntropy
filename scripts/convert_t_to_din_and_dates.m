%this function converts the t into the inital and final dates

%      w : window length
% w_step : window step
%      t : abscissa of the data point of the plots versus time
    
function convert_t_to_din_and_dates(w, w_step, t)

%we use stock 68 as a reference for it has the longest time series
data = importdata('../FTSE_Collection/RBS.csv');
dates = data.textdata(2:end,6);

din = (floor((4000-w+1)/w_step)+1-t) * w_step + 1;

disp(['      din : ',num2str(din)]);
disp(['start day : ',char(dates(din+w))]);
disp(['  end day : ',char(dates(din))]);


    
    
