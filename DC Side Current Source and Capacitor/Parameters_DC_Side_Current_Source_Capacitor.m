% File Name: Parameters_DC_Side_Current_Source_Capacitor.m
% VSC converter with the DC side modelled as a current source and 
% a capacitor
clear all
close all
clc

% Parameters
tau = 0.001;
taupll = 0.0045;
Kp = 1.36;
Ll = 0.0054;
rl = 0.5;
E2ref = 800^2;
Kpdc = 10;

% Data of reactive power reference
Qref.time = [0; 0.3; 0.3; 0.5; 0.5; 0.8; 0.8; 0.9; 0.9; 1];
Qref.signals.values = [0; 0; 0; 0; -5000; -5000; -5000; -5000; 0; 0];

% Data of Direct Current injected
DC.time = [0; 0.3; 0.3; 0.5; 0.5; 0.8; 0.8; 0.9; 0.9; 1];
DC.signals.values = [3; 3; 10; 10; 5; 5; 7.5; 7.5; 10; 10];

% Simulation and plots of different electric measures
% Simulation time
tsimul = 1;

% sim simulates the Simulink File
sim Simulink_DC_Side_Current_Source_Capacitor

% Plot of reactive power reference and reactive power
figure(1);
plot(Qref.time, Qref.signals.values, t, Qz, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('Reactive power [VAr]', 'FontSize', 14);
legend('Q_z^*', 'Q_z')

% Plot of current q reference and current q
figure(2);
plot(t, iqref, t, iq, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('Current [A]', 'FontSize', 14);
legend('I_q^*', 'I_q')

% Plot of current d reference and current d
figure(3);
plot(t, idref, t, id, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('Current [A]', 'FontSize', 14);
legend('I_d^*', 'I_d')

% Plot of DC bus voltage reference and DC bus voltage
figure(4);
plot(t, Easterisc, t, Emesurat, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('DC bus voltage [V]', 'FontSize', 14);
legend('E^*', 'E')