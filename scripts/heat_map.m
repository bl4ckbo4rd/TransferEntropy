%This script creates a html file which using the Java library D3.js creates
%an heap map of the matrix in input.
%Given A, with N rows and T columns, we associate a color to each A(i,j)
%ranging from blu to red. Blu correspond to the smallest entries, Red to
%the largest.
%A can contain positive and negative values.

%input: 
%A                   : matrix
%optional parameters : Deltax, Deltay, Radius 
%These parameters correspond to the spacing between dots in the x and y
%directions and to the radius of the dots.


Deltax    = 35;
Deltay    = 35;
Radius    = 7;
size_item = 20;
size_tick = 20;

N=size(A,1);
T=size(A,2);

width  =(1.3*Deltax) * T;
heigth =(2*Deltay) * N;

minimo  = min(min(A));
A = A-minimo;
massimo = max(max(A));
A = A./massimo;

S1='</g><g class="item">';

fileID = fopen('heat_map.html','w');

S_pre = '<html><head>';
fprintf(fileID,'%s\n',S_pre);
S_pre = '<script src="./jquery.min.js"></script><style type="text/css"></style>';
fprintf(fileID,'%s\n',S_pre);
S_pre = '<script src="./scripts.js"></script>';
fprintf(fileID,'%s\n',S_pre);
S_pre = '<style type="text/css">';
fprintf(fileID,'%s\n',S_pre);
S_pre = strcat('body{font-family: Arial, sans-serif;font-size:',num2str(size_tick),'px;}');
fprintf(fileID,'%s\n',S_pre);
S_pre = '.axis path,.axis line {fill: none;stroke:#b6b6b6;shape-rendering: crispEdges;}';
fprintf(fileID,'%s\n',S_pre);
%S_pre = '/*.tick line{fill:none;stroke:none;}*/';
%fprintf(fileID,'%s\n',S_pre);
S_pre = '.tick text{fill:#999;}';
fprintf(fileID,'%s\n',S_pre);
S_pre = 'g.item.active{cursor:pointer;}';
fprintf(fileID,'%s\n',S_pre);
S_pre = strcat('text.label{font-size:',num2str(size_item),'px;font-weight:bold;cursor:pointer;}');
fprintf(fileID,'%s\n',S_pre);
S_pre = 'text.value{font-size:12px;font-weight:bold;}';
fprintf(fileID,'%s\n',S_pre);
S_pre = '</style>';
fprintf(fileID,'%s\n',S_pre);
S_pre = '</head>';
fprintf(fileID,'%s\n',S_pre);
S_pre = '<body marginwidth="0" marginheight="0">';
fprintf(fileID,'%s\n',S_pre);

S_pre = '<script type="text/javascript">';
fprintf(fileID,'%s\n',S_pre);
S_pre = 'function truncate(str, maxLength, suffix) {';
fprintf(fileID,'%s\n',S_pre);
S_pre =	'if(str.length > maxLength) {';
fprintf(fileID,'%s\n',S_pre);
S_pre =	'str = str.substring(0, maxLength + 1);';
fprintf(fileID,'%s\n',S_pre);
S_pre =	'str = str.substring(0, Math.min(str.length, str.lastIndexOf(" ")));';
fprintf(fileID,'%s\n',S_pre);
S_pre =	'str = str + suffix;}';
fprintf(fileID,'%s\n',S_pre);
S_pre =	'return str;}';
fprintf(fileID,'%s\n',S_pre);



dim = strcat('</script><svg width="',num2str(width),'" height="',num2str(heigth),'" style="margin-left: 20px;">');
fprintf(fileID,'\n%s\n',dim);

str = '<g transform="translate(30,30)"><g class="x axis" transform="translate(0,0)">';
%disp(str);
fprintf(fileID,'%s\n',str);

for t=1:T
    tick=strcat('<g class="tick major" transform="translate(',num2str(t*Deltax-Deltax),',0)" style="opacity: 1;"><line y2="-6" x2="0"></line><text y="-9" x="0" dy="0em" style="text-anchor: middle;">',num2str(t),'</text></g>');
    fprintf(fileID,'%s\n',tick);
    %disp(tick)
end

for i=1:N
    
    fprintf(fileID,'\n%s\n',S1);
    %disp(S1)
    for j=1:T
        y=i*Deltay;
        x=j*Deltax-Deltax;
        r=A(i,j);
        if(r<0.5)
            v1 = 0;
            v3 = (-4*(r-0.5)*(r+0.5))^0.3*255;
            %v1=0;
            %v2=2*r*255;
            %v3=(1-2*r)*255;
        else
            v1 = (-4*(r-0.5)*(r-1.5))^0.3*255;
            v3 = 0;
            %v1=(2*r-1)*255;
            %v2=(-2*r+2)*255;
            %v3=0;
        end
        v2=(4*r*(1-r))^2*255;
        
        circle   = strcat('<circle cx="',num2str(x),'" cy="',num2str(y),'" r="',num2str(24*(r-0.5)^2+Radius),'" style="fill: rgb(',num2str(round(v1)),',',num2str(round(v2)),',',num2str(round(v3)),');"></circle>');
        fprintf(fileID,'%s\n',circle);
        %disp(circle)
    end
    %text = strcat('<text y="',num2str(y+5),'" x="',num2str(x+Deltax),'" class="label" style="fill: #3182bd;">','item',num2str(i),'</text>');
    text = strcat('<text y="',num2str(y+5),'" x="',num2str(x+Deltax),'" class="label" style="fill: #3182bd;">',S{ind(i)},'</text>');
    %disp(text)
    fprintf(fileID,'%s\n',text);
    %disp(' ') 
end

fin = '</g></g></svg></body></html>';
fprintf(fileID,'\n%s\n',fin);