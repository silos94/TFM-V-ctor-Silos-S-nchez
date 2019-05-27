% File Name: Parameters_multiterminal_HVDC_grid.m
% Simulation of a multi-terminal HVDC grid
clear all
close all
clc

% Parameters
tau = 0.001;
taupll = 0.0045;
Kp = 0.0017;
rl = 3.072;
Ll = 0.1956;
E2ref = 640000;
Vdc = 640000;
Uab = 320000;
r1 = 0.1265;
r2 = 0.1504;
r3 = 0.0178;
c = 0.1616*(10^-6);
l1 = 0.2644*(10^-3);
l2 = 7.2865*(10^-3);
l3 = 3.6198*(10^-3);
g = 0.1015*(10^-6);
Rg = (1/g);
Cconv = 1.5*(10^-4);
d1 = 230;
d2 = 75;
d3 = 217;
Qref = 0;
Pinj = 500*(10^6);

% Profile current injected
Iinj.time = [0; 1; 1; 2]; 
Iinj.signals.values = [0; 0; Pinj/Vdc; Pinj/Vdc];
figure(100);
plot(Iinj.time, Iinj.signals.values, 'LineWidth', 2);
grid on;
xlabel('Time [s]', 'FontSize', 14);
ylabel('Current injected [A]', 'FontSize', 14);

% Limit values
vdcrefmax = (((5/100)*Vdc) + Vdc)/1000;
iqrefmax = 1340;
iabcrefmax = 1340;
iabcrefmax1 = -1340;
idrefmax = 0;
idcrefmax = 820;
vlrefmax = round(((5/100)*(((Uab/sqrt(3))*sqrt(2))/1000))+(((Uab/sqrt(3))*sqrt(2))/1000));
vlrefmax1 = -(round(((5/100)*(((Uab/sqrt(3))*sqrt(2))/1000))+(((Uab/sqrt(3))*sqrt(2))/1000)));
vlqrefmax = 274;

