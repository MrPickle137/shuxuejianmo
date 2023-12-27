%问题一代码：

% 输入数据
t = [0, 1, 2, 3, 4, 5, 6, 8, 12]; % 时间
c = [19.21, 12.87, 8.64, 5.81, 3.89, 2.60, 1.74, 0.58, 0.10]; % 血药浓度

% 线性最小二乘拟合
p = polyfit(t, log(c), 1); % 拟合得到斜率和截距
k = -p(1); % 斜率即为 k 的估计值

% 计算血药浓度随时间的解析表达式
c0 = c(1); % 初始血药浓度
C = @(t) c0 * exp(-k * t); % 血药浓度随时间的解析表达式

% 计算任意时刻 t 的血药浓度
t_new = 0:0.1:12; % 设定新的时间范围
c_new = C(t_new); % 计算血药浓度

% 绘制血药浓度随时间的曲线图
figure
plot(t, c, 'o', t_new, c_new)
xlabel('时间 (h)')
ylabel('血药浓度 (ug/ml)')
legend('实际数据', '拟合曲线')



%问题二代码：

clc,clear
% 读入数据
data = [10.2 19.3 21.4 17.7 16.4 13.8 9.8 7.4 5.3 3.7];
t = [1 2 3 4 5 6 8 10 12 15];
% 第一种给药方式拟合
params1 = [1, 1, 0.5]; % 初始参数估计值
params_fit1 = fminsearch(@(params) fit_func1(params, t, data), params1);
d1 = params_fit1(1);
v1 = params_fit1(2);
k1_fit = params_fit1(3);
% 第二种给药方式拟合
params2 = [1, 1, 0.5]; % 初始参数估计值
params_fit2 = fminsearch(@(params) fit_func2(params, t, data), params2);
d2 = params_fit2(1);
v2 = params_fit2(2);
k0_fit = params_fit2(3);
% 输出参数估计值
fprintf('第一种给药方式：\n');
fprintf('d = %f\n', d1);
fprintf('v = %f\n', v1);
fprintf('k1 = %f\n', k1_fit);
fprintf('\n第二种给药方式：\n');
fprintf('d = %f\n', d2);
fprintf('v = %f\n', v2);
fprintf('k0 = %f\n', k0_fit);
% 绘制拟合曲线
figure;
subplot(2,1,1);
plot(t, data, 'ro', t, model_func1(t, d1, v1, k1_fit), 'b-');
xlabel('时间（小时）');
ylabel('血药浓度');
title('第一种给药方式拟合结果');
legend('实际值', '拟合曲线');
subplot(2,1,2);
plot(t, data, 'ro', t, model_func2(t, d2, v2, k0_fit), 'b-');
xlabel('时间（小时）');
ylabel('血药浓度');
title('第二种给药方式拟合结果');
legend('实际值', '拟合曲线');
% 定义模型函数
function c = model_func1(t, d, v, k1)
c = (d/v) * (1 - exp(-k1*t));
end
function c = model_func2(t, d, v, k0)
c = (d/v) * exp(-k0*t);
end
% 定义目标函数（最小二乘法拟合）
function sse = fit_func1(params, t, data)
d = params(1);
v = params(2);
k1 = params(3);
c_pred = model_func1(t, d, v, k1);
sse = sum((c_pred - data).^2);
end
function sse = fit_func2(params, t, data)
d = params(1);
v = params(2);
k0 = params(3);
c_pred = model_func2(t, d, v, k0);
sse = sum((c_pred - data).^2);
end；