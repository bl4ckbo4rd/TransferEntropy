%this function determins the threshold STE (th_STE), within a specified
%interval [lower,upper], at which the ratio of the area bounded by the real
%geometric returns time series STE histogram, the vertical line x=th_STE
%and the x-axis to that bounded by the randomised geometric returns time
%series STE histogram, the vertical line x=th_STE and the x-axis (th_ratio)
%is no more than 0.1

%-----output-----
% th : [th_STE th_ratio no_of_links]

%-----input-----
%       din : diff(last date, end date) + 1
%         w : window length
%         m : number of past days for conditional probabilities
%      step : step size
%     lower : lower bound of th_STE
%     upper : upper bound of th_STE
% criterion : 1 if want to use max area two w_step average AAFT matrix;
%             2 if want to use max area all AAFT matrices;
%             3 if want to use max area twenty-one w_step AAFT matrices;
%             4 if want to use 3 with f(s) instead of f_hard(s);
%      clop : 1 if want to use close price;
%             2 if want to use open price;

function th = extract_links_returns(din,w,w_step,m,step,lower,upper,criterion,clop,STE)
    
    th = [0 0 0];
    th5 = [999 0 0];
    th6 = [999 0 0];
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=3.mat');
        if criterion == 1
            S2 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din+w_step),'_choice=5.mat');
            S3 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=5.mat');
            S4 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din-w_step),'_choice=5.mat');
        elseif ismember(criterion,[3 4])
            if din-10*w_step < 1
                for i = 1:21
                    S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(1+(21-i)*w_step),'_choice=5.mat');
                end
            elseif din+10*w_step > 4000-w+1
                for i = 1:21
                    S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(4000-w+1-(i-1)*w_step),'_choice=5.mat');
                end
            else
                for i = 1:21
                    S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din+(11-i)*w_step),'_choice=5.mat');
                end
            end
        end
    elseif clop == 2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=3.mat');
        if criterion == 1
            S2 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din+w_step),'_choice=5.mat');
            S3 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=5.mat');
            S4 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din-w_step),'_choice=5.mat');
        elseif criterion == 3
            if din-10*w_step < 1
                for i = 1:21
                    S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(1+(21-i)*w_step),'_choice=5.mat');
                end
            elseif din+10*w_step > 4000-w+1
                for i = 1:21
                    S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(4000-w+1-(i-1)*w_step),'_choice=5.mat');
                end
            else
                for i = 1:21
                    S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din+(11-i)*w_step),'_choice=5.mat');
                end
            end
        end
    end
    
    load(S1);
    STE1 = STEM;
    if criterion == 1
        load(S2);
        STE2 = STEM;
        load(S3);
        STE3 = STEM;
        load(S4);
        STE4 = STEM;
        STE5 = (STE2+STE3)/2;
        STE6 = (STE3+STE4)/2;
    elseif ismember(criterion,[3 4])
        STE = [];
        for i = 1:21
            load(S{i});
            STE = [STE STEM];
        end
    end
    
    if criterion == 1
        [~,det5] = max([max(STE1(:)) max(STE5(:))]);
        
        if det5 == 1
            [y1,x5] = hist(nonzeros(STE1(:)),20);
            [y5,x5] = hist(nonzeros(STE5(:)),x5);
        else
            [y5,x5] = hist(nonzeros(STE5(:)),20);
            [y1,x5] = hist(nonzeros(STE1(:)),x5);
        end
        
        crits5 = find(lower<=x5 & x5<=upper);
        area_ratio5 = zeros(1,length(crits5));
        area5_1 = zeros(1,length(crits5));
        
        i = 1;
        for j = crits5
            area5_1_i = sum(y1(j:end));
            area_ratio5(i) = (sum(y5(j:end))/area5_1_i)*(sum(y1)/sum(y5));
            area5_1(i) = area5_1_i;
            i = i + 1;
        end
        
        if min(area_ratio5) <= 0.1
            good_indicies5 = find(area_ratio5 <= 0.1);
            good_area5_1 = area5_1(good_indicies5);
            [cr_area5_1,cr_good5] = max(good_area5_1);
            cr5 = good_indicies5(cr_good5);
            th5(1) = x5(crits5(cr5));
            th5(2) = area_ratio5(cr5);
            th5(3) = cr_area5_1;
        end
        
        LINKS5 = STE1 >= th5(1);
        
        [~,det6] = max([max(STE1(:)) max(STE6(:))]);
        
        if det6 == 1
            [y1,x6] = hist(nonzeros(STE1(:)),20);
            [y6,x6] = hist(nonzeros(STE6(:)),x6);
        else
            [y6,x6] = hist(nonzeros(STE6(:)),20);
            [y1,x6] = hist(nonzeros(STE1(:)),x6);
        end
        
        crits6 = find(lower<=x6 & x6<=upper);
        area_ratio6 = zeros(1,length(crits6));
        area6_1 = zeros(1,length(crits6));
        
        i = 1;
        for j = crits6
            area6_1_i = sum(y1(j:end));
            area_ratio6(i) = (sum(y6(j:end))/area6_1_i)*(sum(y1)/sum(y6));
            area6_1(i) = area6_1_i;
            i = i + 1;
        end
        
        if min(area_ratio6) <= 0.1
            good_indicies6 = find(area_ratio6 <= 0.1);
            good_area6_1 = area6_1(good_indicies6);
            [cr_area6_1,cr_good6] = max(good_area6_1);
            cr6 = good_indicies6(cr_good6);
            th6(1) = x6(crits6(cr6));
            th6(2) = area_ratio6(cr6);
            th6(3) = cr_area6_1;
        end
        
        LINKS6 = STE1 >= th6(1);
        
        LINKS = LINKS5.*LINKS6;
        SIM = (2*LINKS5-1).*(2*LINKS6-1);
        sim = sum(SIM(:))/97^2;
        th = (th5+th6)/2;
        th(1) = sim;
        th(3) = sum(LINKS(:));
    
    elseif ismember(criterion,[2 3])
        [~,det] = max([max(STE1(:)) max(STE(:))]);
        
        if det == 1
            [y1,x] = hist(nonzeros(STE1(:)),20);
            [y,x] = hist(nonzeros(STE(:)),x);
        else
            [y,x] = hist(nonzeros(STE(:)),20);
            [y1,x] = hist(nonzeros(STE1(:)),x);
        end
        
        crits = find(lower<=x & x<=upper);
        area_ratio = zeros(1,length(crits));
        area_1 = zeros(1,length(crits));
        
        i = 1;
        for j = crits
            area_1_i = sum(y1(j:end));
            area_ratio(i) = (sum(y(j:end))/area_1_i)*(sum(y1)/sum(y));
            area_1(i) = area_1_i;
            i = i + 1;
        end
        
        if min(area_ratio) <= 0.1
            good_indicies = find(area_ratio <= 0.1);
            good_area_1 = area_1(good_indicies);
            [cr_area_1,cr_good] = max(good_area_1);
            cr = good_indicies(cr_good);
            th(1) = x(crits(cr));
            th(2) = area_ratio(cr);
            th(3) = cr_area_1;
        end
    
    elseif criterion == 4
        [~,det] = max([max(STE1(:)) max(STE(:))]);
        
        if det == 1
            [y1,x] = hist(nonzeros(STE1(:)),20);
            [y,x] = hist(nonzeros(STE(:)),x);
            first_bin_left_bound = min(nonzeros(STE1(:)));
            last_bin_right_bound = max(nonzeros(STE1(:)));
        else
            [y,x] = hist(nonzeros(STE(:)),20);
            [y1,x] = hist(nonzeros(STE1(:)),x);
            first_bin_left_bound = min(nonzeros(STE(:)));
            last_bin_right_bound = max(nonzeros(STE(:)));
        end
        
        bin_width = x(2) - x(1);
        length_x = length(x);
        
        area_ratio = zeros(1,length_x);
        area_1 = zeros(1,length_x);
        
        for i = 1:length_x
            area_1_i = sum(y1(i:end));
            area_ratio(i) = (sum(y(i:end))/area_1_i)*(sum(y1)/sum(y));
            area_1(i) = area_1_i;
        end
        
        a = 9999;
        fun = exp(-a*(area_ratio-0.1))./(exp(-a*(area_ratio-0.1))+exp(a*(area_ratio-0.1)));
        
        LINKS = zeros(size(STE1));
        for i = 1:length_x
            if i == 1
                target = find(0<STE1 & STE1<=first_bin_left_bound+bin_width);
            elseif i == length_x
                target = find(first_bin_left_bound+(i-1)*bin_width<=STE1 & STE1<=last_bin_right_bound);
            else
                target = find(first_bin_left_bound+(i-1)*bin_width<=STE1 & STE1<=first_bin_left_bound+i*bin_width);
            end
            LINKS(target) = fun(i)*STE1(target);
        end
        th(3) = sum(LINKS(:));
    end
end