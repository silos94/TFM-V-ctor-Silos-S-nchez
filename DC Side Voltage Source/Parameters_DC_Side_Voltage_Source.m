% File Name: Parameters_DC_Side_Voltage_Source.m
% VSC converter with the DC side modelled as a voltage source 
clear all
close all
clc

% Parameters
tau = 0.01;
taupll = 0.0045;
Ll = 0.0054;
rl = 0.5;
Kp = 1.36;

% Data of reactive power reference
Qref.time = [0; 0.3; 0.3; 0.5; 0.5; 0.8; 0.8; 0.9; 0.9; 1];
Qref.signals.values = [0; 0; -5000; -5000; 0; 0; 2000; 2000; -7000; -7000];

% Data of active power reference
Pref.time = [0; 0.3; 0.3; 0.5; 0.5; 0.8; 0.8; 0.9; 0.9; 1];
Pref.signals.values = [-3000; -3000; -6000; -6000; -1000; -1000; -7000;
-7000; -7000; -7000];

% Simulation and plots of different electric measures
% Simulation time
tsimul = 1;

% sim simulates the Simulink File
sim Simulink_DC_Side_Voltage_Source

% Plot of reactive power reference and reactive power
figure(1);
plot(Qref.time, Qref.signals.values, t, Qz, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('Reactive power [var]', 'FontSize', 14);
legend('Q_z^*', 'Q_z');

% Plot of active power reference and active power
figure(2);
plot(Pref.time, Pref.signals.values, t, Pz, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('Active power [W]', 'FontSize', 14);
legend('P_z^*', 'P_z');

% Plot of current q reference and current q
figure(3);
plot(t, iqref, t, iq, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('Current [A]', 'FontSize', 14);
legend('I_q^*', 'I_q');

% Plot of current d reference and current d
figure(4);
plot(t, idref, t, id, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('Current [A]', 'FontSize', 14);
legend('I_d^*', 'I_d');

% Plot of the tracking of the PLL
figure(5);
subplot(2,1,1);
plot(t, wreal, t, wpll, 'LineWidth', 2);
grid on;
xlim([0 0.1]);
xlabel('Time [s]', 'FontSize', 14);
ylabel('Angular velocity [rad/s]', 'FontSize', 10);
legend('w_r_e_a_l', 'w_P_L_L');

% Plot of the PLL error
subplot(2,1,2);
plot(t, error, 'LineWidth', 2);
grid on;
xlim([0 0.1]);
xlabel('Time [s]', 'FontSize', 14);
ylabel('PLL \theta error [rad]', 'FontSize', 10);