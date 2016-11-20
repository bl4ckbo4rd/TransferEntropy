w = 500;
step = 50;
criterion = 2;
m = 2;
w_step = 25;
lower = 0.01;
upper = 10;
clop = 1;

disp(step)

if ismember(criterion,[1 3])
    STE = 0;
elseif criterion == 2
    STE = [];
    for din = 1:w_step:4000-w+1
        load(strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=2.mat'));
        STE = [STE STEM];
    end
end

for din =  1+w_step:w_step:4000-w+1-w_step;
    
    LINKS = extract_links_matrix_prices(din,w,w_step,m,step,lower,upper,criterion,clop,STE);
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/criterion=',num2str(criterion),'/LINKS_prices_din=',num2str(din),'.mat');
    elseif clop ==2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/criterion=',num2str(criterion),'/LINKS_prices_din=',num2str(din),'.mat');
    end
    save(S1,'LINKS');
end