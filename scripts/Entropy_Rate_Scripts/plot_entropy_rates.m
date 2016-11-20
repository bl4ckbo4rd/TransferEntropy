%plot the entropy rates for returns

[y1,x1]=hist(nonzeros(h_x_g_return_matrix(:,1)),25);
[y2,x2]=hist(nonzeros(h_x_g_return_matrix(:,2)),25);
[y3,x3]=hist(nonzeros(h_x_a_return_matrix(:,1)),25);
[y4,x4]=hist(nonzeros(h_x_a_return_matrix(:,2)),25);
plot(x1,y1)
hold on
plot(x2,y2,'r')
hold on
plot(x3,y3,'g')
hold on
plot(x4,y4,'k')