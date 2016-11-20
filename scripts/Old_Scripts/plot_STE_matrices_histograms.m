%plot the histograms of n STE matrices

%           A : [STE_matrix_1 ... STE_matrix_n]
%           n : number of STE matrices
% no_of_stock : the number of stocks among which
%               the symbolic transfer entropies were calculated
%         bin : the number of bins for the histograms

function STE_matrices_histograms = plot_STE_matrices_histograms(A,n,no_of_stock,bin)

if n == 1
    STE_matrix_1 = A(:,1:no_of_stock);
    [y1,x1] = hist(nonzeros(STE_matrix_1(:)),bin);
    STE_matrices_histograms = plot(x1,y1/sum(y1));
    
elseif n == 2
    STE_matrix_1 = A(:,1:no_of_stock);
    STE_matrix_2 = A(:,no_of_stock+1:2*no_of_stock);
    [y1,x1] = hist(nonzeros(STE_matrix_1(:)),bin);
    [y2,x2] = hist(nonzeros(STE_matrix_2(:)),bin);
    STE_matrices_histograms = plot(x1,y1/sum(y1),x2,y2/sum(y2));
    
elseif n == 3
    STE_matrix_1 = A(:,1:no_of_stock);
    STE_matrix_2 = A(:,no_of_stock+1:2*no_of_stock);
    STE_matrix_3 = A(:,2*no_of_stock+1:3*no_of_stock);
    [y1,x1] = hist(nonzeros(STE_matrix_1(:)),bin);
    [y2,x2] = hist(nonzeros(STE_matrix_2(:)),bin);
    [y3,x3] = hist(nonzeros(STE_matrix_3(:)),bin);
    STE_matrices_histograms = plot(x1,y1/sum(y1),x2,y2/sum(y2),x3,y3/sum(y3));
    
elseif n == 4
    STE_matrix_1 = A(:,1:no_of_stock);
    STE_matrix_2 = A(:,no_of_stock+1:2*no_of_stock);
    STE_matrix_3 = A(:,2*no_of_stock+1:3*no_of_stock);
    STE_matrix_4 = A(:,3*no_of_stock+1:4*no_of_stock);
    [y1,x1] = hist(nonzeros(STE_matrix_1(:)),bin);
    [y2,x2] = hist(nonzeros(STE_matrix_2(:)),bin);
    [y3,x3] = hist(nonzeros(STE_matrix_3(:)),bin);
    [y4,x4] = hist(nonzeros(STE_matrix_4(:)),bin);
    STE_matrices_histograms = plot(x1,y1/sum(y1),x2,y2/sum(y2),x3,y3/sum(y3),x4,y4/sum(y3));
    
elseif n == 5
    STE_matrix_1 = A(:,1:no_of_stock);
    STE_matrix_2 = A(:,no_of_stock+1:2*no_of_stock);
    STE_matrix_3 = A(:,2*no_of_stock+1:3*no_of_stock);
    STE_matrix_4 = A(:,3*no_of_stock+1:4*no_of_stock);
    STE_matrix_5 = A(:,4*no_of_stock+1:5*no_of_stock);
    [y1,x1] = hist(nonzeros(STE_matrix_1(:)),bin);
    [y2,x2] = hist(nonzeros(STE_matrix_2(:)),bin);
    [y3,x3] = hist(nonzeros(STE_matrix_3(:)),bin);
    [y4,x4] = hist(nonzeros(STE_matrix_4(:)),bin);
    [y5,x5] = hist(nonzeros(STE_matrix_5(:)),bin);
    STE_matrices_histograms = plot(x1,y1/sum(y1),x2,y2/sum(y2),x3,y3/sum(y3),x4,y4/sum(y4),x5,y5/sum(y5));
end