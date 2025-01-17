%% MATLAB assignment 2 - Spencer Durrant

%% 1. Download data by Analysis of human behavior recognition algorithms 
% based on acceleration data, Bruno, B. et al., IEEE Int Conf on Robotics 
% and Automation (ICRA)
filePath = "Accelerometer-2011-03-24-10-24-39-climb_stairs-f1.txt";

data = readmatrix(filePath);
g = 9.8;

% Perform transform on each data point, use equation given
% in the assignment details 
realData = -1.5*g + 3*g .* (data/63);

%% 2. Let us combine the three channels into a single one, S = sqrt(x^2 + y^2 + z^2).
% Compute the energy of the signal S.
Sraw = sqrt(sum(data.^2, 2));
S = sqrt(sum(realData.^2, 2));

figure('Position', [100, 100, 1200, 600]);
subplot(2,1,1);
plot(S, 'LineWidth', 1.2);

% Add plot info
title('Energy S - Real')
xlabel('Sample number');
ylabel('Amplitude');
legend('S-real');


subplot(2,1,2);
plot(Sraw, 'LineWidth', 1.2);

% Add plot info
title('Energy S - Raw')
xlabel('Sample number');
ylabel('Amplitude');
legend('S-raw');

%% 3. Implement a moving-average filter my_smoothing_filter, with a sliding window size = 3 to smooth the data.
% For your implementation first define the impulse response of the system and then use convolution (use MATLAB’s conv
% command). Apply this to the signals x, y, z. Plot the input signals and the resulting smoothed signals.
window_size = 3;
impulse = (1/window_size) * [1, 1, 1];
disp("Using impulse response: [1, 1, 1]")

x_smooth_real = conv(realData(:, 1), impulse, 'same');
y_smooth_real = conv(realData(:, 2), impulse, 'same');
z_smooth_real = conv(realData(:, 3), impulse, 'same');

x_smooth_raw = conv(data(:, 1), impulse, 'same');
y_smooth_raw = conv(data(:, 2), impulse, 'same');
z_smooth_raw = conv(data(:, 3), impulse, 'same');



% Plot both
figure('Position', [100, 100, 1200, 600]);
subplot(2,1,1);
plot(x_smooth_real, 'LineWidth', 1.2);
hold on;
plot(y_smooth_real, 'LineWidth', 1.2);
plot(z_smooth_real, 'LineWidth', 1.2);

% Add plot info
title('Moving Average Filter - Real')
xlabel('Sample number');
ylabel('Amplitude');
legend('x-smooth-real', 'y-smooth-real', 'z-smooth-real');

subplot(2,1,2);
plot(x_smooth_raw, 'LineWidth', 1.2);
hold on;
plot(y_smooth_raw, 'LineWidth', 1.2);
plot(z_smooth_raw, 'LineWidth', 1.2);

% Add plot info
title('Moving Average Filter - Raw')
xlabel('Sample number');
ylabel('Amplitude');
legend('x-smooth-raw', 'y-smooth-raw', 'z-smooth-raw');

%% 4. A recursive system is defined by the following difference equation y(n) = 0.8 ∗ y(n − 1) + x(n). 
% Calculate and plot the value of y(n), given x(n) = x, the data signal, and an initially relaxed system. 
x_raw = data(:,1);
x_real = realData(:,1);

% Initialize arrays, relaxed at 0
y_real = zeros(size(x_real));
y_raw = zeros(size(x_raw));

% Start at 2, so n - 1 is valid
for n = 2:length(x_real)
    y_real(n) = 0.8 * y_real(n-1) + x_real(n);
    y_raw(n) = 0.8 * y_raw(n-1) + x_raw(n);
end

% Plot both real and raw
figure('Position', [100, 100, 1200, 600]);
% Real plot
subplot(2,1,1);
plot(y_real, 'LineWidth', 1.2);

% Add plot info
title('Recursive system part 4 - real')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n), real');

% Raw plot
subplot(2,1,2);
plot(y_raw, 'LineWidth', 1.2);

% Add plot info
title('Recursive system part 4 - raw')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n), raw');

%% 5. Calculate and plot the value of y(n) shown below, given x(n) = x, the data signal, and an initially relaxed system. What is this system computing?
% Recursive system is defined: y(n) = (n/(n+1))y(n-1) + (1/(n+1))x(n)

% Initialize arrays, relaxed at 0
y_real = zeros(size(x_real));
y_raw = zeros(size(x_raw));

