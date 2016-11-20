%This function considers the ratio of the area bounded by the real
%prices time series STE histogram, the vertical line x=th_STE and the
%x-axis to that bounded by a benchmark STE histogram from the bracketing
%twenty-one AAFT randomised prices STE matrices, the vertical line x=th_STE
%and the x-axis (th_ratio). With the th_ratio threshold set at r_star, the
%weight of each link is determined by a Fermi-Dirac distribution. The
%results are collected into a LINKS matrix.

function LINKS = extract_links_matrix_prices(din,w,w_step,m,step,a,clop,r_star)

%-----output-----
% LINKS : matrix of the weight of each link

%-----input-----
%    din : diff(last date, end date) + 1
%      w : window length
% w_step : window step
%      m : number of past days for conditional probabilities
%   step : step size
%      a : constant determining the slope of the Fermi-Dirac distribution
%   clop : 1 if want to use close price;
%          2 if want to use open price;
% r_star : "smooth" p-value. r_star=0.03 resuts in taking a p-values
%          between 0.01 and 0.05 by using the smooth Fermi-Dirac
%          distribution

%specify the paths of the required STE matrices
if clop == 1    %use close price
    
    %real STE matrix
    S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=1.mat');
    
    %randomised STE matrices
    if din-10*w_step < 1
        for i = 1:21
            S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(1+(21-i)*w_step),'_choice=2.mat');
        end
    elseif din+10*w_step > 4000-w+1
        for i = 1:21
            S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(4000-w+1-(i-1)*w_step),'_choice=2.mat');
        end
    else
        for i = 1:21
            S{i} = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din+(11-i)*w_step),'_choice=2.mat');
        end
    end
    
elseif clop == 2    %use open price
    
    %real STE matrix
    S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=1.mat');
    
    %randomised STE matrices
    if din-10*w_step < 1
        for i = 1:21
            S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(1+(21-i)*w_step),'_choice=2.mat');
        end
    elseif din+10*w_step > 4000-w+1
        for i = 1:21
            S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(4000-w+1-(i-1)*w_step),'_choice=2.mat');
        end
    else
        for i = 1:21
            S{i} = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din+(11-i)*w_step),'_choice=2.mat');
        end
    end
end

%load the real STE matrix
load(S1);
STE1 = STEM;

%compile the benchmark STE matrix
STE = [];
for i = 1:21
    load(S{i});
    STE = [STE STEM];
end

%compute the histograms of both the real and benchmark STE matrices using
%bins specified by the STE matrix with the larger maximum element
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

bin_width = x(2) - x(1);     %the bin width of the histograms
length_x = length(x);        %the number of bins of the histograms

%compute the area ratio (benchmark to real) for each bin
area_ratio = zeros(1,length_x);
for i = 1:length_x
    area_ratio(i) = (sum(y(i:end))/sum(y1(i:end)))*(sum(y1)/sum(y));
end

%compute the functional value of the Fermi-Dirac distribution for each bin
fun = 1./(exp(2*a*(area_ratio-r_star))+1);

%compute the LINKS matrix
LINKS = zeros(size(STE1));
for i = 1:length_x
    if i == 1
        target = find(0<STE1 & STE1<=first_bin_left_bound+bin_width);
    elseif i == length_x
        target = find(first_bin_left_bound+(length_x-1)*bin_width<=STE1 & STE1<=last_bin_right_bound);
    else
        target = find(first_bin_left_bound+(i-1)*bin_width<=STE1 & STE1<=first_bin_left_bound+i*bin_width);
    end
    LINKS(target) = fun(i);
end