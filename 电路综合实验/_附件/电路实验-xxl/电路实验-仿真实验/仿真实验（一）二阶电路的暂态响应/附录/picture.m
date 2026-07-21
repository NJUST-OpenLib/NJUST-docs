%%二阶电路的暂态响应
%过阻尼
U_0 = 10;    % 初始电压(V)
C = 1.0;     % 电容
L = 3.0;     % 电感
R = 5.0;     % 电阻
delta=R/(2*L);
omega_0=1/sqrt(L*C);
t=0:0.0001:10;
p_1=-delta+sqrt(delta*delta-omega_0*omega_0);
p_2=-delta-sqrt(delta*delta-omega_0*omega_0);
u_C=(U_0/(p_2-p_1))*(p_2*exp(p_1*t)-p_1*exp(p_2*t));
i_L=(U_0/(L*(p_2-p_1)))*(p_2*p_1)*(exp(p_1*t)-exp(p_2*t));
figure(1)
plot(t,u_C,"red","LineWidth",1.5)
hold on;
plot(t,i_L,"blue","LineWidth",1.5)

% 画x、y轴 
x_range = xlim;
y_range = ylim;
line(x_range, [0, 0], "Color", "black", "LineWidth", 1.5, "LineStyle", "-")
line([0, 0], y_range, "Color", "black", "LineWidth", 1.5, "LineStyle", "-")
grid on;
%坐标轴意义
xlabel("时间t", "FontSize", 14, "FontWeight", "bold")
ylabel("电容电压u_C，电感电压i_L", "FontSize", 14, "FontWeight", "bold")
%文本
text(2, 8, "电容电压 u_C", "FontSize", 12, "Color", "red", ...
     "BackgroundColor", "none", "EdgeColor", "none")  
text(0.3, -1, "电感电流 i_L", "FontSize", 12, "Color", "blue", ...
     "BackgroundColor", "none", "EdgeColor", "none")  
set(gca, 'XTick', [], 'YTick', [])

%%临界阻尼
U_0 = 10;    % 初始电压(V)
C = 1.0;     % 电容
L = 6.25;    % 电感
R = 5;     % 电阻
delta=R/(2*L);
t=0:0.0001:10;
p_1=-delta;
p_2=-delta;
u_C=U_0*(1+delta*t).*exp(-delta*t);

figure(2)
plot(t,u_C,"red","LineWidth",1.5)
hold on;

% 画x、y轴 
x_range = xlim;
y_range = ylim;
line(x_range, [0, 0], "Color", "black", "LineWidth", 1.5, "LineStyle", "-")
line([0, 0], y_range, "Color", "black", "LineWidth", 1.5, "LineStyle", "-")
grid on;
%坐标轴意义
xlabel("时间 t", "FontSize", 14, "FontWeight", "bold")
ylabel("电容电压 u_C  ", "FontSize", 14, "FontWeight", "bold")
%文本
text(3, u_C(800)*0.8, "电容电压 u_C", "FontSize", 12, "Color", "red", ...
     "BackgroundColor", "none", "EdgeColor", "none")  
set(gca, 'XTick', [], 'YTick', [])



%%欠阻尼
U_0 = 10;    % 初始电压(V)
C = 0.01;     % 电容(F)
L = 10.0;    % 电感(H)
R = 5;       % 电阻
% 计算特征参数
delta = R/(2*L);
omega_0 = 1/sqrt(L*C);
omega = sqrt(omega_0^2 - delta^2);  
% 计算相位角 β
tg_beta = omega/delta;
beta = atan(tg_beta);
t = 0:0.0001:100;
% 响应计算
u_C = (U_0*omega_0/omega).*exp(-delta*t) .* sin(omega*t + beta);
du_C = (U_0*omega_0/omega).*exp(-delta*t).*(omega.*cos(omega*t + beta) - delta.*sin(omega*t + beta));
i_L = C.*du_C;

% 包络线计算
u_C_envelope = (U_0*omega_0/omega).*exp(-delta*t);      % 电压包络线
i_L_envelope = (U_0*omega_0^2*C/omega).*exp(-delta*t);            % 电流包络线

% 绘图 - 电容电压
figure(3)
plot(t, u_C, "red", "LineWidth", 1.5)
hold on
plot(t, u_C_envelope, "red--", "LineWidth", 1)
plot(t, -u_C_envelope, "red--", "LineWidth", 1)
x_range = xlim;
y_range = ylim;
line(x_range, [0, 0], "Color", "black", "LineWidth", 1.5, "LineStyle", "-")
line([0, 0], y_range, "Color", "black", "LineWidth", 1.5, "LineStyle", "-")
grid on

%坐标轴意义
xlabel("时间 t ", "FontSize", 14, "FontWeight", "bold")
ylabel("电容电压 u_C ", "FontSize", 14, "FontWeight", "bold")

%文本
text(2.5, -u_C(800)*1, "电容电压 u_C", "FontSize", 12, "Color", "red", ...
     "BackgroundColor", "none", "EdgeColor", "none")  
text(2.5, u_C_envelope(2500)*0.8, "包络线", "FontSize", 10, "Color", [1 0.5 0.5], ...
     "BackgroundColor", "none", "EdgeColor", "none")
xlim([0, 5])
set(gca, 'XTick', [], 'YTick', [])

% 绘图 - 电感电流
figure(4)
plot(t, i_L, "blue", "LineWidth", 1.5)
hold on
plot(t, i_L_envelope, "blue--", "LineWidth", 1)
plot(t, -i_L_envelope, "blue--", "LineWidth", 1)
x_range = xlim;
y_range = ylim;
line(x_range, [0, 0], "Color", "black", "LineWidth", 1.5, "LineStyle", "-")
line([0, 0], y_range, "Color", "black", "LineWidth", 1.5, "LineStyle", "-")
grid on

%坐标轴意义
xlabel("时间 t ", "FontSize", 14, "FontWeight", "bold")
ylabel("电感电流 i_L ", "FontSize", 14, "FontWeight", "bold")

%文本
text(2.5, i_L(2500)*1, "电感电流 i_L", "FontSize", 12, "Color", "blue", ...
     "BackgroundColor", "none", "EdgeColor", "none")
text(2.5, 0.25, "包络线", "FontSize", 10, "Color", [0.5 0.5 1], ...
     "BackgroundColor", "none", "EdgeColor", "none")

xlim([0, 5])
set(gca, 'XTick', [], 'YTick', [])




