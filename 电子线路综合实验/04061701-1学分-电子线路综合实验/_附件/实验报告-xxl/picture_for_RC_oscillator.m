% ========== 多谐振荡电路定量波形绘制 ==========
% 测试条件: Vcc = 5V, R1 = R2 = 100kΩ, C = 0.01μF

clear; clc; close all;

% ========== 测试数据（实测值）==========
t1 = 1.393e-3;      % 高电平脉宽 (s) —— 充电时间
t2 = 0.699e-3;      % 低电平脉宽 (s) —— 放电时间
T = t1 + t2;        % 振荡周期 = 2.029ms
f = 1 / T;          % 频率 ≈ 492.9Hz
q = t1 / T;         % 占空比 = 66.6%
Vcc = 5.0;
V_high = 2.23;      % 输出高电平幅值 (V)
V_low = 0;          % 输出低电平幅值 (V)
V_th_high = 2/3 * Vcc;   % 2/3 Vcc ≈ 3.33V
V_th_low = 1/3 * Vcc;    % 1/3 Vcc ≈ 1.67V

% ========== 电路参数 ==========
R1 = 100e3;
R2 = 100e3;
C = 0.01e-6;
tau_charge = (R1 + R2) * C;    % 充电时间常数 ≈ 2ms
tau_discharge = R2 * C;        % 放电时间常数 ≈ 1ms

% ========== 生成时间轴（显示两个完整周期）==========
num_periods = 2;
t_total = num_periods * T;
dt = T / 5000;
t = 0:dt:t_total-dt;

% ========== 生成引脚2（触发端）指数充放电波形 ==========
wave_trigger = zeros(size(t));
for i = 1:length(t)
    phase = mod(t(i), T);
    if phase < t1
        % 充电阶段：从 V_th_low 指数上升至 V_th_high
        V_start = V_th_low;
        V_end = Vcc - (Vcc - V_start) * exp(-phase / tau_charge);
        wave_trigger(i) = V_end;
    else
        % 放电阶段：从 V_th_high 指数下降至 V_th_low
        phase_discharge = phase - t1;
        V_start = V_th_high;
        V_end = V_start * exp(-phase_discharge / tau_discharge);
        wave_trigger(i) = V_end;
    end
end

% ========== 生成引脚3（输出端）矩形波 ==========
wave_out = zeros(size(t));
for i = 1:length(t)
    phase = mod(t(i), T);
    if phase < t1
        wave_out(i) = V_high;
    else
        wave_out(i) = V_low;
    end
end

% ========== 创建图形 ==========
figure('Position', [100, 100, 900, 700]);

% ---------- 子图1：引脚2（触发端）指数充放电波形 ----------
subplot(2, 1, 1);
plot(t, wave_trigger, 'LineWidth', 2, 'Color', 'black');
hold on;
yline(V_th_high, 'black--', 'LineWidth', 0.8);
yline(V_th_low, 'black--', 'LineWidth', 0.8);
text(t1/2, V_th_low + 0.3, '充电', 'HorizontalAlignment', 'center', ...
    'FontSize', 20, 'Color', 'black');
text(t1 + t2/2, V_th_low + 0.3, '放电', 'HorizontalAlignment', 'center', ...
    'FontSize', 20, 'Color', 'black');
text(t_total*0.75, V_th_high*1.1, '2/3 Vcc = 3.33V', 'FontSize', 15, 'Color', 'black');
text(t_total*0.75, V_th_low*1.1, '1/3 Vcc = 1.67V', 'FontSize', 15, 'Color', 'black');
xlim([0, t_total]);
ylim([-0.5, 4.0]);
grid off;
ylabel('引脚2 电压 (V)', 'FontSize', 15);


% ---------- 子图2：引脚3（输出端）矩形波 ----------
subplot(2, 1, 2);
stairs(t, wave_out, 'LineWidth', 2, 'Color', 'black');
hold on;
yline(V_high, 'k--', 'LineWidth', 0.6);
yline(V_low, 'k--', 'LineWidth', 0.6);
text(t1/2, V_high/1.8, sprintf('t_1 = %.3fms', t1*1000), ...
    'HorizontalAlignment', 'center', 'FontSize', 14, 'Color', 'black');
text(t1 + t2/2, 1+V_low, sprintf('t_2 = %.3fms', t2*1000), ...
    'HorizontalAlignment', 'center', 'FontSize', 14, 'Color', 'black');
text(t_total*0.85, V_high*1.05, sprintf('V_o = %.2fV', V_high), ...
    'FontSize', 14, 'Color', 'black');
xlim([0, t_total]);
ylim([-0.5, 4.0]);
grid off;
xlabel('时间 (s)', 'FontSize', 15);
ylabel('引脚3 输出电压 (V)', 'FontSize', 15);



% 调整子图间距
set(gcf, 'Color', 'white');