% Start at 2, so n - 1 is valid
for n = 2:length(x_real)
    y_real(n) = (n/(n+1)) * y_real(n-1) + (1/(n+1)) * x_real(n);
    y_raw(n) = (n/(n+1)) * y_raw(n-1) + (1/(n+1)) * x_raw(n);
end

% Plot both real and raw
figure('Position', [100, 100, 1200, 600]);
% Real plot
subplot(2,1,1);
plot(y_real, 'LineWidth', 1.2);

% Add plot info
title('Recursive system part 5 - real')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n), real');

% Raw plot
subplot(2,1,2);
plot(y_raw, 'LineWidth', 1.2);

% Add plot info
title('Recursive system part 5 - raw')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n), raw');

disp("What is this system computing? The system is computing a dampened or attenuated signal, that may be stabilizing over time.")

%% 6. A recursive system is defined by the following difference equation y(n) = y(n − 1) − y(n − 2) + x(n). 
% Calculate and plot the value of y(n), given x(n) = x, the data signal, and an initially relaxed system. 
% Is this a linear and/or a time-invariant system? Test using input/output signals pairs.

% Initialize arrays, relaxed at 0
y_real = zeros(size(x_real));
y_raw = zeros(size(x_raw));

% Start at 3, so n - 1 and n - 2 is valid
for n = 3:length(x_real)
    y_real(n) = y_real(n - 1) - y_real(n - 2) + x_real(n);
    y_raw(n) = y_raw(n - 1) - y_raw(n - 2) + x_raw(n);
end

% Plot both real and raw
figure('Position', [100, 100, 1200, 600]);
% Real plot
subplot(2,1,1);
plot(y_real, 'LineWidth', 1.2);

% Add plot info
title('Recursive system part 6 - real')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n), real');

% Raw plot
subplot(2,1,2);
plot(y_raw, 'LineWidth', 1.2);

% Add plot info
title('Recursive system part 6 - raw')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n), raw');


% TODO - prove linearity
% The code below applies different inputs and compares the output sums
% y_real = zeros(size(x_real));
% y_raw = zeros(size(x_raw));
% 
% % Start at time shifted value of n = 100
% for n = 100:length(x_real)
%     y_real(n) = y_real(n - 1) - y_real(n - 2) + x_real(n);
%     y_raw(n) = y_raw(n - 1) - y_raw(n - 2) + x_raw(n);
% end
% 
% figure('Position', [100, 100, 1200, 600]);
% % Real plot
% subplot(2,1,1);
% plot(y_real, 'LineWidth', 1.2);
% 
% % Add plot info
% title('Recursive system part 6 Time Shifted - real')
% xlabel('Sample number');
% ylabel('Amplitude');
% legend('y(n), real');
% 
% % Raw plot
% subplot(2,1,2);
% plot(y_raw, 'LineWidth', 1.2);
% 
% % Add plot info
% title('Recursive system part 6 Time Shifted - raw')
% xlabel('Sample number');
% ylabel('Amplitude');
% legend('y(n), raw');

disp("Therefore the system is linear")




% The code below shifts the input signal to simulate a time shifted system
y_real = zeros(size(x_real));
y_raw = zeros(size(x_raw));

t_shift = 97;
y_real = [zeros([t_shift, 1]); y_real];
y_raw = [zeros([t_shift, 1]); y_raw];
x_real = [zeros([t_shift, 1]); x_real];
x_raw = [zeros([t_shift, 1]); x_raw];

% Start at time shifted value of n = 100
for n = t_shift+3:length(x_real)
    y_real(n) = y_real(n - 1) - y_real(n - 2) + x_real(n);
    y_raw(n) = y_raw(n - 1) - y_raw(n - 2) + x_raw(n);
end

figure('Position', [100, 100, 1200, 600]);
% Real plot
subplot(2,1,1);
plot(y_real, 'LineWidth', 1.2);

% Add plot info
title('Recursive system part 6 Time Shifted - real')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n), real');

% Raw plot
subplot(2,1,2);
plot(y_raw, 'LineWidth', 1.2);

% Add plot info
title('Recursive system part 6 Time Shifted - raw')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n), raw');

disp("In the time shifted plots compared to the original, it is clear to see that the output shifts in the same way as the input. Therefore the system is Time-invariant.")


% TODO how to test with I/O signal pairs???

%% 7. Use folding in time and convolution to implement cross-correlation.
% Plot the cross-correlation between the different data signals, i.e. r_xy,
% r_yz, r_xz
x_real = realData(:, 1);
y_real = realData(:, 2);
z_real = realData(:, 3);

x_raw = data(:, 1);
y_raw = data(:, 2);
z_raw = data(:, 3);


