%% 旋转器伏安特性曲线旋转演示 - 第一象限开口向上抛物线
clear; clc; close all;
% 设置图形参数
figure(1);
hold on;
% 创建第一象限的开口向上抛物线（起点在原点）模拟非线性伏安特性
V = linspace(0, 5, 200);  % 第一象限电压范围，从0开始
% 使用二次函数创建开口向上的抛物线
I = 0.1 * V.^2 + 0.5 * V;  % 开口向上的抛物线
% 选择参考点P (在曲线较远位置)
p_index = 180;  % 选择曲线上较远的点
V_p = V(p_index);
I_p = I(p_index);
% 旋转角度 (逆时针为正，0度在x轴正半轴)
theta = 30;  % 30度旋转
theta_rad = deg2rad(theta);
% 旋转矩阵 (标准2D旋转矩阵)
R = [cos(theta_rad), -sin(theta_rad);
     sin(theta_rad),  cos(theta_rad)];
% 对整个曲线进行旋转
points = [V; I];
rotated_points = R * points;
V_rotated = rotated_points(1, :);
I_rotated = rotated_points(2, :);
% 旋转参考点P到P'
P_rotated = R * [V_p; I_p];
V_p_rotated = P_rotated(1);
I_p_rotated = P_rotated(2);
% 绘制原始曲线 (曲线A) - 蓝色
plot(V, I, 'b-', 'LineWidth', 2.5, 'DisplayName', '原始曲线');
% 在曲线标记A
text(V(1), I(1), 'A', 'FontSize', 16, 'FontWeight', 'bold', 'Color', 'b');
text(V(end), I(end), 'A', 'FontSize', 16, 'FontWeight', 'bold', 'Color', 'b');
% 绘制旋转后的曲线 (曲线B) - 红色
plot(V_rotated, I_rotated, 'r-', 'LineWidth', 2.5, 'DisplayName', '旋转后曲线');
% 在曲线标记B
text(V_rotated(1), I_rotated(1), 'B', 'FontSize', 16, 'FontWeight', 'bold', 'Color', 'r');
text(V_rotated(end), I_rotated(end), 'B', 'FontSize', 16, 'FontWeight', 'bold', 'Color', 'r');
% 标记原点O
plot(0, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k', 'HandleVisibility', 'off');
text(-0.3, -0.3, 'O', 'FontSize', 18, 'FontWeight', 'bold');
% 标记点P和P'
plot(V_p, I_p, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b', 'HandleVisibility', 'off');
text(V_p + 0.3, I_p + 0.2, 'P(u,i)', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'b');
plot(V_p_rotated, I_p_rotated, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'HandleVisibility', 'off');
text(V_p_rotated + 0.3, I_p_rotated + 0.2, 'P''(u_1,i_1)', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'r');
% 绘制OP和OP'连线
plot([0, V_p], [0, I_p], 'b--', 'LineWidth', 2, 'HandleVisibility', 'off');
plot([0, V_p_rotated], [0, I_p_rotated], 'r--', 'LineWidth', 2, 'HandleVisibility', 'off');

% 设置坐标轴标签
xlabel('电压 u ', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('电流 i ', 'FontSize', 16, 'FontWeight', 'bold');
% 移除坐标轴数值
set(gca, 'XTick', []);
set(gca, 'YTick', []);

%% 理想电阻伏安特性曲线
clear; clc; close all;
% 参数设置
R = 1000;       % 电阻值 1kΩ
% 电压范围
V = linspace(0, 5, 1000);
% 计算电流 (欧姆定律)
I_resistor = V / R;
% 绘制理想电阻伏安特性
figure(2);
plot(V, I_resistor*1000, 'b', 'LineWidth', 1.5);
xlabel('电压 V ', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('电流 I ', 'FontSize', 14, 'FontWeight', 'bold');
% 设置坐标轴
xlim([0, 5]);
ylim([0, 6]);
% 移除坐标轴数值
set(gca, 'XTick', []);
set(gca, 'YTick', []);
%% 齐纳二极管伏安特性曲线（正反向指数增长）
clear; clc; close all;

% 参数设置
Is = 1e-12;     % 反向饱和电流 (A)
n = 1.0;        % 理想二极管发射系数 n=1
Vt = 0.026;     % 热电压 (V)
V_breakdown = -5; % 齐纳击穿电压 -5V

% 电压范围
V_forward = linspace(0, 6, 500);    % 正向电压
V_reverse_normal = linspace(-4.9, 0, 300); % 正常反向偏置
V_breakdown_region = linspace(-5.5, -5.0, 200); % 击穿区域

% 计算电流
% 正向特性
I_forward = Is * (exp(V_forward/(n*Vt)) - 1);

% 正常反向特性
I_reverse_normal = Is * (exp(V_reverse_normal/(n*Vt)) - 1);

% 击穿区域特性（指数增长）
I_breakdown = -Is * (exp(-(V_breakdown_region - V_breakdown)/(0.1*Vt)) - 1);

% 合并数据
V = [V_breakdown_region, V_reverse_normal, V_forward];
I = [I_breakdown, I_reverse_normal, I_forward];

% 绘制齐纳二极管伏安特性
figure(3);
plot(V, I, 'b', 'LineWidth', 1.5);
xlabel('电压 V ', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('电流 I ', 'FontSize', 14, 'FontWeight', 'bold');
hold on;
%绘制横纵轴
plot([-10,10],[0,0],"Color","black","LineWidth",1);
hold on;
plot([0,0],[-10,10],"Color","black","LineWidth",1);
xlim([-6, 6]);
ylim([-0.1,0.1]);
text(-0.5,0.005,"O");
% 移除坐标轴数值
set(gca, 'XTick', []);
set(gca, 'YTick', []);
