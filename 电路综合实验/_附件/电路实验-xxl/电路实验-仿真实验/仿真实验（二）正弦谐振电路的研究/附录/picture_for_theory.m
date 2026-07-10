% RLC串联谐振电路谐振曲线绘制
%% 电路参数设置
R = 10;          % 电阻 (Ω)
L = 2e-5;         % 电感 (H)  
C = 1e-7;        % 电容 (F)
Us = 1;         % 电源电压有效值 (V)

% 频率范围设置
f0 = 1/(2*pi*sqrt(L*C));      % 谐振频率 (Hz)
f_min = 0.1*f0;              % 最小频率
f_max = 3*f0;                % 最大频率
f = linspace(f_min, f_max, 1000);  % 频率点
w = 2*pi*f;                  % 角频率

%% 计算谐振频率和品质因数
w0 = 2*pi*f0;                 % 谐振角频率 (rad/s)
Q = (1/R)*sqrt(L/C);          % 品质因数
I0 = Us/R;                    % 谐振电流 (A)
UL0 = Q*Us;                   % 谐振时电感电压 (V)
UC0 = Q*Us;                   % 谐振时电容电压 (V)

%% 计算电路响应
% 计算阻抗
Z = R + 1j*(w*L - 1./(w*C));
Z_mag = abs(Z);              % 阻抗模值

% 计算电流
I = Us ./ Z_mag;             % 电流有效值

% 计算各元件电压
UR = I * R;                  % 电阻电压
UL = I .* (w*L);             % 电感电压
UC = I .* (1./(w*C));        % 电容电压

% 找到各曲线的最大值点
[I_max, I_idx] = max(I);
[UL_max, UL_idx] = max(UL);
[UC_max, UC_idx] = max(UC);

% 找到UL和UC相交的点（在谐振频率附近）
[~, intersect_idx] = min(abs(UL - UC));
f_intersect = f(intersect_idx);

%% 计算UL和UC最大值对应的频率
% UL最大值对应的频率f_L
f_L = f(UL_idx);
% UC最大值对应的频率f_C  
f_C = f(UC_idx);

%% 绘制谐振曲线
figure('Position', [100, 100, 1200, 800]);
set(gcf, 'Color', 'white');

% 绘制三条曲线
h1 = plot(f, I, 'b-', 'LineWidth', 2);
hold on;
h2 = plot(f, UL, 'r-', 'LineWidth', 2);
h3 = plot(f, UC, 'g-', 'LineWidth', 2);

% 绘制UL和UC的交线（在谐振频率处）
plot([f0, f0], [0, UL0], 'k--', 'LineWidth', 1.5, 'HandleVisibility', 'off');

% 绘制三条平行于y轴的直线（垂直参考线）
plot([f_C, f_C], [0, UC_max], 'm--', 'LineWidth', 1.5, 'HandleVisibility', 'off');
plot([f0, f0], [0, I_max], 'm--', 'LineWidth', 1.5, 'HandleVisibility', 'off'); 
plot([f_L, f_L], [0, UL_max], 'm--', 'LineWidth', 1.5, 'HandleVisibility', 'off');

% 绘制三条平行于x轴的直线（水平参考线）
plot([f_min, f_max], [UL_max, UL_max], 'm--', 'LineWidth', 1.5, 'HandleVisibility', 'off');
plot([f_min, f_max], [UL0, UL0], 'm--', 'LineWidth', 1.5, 'HandleVisibility', 'off');
plot([f_min, f_max], [Us, Us], 'm--', 'LineWidth', 1.5, 'HandleVisibility', 'off');

% 绘制U_L和U_C曲线的渐近线y=U_S
plot([f_min, f_max], [Us, Us], 'k--', 'LineWidth', 1.5, 'HandleVisibility', 'off');