r_xy_real = conv(x_real, fliplr(y_real));
r_yz_real = conv(y_real, fliplr(z_real));
r_xz_real = conv(x_real, fliplr(z_real));

figure('Position', [100, 100, 1200, 600]);
plot(-269:269, r_xy_real, 'LineWidth', 1.2);
hold on;
plot(-269:269, r_yz_real, 'LineWidth', 1.2);
plot(-269:269, r_xz_real, 'LineWidth', 1.2);
title('Cross-correlations real')
xlabel('Convoluted Sample number');
ylabel('Amplitude');
legend('r-xy-real', 'r-yz-real', 'r-xz-real');


r_xy_raw = conv(x_raw, fliplr(y_raw));
r_yz_raw = conv(y_raw, fliplr(z_raw));
r_xz_raw = conv(x_raw, fliplr(z_raw));

figure('Position', [100, 100, 1200, 600]);
plot(-269:269, r_xy_raw, 'LineWidth', 1.2);
hold on;
plot(-269:269, r_yz_raw, 'LineWidth', 1.2);
plot(-269:269, r_xz_raw, 'LineWidth', 1.2);
title('Cross-correlations raw')
xlabel('Convoluted Sample number');
ylabel('Amplitude');
legend('r-xy-raw', 'r-yz-raw', 'r-xz-raw');

%% 8. Time-delay estimation in radar
% a) Explain how we can measure the delay D by computing the
% crosscorrelation r_xy(l).
disp("The peak of the cross correlation, r_xy(l), will be the delay where D = l, but it must be properly aligned on the shifted x-axis.")

% b) let x(n) be the 13-point Barker sequence and v(n) be a Gaussian random
% sequence with zero mean and variance = 0.01. Write a program that
% generates the sequence y(n), 0 <= n <= 199 for a = 0.9 and D = 20. Plot
% the signals x(n), y(n), 0 <= n <= 199.
x = [1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1 ,-1, 1];
a = 0.9;
D = 20;

y = zeros(200,1);
variance = 0.01;
sigma = sqrt(variance);

y(D+1:D+length(x)) = a * x;
y_noise = y + sigma * randn(200,1);
figure('Position', [100, 100, 1200, 600]);
subplot(2,1,1);
plot(y_noise, '*-')
title('Radar Signal received, variance = 0.01')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n)');

subplot(2,1,2);
plot(x, '*-')
title('Radar Signal sent')
xlabel('Sample number');
ylabel('Amplitude');
legend('x(n)');


% c) Compute and plot the crosscorrelation r_xy(l), 0 <= l <= 59. Use the
% plot to estimate the value of the delay D.
r_xy = conv(y_noise, fliplr(x));

figure('Position', [100, 100, 1200, 600]);
plot(r_xy(1:60), '*-');
title('Cross-correlation r_{xy}(l), variance = 0.01');
xlabel('Sample number');
ylabel('Amplitude');
legend('r_{xy}(l)');

disp("The delay with gaussian noise with variance of 0.01 is about 33")

% d) Repeat parts b and c for variance = 0.1 and 1

y = zeros(200,1);
variance = 0.1;
sigma = sqrt(variance);

y(D+1:D+length(x)) = a * x;
y_noise = y + sigma * randn(200,1);
figure('Position', [100, 100, 1200, 600]);
plot(y_noise, '*-')
title('Radar Signal received, variance = 0.1')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n)');

r_xy = conv(y_noise, fliplr(x));

figure('Position', [100, 100, 1200, 600]);
plot(r_xy(1:60), '*-');
title('Cross-correlation r_{xy}(l), variance = 0.1');
xlabel('Sample number');
ylabel('Amplitude');
legend('r_{xy}(l)');
disp("The delay with gaussian noise with variance of 0.1 is about 33")


y = zeros(200,1);
variance = 1;
sigma = sqrt(variance);

y(D+1:D+length(x)) = a * x;
y_noise = y + sigma * randn(200,1);
figure('Position', [100, 100, 1200, 600]);
plot(y_noise, '*-')
title('Radar Signal received, variance = 1')
xlabel('Sample number');
ylabel('Amplitude');
legend('y(n)');

r_xy = conv(y_noise, fliplr(x));

figure('Position', [100, 100, 1200, 600]);
plot(r_xy(1:60), '*-');
title('Cross-correlation r_{xy}(l), variance = 1');
xlabel('Sample number');
ylabel('Amplitude');
legend('r_{xy}(l)');

disp("The delay with gaussian noise with variance of 1 is about 33. However, sometimes the cross correlation plot with this much noise will not show an obvious peak.")