%this function converts the din for the specified stock into the
%corresponding date

% stock_no : the numerical label given to the enquired stock
%      din : diff(last date, end date) + 1

function convert_din_to_date(stock_no,din,data)

dates = data(stock_no).textdata(2:end,6);

if length(dates) >= din
    disp(dates(din))
else
    disp('stock did not exist')
end