%this function plots the heat_map of the directionality measure
%by using imagesc and moreover it calls the script heap_map to produce the
%same plot by using the D3.js library. 
%In this second case, we group together groups of 3 consecutive windows,
%resulting in ~45 effective windows from the initial ~140. 
%in both the cases, stock are ordered from the top, meaning that most
%influencial one are on top and less influencial ones are below.

function DIRECTION_matrix_steply_returns(w,w_step,m,step,clop)
    
din_members = 1+w_step:w_step:4000-w+1-w_step;
DIRECTION = zeros(97,length(din_members));

i = 1;
for din = din_members
    
    if clop == 1
        S1 = strcat('../STE_matrices/close/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=6.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/DIRECTION_time_matrices/w=',num2str(w),'_step=',num2str(step),'_DIR_steply_returns.mat');
    elseif clop ==2
        S1 = strcat('../STE_matrices/open/m=',num2str(m),'/w=',num2str(w),'_step=',num2str(step),'/STE_din=',num2str(din),'_choice=6.mat');
        S2 = strcat('../STE_matrices/close/m=',num2str(m),'/DIRECTION_time_matrices/w=',num2str(w),'_step=',num2str(step),'_DIR_steply_returns.mat');
    end
    
    load(S1);
    STEM = STEM;
    
    out = sum(STEM,2);
    in = sum(STEM,1)';
    d = out - in;
    
    DIRECTION(:,i) = d;
    
    i = i + 1;
end

DIRECTION = fliplr(DIRECTION);

[val,ind]=sort(sum(DIRECTION,2),'descend');

S{1}  = 'AAL';
S{2}  = 'ABF';
S{3}  = 'ADM';
S{4}  = 'ADN';
S{5}  = 'AGK';
S{6}  = 'AHT';
S{7}  = 'ANTO';
S{8}  = 'ARM';
S{9}  = 'AV';
S{10} = 'AZN';
S{11} = 'BA';
S{12} = 'BAB';
S{13} = 'BARC';
S{14} = 'BATS';
S{15} = 'BDEV';
S{16} = 'BG';
S{17} = 'BLND';
S{18} = 'BLT';
S{19} = 'BNZL';
S{20} = 'BP';
S{21} = 'BRBY';
S{22} = 'BT-A';
S{23} = 'CCH';
S{24} = 'CCL';
S{25} = 'CNA';
S{26} = 'CPG';
S{27} = 'CPI';
S{28} = 'CRH';
S{29} = 'DC';
S{30} = 'DGE';
S{31} = 'DLG';
S{32} = 'EXPN';
S{33} = 'EZJ';
S{34} = 'FRES';
S{35} = 'GFS';
S{36} = 'GKN';
S{37} = 'GLEN';
S{38} = 'GSK';
S{39} = 'HIK';
S{40} = 'HL';
S{41} = 'HMSO';
S{42} = 'HSBA';
S{43} = 'IAG';
S{44} = 'IHG';
S{45} = 'III';
S{46} = 'IMT';
S{47} = 'INTU';
S{48} = 'ITRK';
S{49} = 'ITV';
S{50} = 'JMAT';
S{51} = 'KGF';
S{52} = 'LAND';
S{53} = 'LGEN';
S{54} = 'LLOY';
S{55} = 'LSE';
S{56} = 'MERL';
S{57} = 'MGGT';
S{58} = 'MKS';
S{59} = 'MNDI';
S{60} = 'MRW';
S{61} = 'NG';
S{62} = 'NXT';
S{63} = 'OML';
S{64} = 'PRU';
S{65} = 'PSN';
S{66} = 'PSON';
S{67} = 'RB';
S{68} = 'RBS';
S{69} = 'RDSA';
S{70} = 'RDSB';
S{71} = 'REL';
S{72} = 'RIO';
S{73} = 'RMG';
S{74} = 'RR';
S{75} = 'RRS';
S{76} = 'RSA';
S{77} = 'SAB';
S{78} = 'SBRY';
S{79} = 'SGE';
S{80} = 'SKY';
S{81} = 'SL';
S{82} = 'SMIN';
S{83} = 'SN';
S{84} = 'SPD';
S{85} = 'SSE';
S{86} = 'STAN';
S{87} = 'STJ';
S{88} = 'SVT';
S{89} = 'TSCO';
S{90} = 'TW';
S{91} = 'ULVR';
S{92} = 'UU';
S{93} = 'VOD';
S{94} = 'WEIR';
S{95} = 'WOS';
S{96} = 'WPP';
S{97} = 'WTB';


imagesc(DIRECTION(ind,:))
ind(1)
ind(2)
ind(3)
ind(4)
ind(5)
ind(6)

A = DIRECTION;

for j=1:46
    k=3*j-1;
    B(:,j)=(A(:,k-1)+A(:,k)+A(:,k+1))/3;
end

A = B(ind,:);

heat_map;
%firstDays = datenum(2001:2014, 3, ones(1, 14));
%set(gca, 'XTick', firstDays);
%datetick('x','m/yy','keepticks')
%xlim([t(1) t(end)])

%save(S2,'DIRECTION');