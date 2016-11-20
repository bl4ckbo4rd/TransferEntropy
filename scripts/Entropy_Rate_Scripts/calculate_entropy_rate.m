%calculate the entropy rate of individual stock

%import_all_time_series;

din  = 1;   %diff(final_day,end_date)+1
w    = 350; %window length
step = 1;   %time scale

h_xmatrix = zeros(97,2);

for i = 1:97
    TS = fliplr(data(i).data(din:din+w-1,1)');
    TS_ran  = TS(randperm(length(TS)));
    TS_AAFT = AAFT(TS);
    h_xmatrix(i,1) = Sh_x(step,TS);
    h_xmatrix(i,2) = Sh_x(step,TS_ran);
    h_xmatrix(i,3) = Sh_x(step,TS_AAFT);
end
disp(h_xmatrix)