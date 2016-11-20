w = 500;
step =5;
m = 2;
a = 100;
r_star = 0.03;
w_step = 25;
clop = 1;

disp(step)

for din =  1:w_step:4000-w+1;
    
    LINKS = extract_links_matrix_prices(din,w,w_step,m,step,a,clop,r_star);
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_prices_din=',num2str(din),'.mat');
    elseif clop ==2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/LINKS_matrices/LINKS_prices_din=',num2str(din),'.mat');
    end
    save(S1,'LINKS');
end

disp('DONE')