% 在曲线旁边添加文本框注释
text(f(end)*0.4, I(end)*6, '电流 I', 'Color', 'b', 'FontSize', 12, 'FontWeight', 'bold');
text(f(UL_idx)*2, UL_max*0.8, '电感电压 U_L', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');
text(f(UC_idx)*0.2, UC_max*0.8, '电容电压 U_C', 'Color', 'g', 'FontSize', 12, 'FontWeight', 'bold');

% 添加x轴坐标标注（三条垂直参考线对应的频率）
text(f_C, -max([UL_max, UC_max])*0.05, 'f_C', 'HorizontalAlignment', 'center', 'FontSize', 11, 'FontWeight', 'bold', 'Color', 'm');
text(f0, -max([UL_max, UC_max])*0.05, 'f_0', 'HorizontalAlignment', 'center', 'FontSize', 11, 'FontWeight', 'bold', 'Color', 'm');
text(f_L, -max([UL_max, UC_max])*0.05, 'f_L', 'HorizontalAlignment', 'center', 'FontSize', 11, 'FontWeight', 'bold', 'Color', 'm');

% 添加y轴坐标标注（三条水平参考线对应的电压）
text(f_min*0.9, UL_max, 'U_{Lmax}与U_{Cmax}', 'HorizontalAlignment', 'right', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'm');
text(f_min*0.9, UL0, 'Q_U', 'HorizontalAlignment', 'right', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'm');
text(f_min*0.9, Us, 'U_s', 'HorizontalAlignment', 'right', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'm');


% 设置图形属性
xlabel('频率 f ', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('电流 I ，电压 U ', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 11);

% 设置坐标轴范围以便更好地显示参考线
xlim([f_min, f_max]);
ylim([0, max([UL_max, UC_max])*1.1]);

% 隐藏坐标轴数字
set(gca, 'XTick', []);
set(gca, 'YTick', []);





% RLC串联谐振电路通用谐振曲线绘制
% 使用相对频率 eta = w/w0 和相对电流 I/I0

%% 参数设置
Q_values = [0.5, 1, 2, 5, 10];  % 不同品质因数Q值

%% 频率范围设置 (相对频率)
eta_min = 0.1;                  % 最小相对频率
eta_max = 3.0;                  % 最大相对频率
eta = linspace(eta_min, eta_max, 1000);  % 相对频率点

%% 计算通用谐振曲线
figure('Position', [100, 100, 1000, 700]);
set(gcf, 'Color', 'white');

% 为不同Q值绘制曲线
colors = ['b', 'r', 'g', 'm', 'k'];  % 颜色数组
line_styles = {'-', '--', ':', '-.', '-'};  % 线型

for i = 1:length(Q_values)
    Q = Q_values(i);
    
    % 使用通用谐振方程计算相对电流
    % 公式: I/I0 = 1/sqrt(1 + Q^2*(eta - 1/eta)^2)
    I_relative = 1 ./ sqrt(1 + Q^2 * (eta - 1./eta).^2);
    
    % 绘制曲线
    plot(eta, I_relative, 'Color', colors(i), 'LineStyle', line_styles{i}, ...
         'LineWidth', 2);
    hold on;
    
    % 在曲线上标注Q值
    if Q == 0.5
        text(0.45, 0.9, 'Q=0.5', 'Color', colors(i), 'FontSize', 12, 'FontWeight', 'bold');
    elseif Q == 1
        text(0.65, 0.85, 'Q=1', 'Color', colors(i), 'FontSize', 12, 'FontWeight', 'bold');
    elseif Q == 2
        text(0.70, 0.75, 'Q=2', 'Color', colors(i), 'FontSize', 12, 'FontWeight', 'bold');
    elseif Q == 5
        text(1.2, 0.5, 'Q=5', 'Color', colors(i), 'FontSize', 12, 'FontWeight', 'bold');
    elseif Q == 10
        text(1.1, 0.3, 'Q=10', 'Color', colors(i), 'FontSize', 12, 'FontWeight', 'bold');
    end
end

%% 添加标注和参考线
% 添加谐振点参考线
plot([1, 1], [0, 1], 'k--', 'LineWidth', 1.5);
text(1.05, 0.05, '\eta=1', 'FontSize', 12, 'FontWeight', 'bold');

% 添加y=0.707参考线
I_3dB = 1/sqrt(2); 
plot([eta_min, eta_max], [I_3dB, I_3dB], 'r--', 'LineWidth', 2);
text(eta_max*0, I_3dB, '0.707', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold', ...
     'HorizontalAlignment', 'right');

% 添加坐标轴标签（使用普通文本避免LaTeX语法问题）
text(eta_max/2, -0.01, '相对频率 \eta = \omega/\omega_0', ...
     'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold');
text(0, 0.5, '相对电流 I/I_0', 'Rotation', 90, ...
     'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold');


%% 设置图形属性
grid on;
set(gca, 'FontSize', 12);

% 设置坐标轴范围
xlim([eta_min, eta_max]);
ylim([0, 1.1]);

% 隐藏坐标轴数字和边框
set(gca, 'XTick', []);
set(gca, 'YTick', []);
box off;

