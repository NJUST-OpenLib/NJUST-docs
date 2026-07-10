%%绘制串联谐振电路的通用曲线
%arg的第一二列代表C=0.022μF测量的数据
%arg的第三四列代表C=0.047μF测量的数据
%arg的第五六列代表C=1.000μF测量的数据
%xi为η，yi为相对抑制比
clc,clear;
load data_for_experiment3.mat
x1=arg(:,1);
y1=arg(:,2);
x2=arg(:,3);
y2=arg(:,4);
x3=arg(:,5);
y3=arg(:,6);
%绘图
figure(1);
plot(x1,y1,"r","LineWidth",1.5)
hold on;
plot(x2,y2,"b","LineWidth",1.5);
hold on;
plot(x3,y3,"g","LineWidth",1.5);
hold on;
plot([0,5],[0.707,0.707],"k--","LineWidth",1.5)
%限制x，y轴范围
xlim([0,5]);
ylim([0,1.2]);
%文本标注
text(0.12,0.5,"C=1μF",'FontSize', 11, 'FontWeight', 'bold', 'Color', 'g')
text(1.6,0.15,"C=0.047μF",'FontSize', 11, 'FontWeight', 'bold', 'Color', 'b')
text(0.70,0.05,"C=0.022μF",'FontSize', 11, 'FontWeight', 'bold', 'Color', 'r')
text(0,0.75,"y=0.707",'FontSize', 11, 'FontWeight', 'bold', 'Color', 'k')