function STEmatrix_g_return = calculate_STE_geometric_return(no_of_stock,din,w,m,step,data)

STEmatrix_g_return = zeros(no_of_stock,no_of_stock);    %create place holder for the symbolic transfer entropies

for i=1:no_of_stock
    ts_size(i)=size(data(i).data(:,1),1);
end

%store the direct time series and dates in these two vectors
for i=1:no_of_stock
    dir_data{i}    = data(i).data(:,1);
    dir_dates{i}   = data(i).textdata(2:end,6);
end

for ii=1:no_of_stock
    for jj=1:no_of_stock
        if ((jj~=ii) && (ts_size(ii) >= din+w-1) && (ts_size(jj) >= din+w-1))
            common_days = intersect(dir_dates{ii}(din:din+w-1),dir_dates{jj}(din:din+w-1));
            size_common_days = numel(common_days);
            
            c_dir_data_i = zeros(1,size_common_days);
            c_dir_data_j = zeros(1,size_common_days);

            %we compute the STE between jj and ii only if there are enough
            %common days in the window considered. if this is the case,
            %we first construct the time series of the common days:
            if (size_common_days > 0.8*w)
                
                g_return_i = zeros(1,size_common_days-1);    %create place holder for geometric return time series of stock i
                g_return_j = zeros(1,size_common_days-1);    %create place holder for geometric return time series of stock j
                
                for k=1:size_common_days
                    k_i=strmatch(common_days(k),dir_dates{ii}(:));
                    k_j=strmatch(common_days(k),dir_dates{jj}(:));

                    c_dir_data_i(end-k+1)=dir_data{ii}(k_i);    %no need to flip
                    c_dir_data_j(end-k+1)=dir_data{jj}(k_j);    %no need to flip
                end
                
                for kk = 1:size_common_days-1    %compute geometric return time series
                    g_return_i(kk) = log(c_dir_data_i(kk+1)) - log(c_dir_data_i(kk));
                    g_return_j(kk) = log(c_dir_data_j(kk+1)) - log(c_dir_data_j(kk));
                end
                
                %compute the STE from jj to ii using geometric return:
                TS = [g_return_i; g_return_j];
                TE = STE_opt1(step, m, TS);
                %STEmatrix (jj,ii) contains the STE from jj to ii
                STEmatrix_g_return(jj,ii) = TE;
            end
            
        end
        
    end
end