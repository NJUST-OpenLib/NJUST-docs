%%绘制旋转器结果（电阻）
%arg第一列到第四列分别是u1、i1、u2、i2即旋转后的电压电流、旋转前的电压电流
clc;clear;
load data_for_experiment2_resistor
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
text(5,0.01,"旋转前","FontSize",15,"FontWeight","bold","Color","b");
text(5,0.002,"旋转后","FontSize",15,"FontWeight","bold","Color","r");

