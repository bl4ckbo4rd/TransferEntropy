%import_all_time_series;

for i=1:97
    ts_size(i)=size(data(i).data(:,1),1);
end

%store the direct time series and dates in these two vectors
for i=1:97
    dir_data{i}    = flipud(data(i).data(:,1));
    dir_dates{i}   = flipud(data(i).textdata(2:end,6));
end

%we will have to play with these parameters
din  = 1;     %initial day
w    = 350;    %window length
step = 1;      %time scale 

for ii=1:6
    for jj=1:6
        if(jj~=ii)
            common_days = intersect(dir_dates{ii}(din:din+w-1),dir_dates{jj}(din:din+w-1));
            size_common_days = numel(common_days);

            %we compute the STE between jj and ii only if there are enough
            %common days in the window considered. if this is the case,
            %we first construct the time series of the common days:
            if (size_common_days > 0.8*w)
                for k=1:size_common_days
                    k_i=strmatch(common_days(k),dir_dates{ii}(:));
                    k_j=strmatch(common_days(k),dir_dates{jj}(:));

                    c_dir_data{ii}(k)=dir_data{ii}(k_i);
                    c_dir_data{jj}(k)=dir_data{jj}(k_j);
                end
                %and then compute the STE from jj to ii:
         
                TS = [c_dir_data{ii}; c_dir_data{jj}];
                TE = STE(step, TS);
                %STEmatrix (jj,ii) contains the STE from jj to ii
                STEmatrix(jj,ii) = TE;
            end
            
        end
        
    end
end

