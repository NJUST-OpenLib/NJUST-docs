%%绘制旋转器结果（二极管）
%arg第一列到第四列分别二极管反向接入电路是u1、i1、u2、i2即旋转后的电压电流、旋转前的电压电流
%arg第五列到第八列分别二极管正向接入电路是u3、i3、u4、i4即旋转后的电压电流、旋转前的电压电流
clc;clear;
load data_for_experiment2_diode
%%%使用时请每次选取要绘制的是正向曲线还是反向曲线代码再运行，不要直接运行整个脚本
%%绘制反向伏安曲线
u1=arg(:,1);
i1=arg(:,2);
u2=arg(:,3);
i2=arg(:,4);
figure(1);
plot(u1,i1,"r","LineWidth",1.5);
hold on;
plot(u2,i2,"b","LineWidth",1.5)
xlabel("电压U（V）","FontSize",15,"FontWeight","bold");
ylabel("电流i（A）","FontSize",15,"FontWeight","bold");
text(11,0.001,"旋转后","FontSize",15,"FontWeight","bold","Color","r");
text(2,0.002,"旋转前","FontSize",15,"FontWeight","bold","Color","b");

%%绘制反向伏安曲线
u3=arg(:,5);
i3=arg(:,6);
u4=arg(:,7);
i4=arg(:,8);
figure(3);
plot(u3,i3,"r","LineWidth",1.5);
hold on;
plot(u4,i4,"b","LineWidth",1.5)
xlabel("电压U（V）","FontSize",15,"FontWeight","bold");
ylabel("电流i（A）","FontSize",15,"FontWeight","bold");
text(8,0.005,"旋转后","FontSize",15,"FontWeight","bold","Color","r");
text(2,0.02,"旋转前","FontSize",15,"FontWeight","bold","Color","b");
