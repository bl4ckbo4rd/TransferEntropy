%convert the dates array for each stock into a number array of date labels

for i = 1:no_of_stock
    dates{i} = datenum(data(i).textdata(2:end,6));
end