% Simulations: Kpdc changes
tsimul = 2;
n = 0; % Simulation counter
for Kpdc = [55000 : 9500 : 150000]
    n = n + 1;
    
    % List of colors to plot (One color for each simulation)
    C = { [0.8500, 0.3250, 0.0980], 'b', [0.4 0.3 0.2], 'r', [0.7 0.7 0.7], 'g', 'y', 'c', 'm', 'k', [0.5 0.1 1]};
    
    % It simulates the Simulink File
    sim Simulink_multiterminal_HVDC_grid
    
    % Data extracted of Simulink saved in matrices
    kpdc_matrix(:,n) = Kpdc;
    vdc1_matrix(:,n) = vdc1;
    vdc2_matrix(:,n) = vdc2;
    vdc3_matrix(:,n) = vdc3;
    vdc4_matrix(:,n) = vdc4;
    iq1_matrix(:,n) = iq1;
    id1_matrix(:,n) = id1;
    ia1_matrix(:,n) = ia1;
    ib1_matrix(:,n) = ib1;
    ic1_matrix(:,n) = ic1;
    vlq1_matrix(:,n) = vlq1;
    vld1_matrix(:,n) = vld1;
    vla1_matrix(:,n) = vla1;
    vlb1_matrix(:,n) = vlb1;
    vlc1_matrix(:,n) = vlc1;
    iq2_matrix(:,n) = iq2;
    id2_matrix(:,n) = id2;
    ia2_matrix(:,n) = ia2;
    ib2_matrix(:,n) = ib2;
    ic2_matrix(:,n) = ic2;
    vlq2_matrix(:,n) = vlq2;
    vld2_matrix(:,n) = vld2;
    vla2_matrix(:,n) = vla2;
    vlb2_matrix(:,n) = vlb2;
    vlc2_matrix(:,n) = vlc2;
    idc1_matrix(:,n) = idc1;
    idc2_matrix(:,n) = idc2;
    idc3_matrix(:,n) = idc3;
    idc4_matrix(:,n) = idc4;

    
    % The num2str function converts numbers to their string representations.
    % Variables to show in the legend
    a = ['K_p_D_C = ', num2str(Kpdc)];
    bvdc = ['V_D_C_m_a_x = ', num2str(vdcrefmax), ' kV'];
    ciq = ['i_q_m_a_x = ', num2str(iqrefmax), ' A'];
    did = ['i_d_m_a_x = ', num2str(idrefmax), ' A'];
    eidc = ['I_D_C_m_a_x = ', num2str(idcrefmax), ' A'];
    vlpeak = ['v_l_a_b_c_m_a_x = ', num2str(vlrefmax), ' kV'];
    vlpeak1 = ['v_l_a_b_c_m_a_x = ', num2str(vlrefmax1), ' kV'];
    iabcmax = ['i_a_b_c_m_a_x = ', num2str(iabcrefmax), ' A'];
    iabcmax1 = ['i_a_b_c_m_a_x = ', num2str(iabcrefmax1), ' A'];
    fvlq = ['v_l_q_m_a_x = ', num2str(vlqrefmax), ' kV'];
    
    % Plots of the electrical measures in function of the Kpdc
    % DynamicLegend serves to update the legend
    hold on;
    
    figure(1);
    if n == 1
        hold on;
        plot(t, vdcmax/1000, 'DisplayName', bvdc, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
        hold all;
    end
    plot(t, vdc1/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    hold all;
    xlim([0.8 2]); % Limits de la x
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('V_D_C_1 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
   
    figure(2);
    if n == 1
       hold on;
       plot(t, vdcmax/1000, 'DisplayName', bvdc, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vdc2/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('V_D_C_2 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(3);
    if n == 1
       hold on;
       plot(t, vdcmax/1000, 'DisplayName', bvdc, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vdc3/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('V_D_C_3 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(4);
    if n == 1
       hold on;
       plot(t, vdcmax/1000, 'DisplayName', bvdc, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vdc4/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('V_D_C_4 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(5);
    if n == 1
       hold on;
       plot(t, iqmax, 'DisplayName', ciq, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, abs(iq1), 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_q_1 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(6);
    if n == 1
       hold on;
       plot(t, idmax, 'DisplayName', did, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, id1, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_d_1 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(7);
    if n == 1
       hold on;
       plot(t, iqmax, 'DisplayName', iabcmax, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, iqmax1, 'DisplayName', iabcmax1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, ia1, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_a_1 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(8);
    if n == 1
       hold on;
       plot(t, iqmax, 'DisplayName', iabcmax, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, iqmax1, 'DisplayName', iabcmax1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, ib1, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_b_1 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(9);
    if n == 1
       hold on;
       plot(t, iqmax, 'DisplayName', iabcmax, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, iqmax1, 'DisplayName', iabcmax1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, ic1, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_c_1 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(10);
    if n == 1
       hold on;
       plot(t, vlqmax, 'DisplayName', fvlq, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vlq1/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_q_1 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(11);
    plot(t, abs(vld1/1000), 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_d_1 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(12);
    if n == 1
       hold on;
       plot(t, vlmax, 'DisplayName', vlpeak, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, vlmax1, 'DisplayName', vlpeak1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vla1/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_a_1 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(13);
    if n == 1
       hold on;
       plot(t, vlmax, 'DisplayName', vlpeak, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, vlmax1, 'DisplayName', vlpeak1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vlb1/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_b_1 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(14);
    if n == 1
       hold on;
       plot(t, vlmax, 'DisplayName', vlpeak, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, vlmax1, 'DisplayName', vlpeak1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vlc1/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_c_1 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(15);
    if n == 1
       hold on;
       plot(t, iqmax, 'DisplayName', ciq, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, abs(iq2), 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_q_2 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(16);
    if n == 1
       hold on;
       plot(t, idmax, 'DisplayName', did, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, id2, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_d_2 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(17);
    if n == 1
       hold on;
       plot(t, iqmax, 'DisplayName', iabcmax, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, iqmax1, 'DisplayName', iabcmax1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, ia2, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_a_2 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(18);
    if n == 1
       hold on;
       plot(t, iqmax, 'DisplayName', iabcmax, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, iqmax1, 'DisplayName', iabcmax1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, ib2, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_b_2 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(19);
    if n == 1
       hold on;
       plot(t, iqmax, 'DisplayName', iabcmax, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, iqmax1, 'DisplayName', iabcmax1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, ic2, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('i_c_2 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend'); 
    
    figure(20);
    if n == 1
       hold on;
       plot(t, vlqmax, 'DisplayName', fvlq, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vlq2/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_q_2 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(21);
    plot(t, abs(vld2/1000), 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_d_2 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
 
    figure(22);
    if n == 1
       hold on;
       plot(t, vlmax, 'DisplayName', vlpeak, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, vlmax1, 'DisplayName', vlpeak1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vla2/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_a_2 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(23);
    if n == 1
       hold on;
       plot(t, vlmax, 'DisplayName', vlpeak, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, vlmax1, 'DisplayName', vlpeak1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vlb2/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_b_2 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(24);
    if n == 1
       hold on;
       plot(t, vlmax, 'DisplayName', vlpeak, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
       hold on;
       plot(t, vlmax1, 'DisplayName', vlpeak1, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, vlc2/1000, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('v_l_c_2 [kV]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(25);
    if n == 1
       hold on;
       plot(t, idcmax, 'DisplayName', eidc, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, idc1, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 50]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('I_D_C_1 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(26);
    if n == 1
       hold on;
       plot(t, idcmax, 'DisplayName', eidc, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, idc2, 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('I_D_C_2 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(27);
    if n == 1
       hold on;
       plot(t, idcmax, 'DisplayName', eidc, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, abs(idc3), 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('I_D_C_3 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
    
    figure(28);
    if n == 1
       hold on;
       plot(t, idcmax, 'DisplayName', eidc, 'color', [0.7, 0.8, 0.1], 'LineWidth', 2);
       hold all;
    end
    plot(t, abs(idc4), 'DisplayName', a, 'color', C{n}, 'LineWidth', 2);
    xlim([0.8 2]);
    grid on;
    xlabel('Time [s]', 'FontSize', 14);
    ylabel('I_D_C_4 [A]', 'FontSize', 14);
    hold all;
    legend('-DynamicLegend');
end