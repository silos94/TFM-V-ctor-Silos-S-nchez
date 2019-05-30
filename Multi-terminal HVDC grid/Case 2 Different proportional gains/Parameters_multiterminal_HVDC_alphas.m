% File Name: Parameters_multiterminal_HVDC_grid_alphas.m
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

% Limit values
vdcrefmax = ((5/100)*Vdc) + Vdc;
iabcrefmax = 1340;
idcrefmax = 820;
vlrefmax = round((5/100)*((Uab/sqrt(3))*sqrt(2))+((Uab/sqrt(3))*sqrt(2)));

% Simulations: Kpdc1 and Kpdc2 changes
tsimul = 2;
alpha = 0;
Kpdc = 200;
Kpdc1 = Kpdc*alpha;
Kpdc2 = Kpdc*(1-alpha);
h1 = zeros(4,1);
h2 = zeros(4,1);
h3 = zeros(4,1);
h4 = zeros(4,1);
h5 = zeros(4,1);
h6 = zeros(4,1);
h7 = zeros(4,1);
h8 = zeros(4,1);
h9 = zeros(4,1);
h10 = zeros(4,1);
h11 = zeros(4,1);
h12 = zeros(4,1);
h13 = zeros(4,1);
h14 = zeros(4,1);
h15 = zeros(4,1);
h16 = zeros(4,1);
h17 = zeros(4,1);
h18 = zeros(4,1);
h19 = zeros(4,1);
h20 = zeros(4,1);

for Kpdc = [200 : 200 : 1800]
    
    % It simulates the Simulink File
    n = 0; % Simulation counter 

    for alpha = [0 : 0.1 : 1]
        n = n + 1;
        
        sim Simulink_multiterminal_HVDC_grid_alphas
        
        % Kpdc1 i Kpdc2
        Kpdc1 = Kpdc*alpha;
        Kpdc2 = Kpdc*(1-alpha);
        
        % Data extracted of Simulink saved in matrices
        alpha_matrix(:,n) = alpha;
        Kpdc1_matrix(:,n) = Kpdc1;
        Kpdc2_matrix(:,n) = Kpdc2;
        vdc1_matrix(:,n) = vdc1;
        vdc2_matrix(:,n) = vdc2;
        vdc3_matrix(:,n) = vdc3;
        vdc4_matrix(:,n) = vdc4;
        ia1_matrix(:,n) = ia1;
        ib1_matrix(:,n) = ib1;
        ic1_matrix(:,n) = ic1;
        vla1_matrix(:,n) = vla1;
        vlb1_matrix(:,n) = vlb1;
        vlc1_matrix(:,n) = vlc1;
        ia2_matrix(:,n) = ia2;
        ib2_matrix(:,n) = ib2;
        ic2_matrix(:,n) = ic2;
        vla2_matrix(:,n) = vla2;
        vlb2_matrix(:,n) = vlb2;
        vlc2_matrix(:,n) = vlc2;
        idc1_matrix(:,n) = idc1;
        idc2_matrix(:,n) = idc2;
        idc3_matrix(:,n) = idc3;
        idc4_matrix(:,n) = idc4;
        
        
        % Plots of the electrical measures in function of the Kpdc
        % DynamicLegend serves to update the legend
        hold on;
        
        figure(1);
        if  max(abs(vdc1_matrix(99996 : 129996, n))) < vdcrefmax && max(abs(vdc1_matrix(129997 : 200001, n))) < vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h1(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc1_matrix(99996 : 129996, n))) > vdcrefmax && max(abs(vdc1_matrix(129997 : 200001, n))) < vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h1(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc1_matrix(99996 : 129996, n))) < vdcrefmax && max(abs(vdc1_matrix(129997 : 200001, n))) > vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h1(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc1_matrix(99996 : 129996, n))) > vdcrefmax && max(abs(vdc1_matrix(129997 : 200001, n))) > vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h1(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('V_D_C_1', 'FontSize', 14);
        hold all;
        
        
        figure(2);
        if  max(abs(vdc2_matrix(99996 : 129996, n))) < vdcrefmax && max(abs(vdc2_matrix(129997 : 200001, n))) < vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h2(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc2_matrix(99996 : 129996, n))) > vdcrefmax && max(abs(vdc2_matrix(129997 : 200001, n))) < vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h2(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc2_matrix(99996 : 129996, n))) < vdcrefmax && max(abs(vdc2_matrix(129997 : 200001, n))) > vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h2(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc2_matrix(99996 : 129996, n))) > vdcrefmax && max(abs(vdc2_matrix(129997 : 200001, n))) > vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h2(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('V_D_C_2', 'FontSize', 14);
        hold all;
        
        
        figure(3);
        if  max(abs(vdc3_matrix(99996 : 129996, n))) < vdcrefmax && max(abs(vdc3_matrix(129997 : 200001, n))) < vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h3(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc3_matrix(99996 : 129996, n))) > vdcrefmax && max(abs(vdc3_matrix(129997 : 200001, n))) < vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h3(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc3_matrix(99996 : 129996, n))) < vdcrefmax && max(abs(vdc3_matrix(129997 : 200001, n))) > vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h3(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc3_matrix(99996 : 129996, n))) > vdcrefmax && max(abs(vdc3_matrix(129997 : 200001, n))) > vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h3(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('V_D_C_3', 'FontSize', 14);
        hold all;
        
        figure(4);
        if  max(abs(vdc4_matrix(99996 : 129996, n))) < vdcrefmax && max(abs(vdc4_matrix(129997 : 200001, n))) < vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h4(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc4_matrix(99996 : 129996, n))) > vdcrefmax && max(abs(vdc4_matrix(129997 : 200001, n))) < vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h4(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc4_matrix(99996 : 129996, n))) < vdcrefmax && max(abs(vdc4_matrix(129997 : 200001, n))) > vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h4(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vdc4_matrix(99996 : 129996, n))) > vdcrefmax && max(abs(vdc4_matrix(129997 : 200001, n))) > vdcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h4(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('V_D_C_4', 'FontSize', 14);
        hold all;
        
        figure(5);
        if  max(abs(ia1_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ia1_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h5(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ia1_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ia1_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h5(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ia1_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ia1_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h5(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ia1_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ia1_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h5(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('i_a_1', 'FontSize', 14);
        hold all;
        
        figure(6);
        if  max(abs(ib1_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ib1_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h6(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ib1_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ib1_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h6(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ib1_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ib1_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h6(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ib1_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ib1_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h6(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('i_b_1', 'FontSize', 14);
        hold all;
        
        figure(7);
        if  max(abs(ic1_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ic1_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h7(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ic1_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ic1_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h7(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ic1_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ic1_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h7(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ic1_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ic1_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h7(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('i_c_1', 'FontSize', 14);
        hold all;
        
        figure(8);
        if  max(abs(vla1_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vla1_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h8(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vla1_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vla1_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h8(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vla1_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vla1_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h8(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vla1_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vla1_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h8(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('v_l_a_1', 'FontSize', 14);
        hold all;
        
        figure(9);
        if  max(abs(vlb1_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vlb1_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h9(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlb1_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vlb1_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h9(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlb1_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vlb1_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h9(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlb1_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vlb1_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h9(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('v_l_b_1', 'FontSize', 14);
        hold all;
        
        figure(10);
        if  max(abs(vlc1_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vlc1_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h10(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlc1_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vlc1_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h10(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlc1_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vlc1_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h10(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlc1_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vlc1_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h10(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('v_l_c_1', 'FontSize', 14);
        hold all;
        
        figure(11);
        if  max(abs(ia2_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ia2_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h11(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ia2_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ia2_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h11(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ia2_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ia2_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h11(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ia2_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ia2_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h11(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('i_a_2', 'FontSize', 14);
        hold all;
        
        figure(12);
        if  max(abs(ib2_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ib2_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h12(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ib2_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ib2_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h12(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ib2_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ib2_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h12(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ib2_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ib2_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h12(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('i_b_2', 'FontSize', 14);
        hold all;
        
        figure(13);
        if  max(abs(ic2_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ic2_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h13(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ic2_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ic2_matrix(129997 : 200001, n))) < iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h13(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ic2_matrix(99996 : 129996, n))) < iabcrefmax && max(abs(ic2_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h13(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(ic2_matrix(99996 : 129996, n))) > iabcrefmax && max(abs(ic2_matrix(129997 : 200001, n))) > iabcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h13(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('i_c_2', 'FontSize', 14);
        hold all;
        
        figure(14);
        if  max(abs(vla2_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vla2_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h14(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vla2_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vla2_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h14(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vla2_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vla2_matrix(129997 : 200001, n))) > vlrefmax    
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h14(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vla2_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vla2_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h14(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('v_l_a_2', 'FontSize', 14);
        hold all;
        
        figure(15);
        if  max(abs(vlb2_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vlb2_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h15(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlb2_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vlb2_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h15(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlb2_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vlb2_matrix(129997 : 200001, n))) > vlrefmax   
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h15(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlb2_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vlb2_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h15(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('v_l_b_2', 'FontSize', 14);
        hold all;
        
        figure(16);
        if  max(abs(vlc2_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vlc2_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h16(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlc2_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vlc2_matrix(129997 : 200001, n))) < vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h16(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlc2_matrix(99996 : 129996, n))) < vlrefmax && max(abs(vlc2_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h16(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(vlc2_matrix(99996 : 129996, n))) > vlrefmax && max(abs(vlc2_matrix(129997 : 200001, n))) > vlrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h16(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('v_l_c_2', 'FontSize', 14);
        hold all;
        
        figure(17);
        if  max(abs(idc1_matrix(99996 : 129996, n))) < idcrefmax && max(abs(idc1_matrix(129997 : 200001, n))) < idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h17(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc1_matrix(99996 : 129996, n))) > idcrefmax && max(abs(idc1_matrix(129997 : 200001, n))) < idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h17(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc1_matrix(99996 : 129996, n))) < idcrefmax && max(abs(idc1_matrix(129997 : 200001, n))) > idcrefmax    
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h17(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc1_matrix(99996 : 129996, n))) > idcrefmax && max(abs(idc1_matrix(129997 : 200001, n))) > idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h17(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('I_D_C_1', 'FontSize', 14);
        hold all;
        
        figure(18);
        if  max(abs(idc2_matrix(99996 : 129996, n))) < idcrefmax && max(abs(idc2_matrix(129997 : 200001, n))) < idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h18(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc2_matrix(99996 : 129996, n))) > idcrefmax && max(abs(idc2_matrix(129997 : 200001, n))) < idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h18(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc2_matrix(99996 : 129996, n))) < idcrefmax && max(abs(idc2_matrix(129997 : 200001, n))) > idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h18(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc2_matrix(99996 : 129996, n))) > idcrefmax && max(abs(idc2_matrix(129997 : 200001, n))) > idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h18(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('I_D_C_2', 'FontSize', 14);
        hold all;
        
        figure(19);
        if  max(abs(idc3_matrix(99996 : 129996, n))) < idcrefmax && max(abs(idc3_matrix(129997 : 200001, n))) < idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h19(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc3_matrix(99996 : 129996, n))) > idcrefmax && max(abs(idc3_matrix(129997 : 200001, n))) < idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h19(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc3_matrix(99996 : 129996, n))) < idcrefmax && max(abs(idc3_matrix(129997 : 200001, n))) > idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h19(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc3_matrix(99996 : 129996, n))) > idcrefmax && max(abs(idc3_matrix(129997 : 200001, n))) > idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h19(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('I_D_C_3', 'FontSize', 14);
        hold all;
        
        figure(20);
        if  max(abs(idc4_matrix(99996 : 129996, n))) < idcrefmax && max(abs(idc4_matrix(129997 : 200001, n))) < idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            h20(1) = plot(Kpdc1, Kpdc2, 'g^', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc4_matrix(99996 : 129996, n))) > idcrefmax && max(abs(idc4_matrix(129997 : 200001, n))) < idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            h20(2) = plot(Kpdc1, Kpdc2, 'color', [0.8500, 0.3250, 0.0980], 'linestyle', 'none', 'marker', 'o', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc4_matrix(99996 : 129996, n))) < idcrefmax && max(abs(idc4_matrix(129997 : 200001, n))) > idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            h20(3) = plot(Kpdc1, Kpdc2, 'cs', 'markersize', 5, 'LineWidth', 2);
            hold all;
        elseif max(abs(idc4_matrix(99996 : 129996, n))) > idcrefmax && max(abs(idc4_matrix(129997 : 200001, n))) > idcrefmax
            hold on;
            plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            h20(4) = plot(Kpdc1, Kpdc2, 'rx', 'markersize', 5, 'LineWidth', 2);
            hold all;
        end
        grid on;
        xlabel('K_p_D_C_1 (W/V)', 'FontSize', 14);
        ylabel('K_p_D_C_2 (W/V)', 'FontSize', 14);
        title('I_D_C_4', 'FontSize', 14);
        hold all;
    end
end

figure(1)
hold all;
if h1(1) == 0 && h1(2) == 0 && h1(3) == 0
    legend('nass and natr');
elseif h1(1) == 0 && h1(3) == 0 && h1(4) == 0
    legend('ass and natr');
elseif h1(2) == 0 && h1(3) == 0 && h1(4) == 0
    legend('ass and atr');
elseif h1(1) == 0 && h1(2) == 0 && h1(4) == 0
    legend('nass and atr');
elseif h1(1) == 0 && h1(2) == 0
    legend(h1([3 4]), 'nass and atr', 'nass and natr');
elseif h1(1) == 0 && h1(3) == 0 
    legend(h1([2 4]), 'ass and natr', 'nass and natr');
elseif h1(1) == 0 && h1(4) == 0 
    legend(h1([2 3]), 'ass and natr', 'nass and atr');   
elseif h1(2) == 0 && h1(3) == 0
    legend(h1([1 4]), 'ass and atr', 'nass and natr');
elseif h1(2) == 0 && h1(4) == 0
    legend(h1([1 3]), 'ass and atr', 'nass and atr');
elseif h1(3) == 0 && h1(4) == 0
    legend(h1([1 2]), 'ass and atr', 'ass and natr');
elseif h1(1) == 0
    legend(h1([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h1(2) == 0
    legend(h1([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h1(3) == 0
    legend(h1([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h1(4) == 0
    legend(h1([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h1, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(2)
hold all;
if h2(1) == 0 && h2(2) == 0 && h2(3) == 0
    legend('nass and natr');
elseif h2(1) == 0 && h2(3) == 0 && h2(4) == 0
    legend('ass and natr');
elseif h2(2) == 0 && h2(3) == 0 && h2(4) == 0
    legend('ass and atr');
elseif h2(1) == 0 && h2(2) == 0 && h2(4) == 0
    legend('nass and atr');
elseif h2(1) == 0 && h2(2) == 0
    legend(h2([3 4]), 'nass and atr', 'nass and natr');
elseif h2(1) == 0 && h2(3) == 0 
    legend(h2([2 4]), 'ass and natr', 'nass and natr');
elseif h2(1) == 0 && h2(4) == 0 
    legend(h2([2 3]), 'ass and natr', 'nass and atr');   
elseif h2(2) == 0 && h2(3) == 0
    legend(h2([1 4]), 'ass and atr', 'nass and natr');
elseif h2(2) == 0 && h2(4) == 0
    legend(h2([1 3]), 'ass and atr', 'nass and atr');
elseif h2(3) == 0 && h2(4) == 0
    legend(h2([1 2]), 'ass and atr', 'ass and natr');
elseif h2(1) == 0
    legend(h2([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h2(2) == 0
    legend(h2([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h2(3) == 0
    legend(h2([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h2(4) == 0
    legend(h2([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h2, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(3)
hold all;
if h3(1) == 0 && h3(2) == 0 && h3(3) == 0
    legend('nass and natr');
elseif h3(1) == 0 && h3(3) == 0 && h3(4) == 0
    legend('ass and natr');
elseif h3(2) == 0 && h3(3) == 0 && h3(4) == 0
    legend('ass and atr');
elseif h3(1) == 0 && h3(2) == 0 && h3(4) == 0
    legend('nass and atr');
elseif h3(1) == 0 && h3(2) == 0
    legend(h3([3 4]), 'nass and atr', 'nass and natr');
elseif h3(1) == 0 && h3(3) == 0 
    legend(h3([2 4]), 'ass and natr', 'nass and natr');
elseif h3(1) == 0 && h3(4) == 0 
    legend(h3([2 3]), 'ass and natr', 'nass and atr');   
elseif h3(2) == 0 && h3(3) == 0
    legend(h3([1 4]), 'ass and atr', 'nass and natr');
elseif h3(2) == 0 && h3(4) == 0
    legend(h3([1 3]), 'ass and atr', 'nass and atr');
elseif h3(3) == 0 && h3(4) == 0
    legend(h3([1 2]), 'ass and atr', 'ass and natr');
elseif h3(1) == 0
    legend(h3([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h3(2) == 0
    legend(h3([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h3(3) == 0
    legend(h3([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h3(4) == 0
    legend(h3([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h3, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(4)
hold all;
if h4(1) == 0 && h4(2) == 0 && h4(3) == 0
    legend('nass and natr');
elseif h4(1) == 0 && h4(3) == 0 && h4(4) == 0
    legend('ass and natr');
elseif h4(2) == 0 && h4(3) == 0 && h4(4) == 0
    legend('ass and atr');
elseif h4(1) == 0 && h4(2) == 0 && h4(4) == 0
    legend('nass and atr');
elseif h4(1) == 0 && h4(2) == 0
    legend(h4([3 4]), 'nass and atr', 'nass and natr');
elseif h4(1) == 0 && h4(3) == 0 
    legend(h4([2 4]), 'ass and natr', 'nass and natr');
elseif h4(1) == 0 && h4(4) == 0 
    legend(h4([2 3]), 'ass and natr', 'nass and atr');   
elseif h4(2) == 0 && h4(3) == 0
    legend(h4([1 4]), 'ass and atr', 'nass and natr');
elseif h4(2) == 0 && h4(4) == 0
    legend(h4([1 3]), 'ass and atr', 'nass and atr');
elseif h4(3) == 0 && h4(4) == 0
    legend(h4([1 2]), 'ass and atr', 'ass and natr');
elseif h4(1) == 0
    legend(h4([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h4(2) == 0
    legend(h4([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h4(3) == 0
    legend(h4([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h4(4) == 0
    legend(h4([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h4, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(5)
hold all;
if h5(1) == 0 && h5(2) == 0 && h5(3) == 0
    legend('nass and natr');
elseif h5(1) == 0 && h5(3) == 0 && h5(4) == 0
    legend('ass and natr');
elseif h5(2) == 0 && h5(3) == 0 && h5(4) == 0
    legend('ass and atr');
elseif h5(1) == 0 && h5(2) == 0 && h5(4) == 0
    legend('nass and atr');
elseif h5(1) == 0 && h5(2) == 0
    legend(h5([3 4]), 'nass and atr', 'nass and natr');
elseif h5(1) == 0 && h5(3) == 0 
    legend(h5([2 4]), 'ass and natr', 'nass and natr');
elseif h5(1) == 0 && h5(4) == 0 
    legend(h5([2 3]), 'ass and natr', 'nass and atr');   
elseif h5(2) == 0 && h5(3) == 0
    legend(h5([1 4]), 'ass and atr', 'nass and natr');
elseif h5(2) == 0 && h5(4) == 0
    legend(h5([1 3]), 'ass and atr', 'nass and atr');
elseif h5(3) == 0 && h5(4) == 0
    legend(h5([1 2]), 'ass and atr', 'ass and natr');
elseif h5(1) == 0
    legend(h5([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h5(2) == 0
    legend(h5([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h5(3) == 0
    legend(h5([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h5(4) == 0
    legend(h5([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h5, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(6)
hold all;
if h6(1) == 0 && h6(2) == 0 && h6(3) == 0
    legend('nass and natr');
elseif h6(1) == 0 && h6(3) == 0 && h6(4) == 0
    legend('ass and natr');
elseif h6(2) == 0 && h6(3) == 0 && h6(4) == 0
    legend('ass and atr');
elseif h6(1) == 0 && h6(2) == 0 && h6(4) == 0
    legend('nass and atr');
elseif h6(1) == 0 && h6(2) == 0
    legend(h6([3 4]), 'nass and atr', 'nass and natr');
elseif h6(1) == 0 && h6(3) == 0 
    legend(h6([2 4]), 'ass and natr', 'nass and natr');
elseif h6(1) == 0 && h6(4) == 0 
    legend(h6([2 3]), 'ass and natr', 'nass and atr');   
elseif h6(2) == 0 && h6(3) == 0
    legend(h6([1 4]), 'ass and atr', 'nass and natr');
elseif h6(2) == 0 && h6(4) == 0
    legend(h6([1 3]), 'ass and atr', 'nass and atr');
elseif h6(3) == 0 && h6(4) == 0
    legend(h6([1 2]), 'ass and atr', 'ass and natr');
elseif h6(1) == 0
    legend(h6([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h6(2) == 0
    legend(h6([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h6(3) == 0
    legend(h6([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h6(4) == 0
    legend(h6([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h6, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(7)
hold all;
if h7(1) == 0 && h7(2) == 0 && h7(3) == 0
    legend('nass and natr');
elseif h7(1) == 0 && h7(3) == 0 && h7(4) == 0
    legend('ass and natr');
elseif h7(2) == 0 && h7(3) == 0 && h7(4) == 0
    legend('ass and atr');
elseif h7(1) == 0 && h7(2) == 0 && h7(4) == 0
    legend('nass and atr');
elseif h7(1) == 0 && h7(2) == 0
    legend(h7([3 4]), 'nass and atr', 'nass and natr');
elseif h7(1) == 0 && h7(3) == 0 
    legend(h7([2 4]), 'ass and natr', 'nass and natr');
elseif h7(1) == 0 && h7(4) == 0 
    legend(h7([2 3]), 'ass and natr', 'nass and atr');   
elseif h7(2) == 0 && h7(3) == 0
    legend(h7([1 4]), 'ass and atr', 'nass and natr');
elseif h7(2) == 0 && h7(4) == 0
    legend(h7([1 3]), 'ass and atr', 'nass and atr');
elseif h7(3) == 0 && h7(4) == 0
    legend(h7([1 2]), 'ass and atr', 'ass and natr');
elseif h7(1) == 0
    legend(h7([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h7(2) == 0
    legend(h7([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h7(3) == 0
    legend(h7([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h7(4) == 0
    legend(h7([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h7, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(8)
hold all;
if h8(1) == 0 && h8(2) == 0 && h8(3) == 0
    legend('nass and natr');
elseif h8(1) == 0 && h8(3) == 0 && h8(4) == 0
    legend('ass and natr');
elseif h8(2) == 0 && h8(3) == 0 && h8(4) == 0
    legend('ass and atr');
elseif h8(1) == 0 && h8(2) == 0 && h8(4) == 0
    legend('nass and atr');
elseif h8(1) == 0 && h8(2) == 0
    legend(h8([3 4]), 'nass and atr', 'nass and natr');
elseif h8(1) == 0 && h8(3) == 0 
    legend(h8([2 4]), 'ass and natr', 'nass and natr');
elseif h8(1) == 0 && h8(4) == 0 
    legend(h8([2 3]), 'ass and natr', 'nass and atr');   
elseif h8(2) == 0 && h8(3) == 0
    legend(h8([1 4]), 'ass and atr', 'nass and natr');
elseif h8(2) == 0 && h8(4) == 0
    legend(h8([1 3]), 'ass and atr', 'nass and atr');
elseif h8(3) == 0 && h8(4) == 0
    legend(h8([1 2]), 'ass and atr', 'ass and natr');
elseif h8(1) == 0
    legend(h8([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h8(2) == 0
    legend(h8([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h8(3) == 0
    legend(h8([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h8(4) == 0
    legend(h8([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h8, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(9)
hold all;
if h9(1) == 0 && h9(2) == 0 && h9(3) == 0
    legend('nass and natr');
elseif h9(1) == 0 && h9(3) == 0 && h9(4) == 0
    legend('ass and natr');
elseif h9(2) == 0 && h9(3) == 0 && h9(4) == 0
    legend('ass and atr');
elseif h9(1) == 0 && h9(2) == 0 && h9(4) == 0
    legend('nass and atr');
elseif h9(1) == 0 && h9(2) == 0
    legend(h9([3 4]), 'nass and atr', 'nass and natr');
elseif h9(1) == 0 && h9(3) == 0 
    legend(h9([2 4]), 'ass and natr', 'nass and natr');
elseif h9(1) == 0 && h9(4) == 0 
    legend(h9([2 3]), 'ass and natr', 'nass and atr');   
elseif h9(2) == 0 && h9(3) == 0
    legend(h9([1 4]), 'ass and atr', 'nass and natr');
elseif h9(2) == 0 && h9(4) == 0
    legend(h9([1 3]), 'ass and atr', 'nass and atr');
elseif h9(3) == 0 && h9(4) == 0
    legend(h9([1 2]), 'ass and atr', 'ass and natr');
elseif h9(1) == 0
    legend(h9([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h9(2) == 0
    legend(h9([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h9(3) == 0
    legend(h9([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h9(4) == 0
    legend(h9([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h9, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(10)
hold all;
if h10(1) == 0 && h10(2) == 0 && h10(3) == 0
    legend('nass and natr');
elseif h10(1) == 0 && h10(3) == 0 && h10(4) == 0
    legend('ass and natr');
elseif h10(2) == 0 && h10(3) == 0 && h10(4) == 0
    legend('ass and atr');
elseif h10(1) == 0 && h10(2) == 0 && h10(4) == 0
    legend('nass and atr');
elseif h10(1) == 0 && h10(2) == 0
    legend(h10([3 4]), 'nass and atr', 'nass and natr');
elseif h10(1) == 0 && h10(3) == 0 
    legend(h10([2 4]), 'ass and natr', 'nass and natr');
elseif h10(1) == 0 && h10(4) == 0 
    legend(h10([2 3]), 'ass and natr', 'nass and atr');   
elseif h10(2) == 0 && h10(3) == 0
    legend(h10([1 4]), 'ass and atr', 'nass and natr');
elseif h10(2) == 0 && h10(4) == 0
    legend(h10([1 3]), 'ass and atr', 'nass and atr');
elseif h10(3) == 0 && h10(4) == 0
    legend(h10([1 2]), 'ass and atr', 'ass and natr');
elseif h10(1) == 0
    legend(h10([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h10(2) == 0
    legend(h10([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h10(3) == 0
    legend(h10([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h10(4) == 0
    legend(h10([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h10, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(11)
hold all;
if h11(1) == 0 && h11(2) == 0 && h11(3) == 0
    legend('nass and natr');
elseif h11(1) == 0 && h11(3) == 0 && h11(4) == 0
    legend('ass and natr');
elseif h11(2) == 0 && h11(3) == 0 && h11(4) == 0
    legend('ass and atr');
elseif h11(1) == 0 && h11(2) == 0 && h11(4) == 0
    legend('nass and atr');
elseif h11(1) == 0 && h11(2) == 0
    legend(h11([3 4]), 'nass and atr', 'nass and natr');
elseif h11(1) == 0 && h11(3) == 0 
    legend(h11([2 4]), 'ass and natr', 'nass and natr');
elseif h11(1) == 0 && h11(4) == 0 
    legend(h11([2 3]), 'ass and natr', 'nass and atr');   
elseif h11(2) == 0 && h11(3) == 0
    legend(h11([1 4]), 'ass and atr', 'nass and natr');
elseif h11(2) == 0 && h11(4) == 0
    legend(h11([1 3]), 'ass and atr', 'nass and atr');
elseif h11(3) == 0 && h11(4) == 0
    legend(h11([1 2]), 'ass and atr', 'ass and natr');
elseif h11(1) == 0
    legend(h11([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h11(2) == 0
    legend(h11([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h11(3) == 0
    legend(h11([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h11(4) == 0
    legend(h11([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h11, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(12)
hold all;
if h12(1) == 0 && h12(2) == 0 && h12(3) == 0
    legend('nass and natr');
elseif h12(1) == 0 && h12(3) == 0 && h12(4) == 0
    legend('ass and natr');
elseif h12(2) == 0 && h12(3) == 0 && h12(4) == 0
    legend('ass and atr');
elseif h12(1) == 0 && h12(2) == 0 && h12(4) == 0
    legend('nass and atr');
elseif h12(1) == 0 && h12(2) == 0
    legend(h12([3 4]), 'nass and atr', 'nass and natr');
elseif h12(1) == 0 && h12(3) == 0 
    legend(h12([2 4]), 'ass and natr', 'nass and natr');
elseif h12(1) == 0 && h12(4) == 0 
    legend(h12([2 3]), 'ass and natr', 'nass and atr');   
elseif h12(2) == 0 && h12(3) == 0
    legend(h12([1 4]), 'ass and atr', 'nass and natr');
elseif h12(2) == 0 && h12(4) == 0
    legend(h12([1 3]), 'ass and atr', 'nass and atr');
elseif h12(3) == 0 && h12(4) == 0
    legend(h12([1 2]), 'ass and atr', 'ass and natr');
elseif h12(1) == 0
    legend(h12([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h12(2) == 0
    legend(h12([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h12(3) == 0
    legend(h12([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h12(4) == 0
    legend(h12([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h12, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(13)
hold all;
if h13(1) == 0 && h13(2) == 0 && h13(3) == 0
    legend('nass and natr');
elseif h13(1) == 0 && h13(3) == 0 && h13(4) == 0
    legend('ass and natr');
elseif h13(2) == 0 && h13(3) == 0 && h13(4) == 0
    legend('ass and atr');
elseif h13(1) == 0 && h13(2) == 0 && h13(4) == 0
    legend('nass and atr');
elseif h13(1) == 0 && h13(2) == 0
    legend(h13([3 4]), 'nass and atr', 'nass and natr');
elseif h13(1) == 0 && h13(3) == 0 
    legend(h13([2 4]), 'ass and natr', 'nass and natr');
elseif h13(1) == 0 && h13(4) == 0 
    legend(h13([2 3]), 'ass and natr', 'nass and atr');   
elseif h13(2) == 0 && h13(3) == 0
    legend(h13([1 4]), 'ass and atr', 'nass and natr');
elseif h13(2) == 0 && h13(4) == 0
    legend(h13([1 3]), 'ass and atr', 'nass and atr');
elseif h13(3) == 0 && h13(4) == 0
    legend(h13([1 2]), 'ass and atr', 'ass and natr');
elseif h13(1) == 0
    legend(h13([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h13(2) == 0
    legend(h13([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h13(3) == 0
    legend(h13([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h13(4) == 0
    legend(h13([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h13, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(14)
hold all;
if h14(1) == 0 && h14(2) == 0 && h14(3) == 0
    legend('nass and natr');
elseif h14(1) == 0 && h14(3) == 0 && h14(4) == 0
    legend('ass and natr');
elseif h14(2) == 0 && h14(3) == 0 && h14(4) == 0
    legend('ass and atr');
elseif h14(1) == 0 && h14(2) == 0 && h14(4) == 0
    legend('nass and atr');
elseif h14(1) == 0 && h14(2) == 0
    legend(h14([3 4]), 'nass and atr', 'nass and natr');
elseif h14(1) == 0 && h14(3) == 0 
    legend(h14([2 4]), 'ass and natr', 'nass and natr');
elseif h14(1) == 0 && h14(4) == 0 
    legend(h14([2 3]), 'ass and natr', 'nass and atr');   
elseif h14(2) == 0 && h14(3) == 0
    legend(h14([1 4]), 'ass and atr', 'nass and natr');
elseif h14(2) == 0 && h14(4) == 0
    legend(h14([1 3]), 'ass and atr', 'nass and atr');
elseif h14(3) == 0 && h14(4) == 0
    legend(h14([1 2]), 'ass and atr', 'ass and natr');
elseif h14(1) == 0
    legend(h14([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h14(2) == 0
    legend(h14([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h14(3) == 0
    legend(h14([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h14(4) == 0
    legend(h14([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h14, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(15)
hold all;
if h15(1) == 0 && h15(2) == 0 && h15(3) == 0
    legend('nass and natr');
elseif h15(1) == 0 && h15(3) == 0 && h15(4) == 0
    legend('ass and natr');
elseif h15(2) == 0 && h15(3) == 0 && h15(4) == 0
    legend('ass and atr');
elseif h15(1) == 0 && h15(2) == 0 && h15(4) == 0
    legend('nass and atr');
elseif h15(1) == 0 && h15(2) == 0
    legend(h15([3 4]), 'nass and atr', 'nass and natr');
elseif h15(1) == 0 && h15(3) == 0 
    legend(h15([2 4]), 'ass and natr', 'nass and natr');
elseif h15(1) == 0 && h15(4) == 0 
    legend(h15([2 3]), 'ass and natr', 'nass and atr');   
elseif h15(2) == 0 && h15(3) == 0
    legend(h15([1 4]), 'ass and atr', 'nass and natr');
elseif h15(2) == 0 && h15(4) == 0
    legend(h15([1 3]), 'ass and atr', 'nass and atr');
elseif h15(3) == 0 && h15(4) == 0
    legend(h15([1 2]), 'ass and atr', 'ass and natr');
elseif h15(1) == 0
    legend(h15([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h15(2) == 0
    legend(h15([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h15(3) == 0
    legend(h15([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h15(4) == 0
    legend(h15([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h15, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(16)
hold all;
if h16(1) == 0 && h16(2) == 0 && h16(3) == 0
    legend('nass and natr');
elseif h16(1) == 0 && h16(3) == 0 && h16(4) == 0
    legend('ass and natr');
elseif h16(2) == 0 && h16(3) == 0 && h16(4) == 0
    legend('ass and atr');
elseif h16(1) == 0 && h16(2) == 0 && h16(4) == 0
    legend('nass and atr');
elseif h16(1) == 0 && h16(2) == 0
    legend(h16([3 4]), 'nass and atr', 'nass and natr');
elseif h16(1) == 0 && h16(3) == 0 
    legend(h16([2 4]), 'ass and natr', 'nass and natr');
elseif h16(1) == 0 && h16(4) == 0 
    legend(h16([2 3]), 'ass and natr', 'nass and atr');   
elseif h16(2) == 0 && h16(3) == 0
    legend(h16([1 4]), 'ass and atr', 'nass and natr');
elseif h16(2) == 0 && h16(4) == 0
    legend(h16([1 3]), 'ass and atr', 'nass and atr');
elseif h16(3) == 0 && h16(4) == 0
    legend(h16([1 2]), 'ass and atr', 'ass and natr');
elseif h16(1) == 0
    legend(h16([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h16(2) == 0
    legend(h16([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h16(3) == 0
    legend(h16([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h16(4) == 0
    legend(h16([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h16, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(17)
hold all;
if h17(1) == 0 && h17(2) == 0 && h17(3) == 0
    legend('nass and natr');
elseif h17(1) == 0 && h17(3) == 0 && h17(4) == 0
    legend('ass and natr');
elseif h17(2) == 0 && h17(3) == 0 && h17(4) == 0
    legend('ass and atr');
elseif h17(1) == 0 && h17(2) == 0 && h17(4) == 0
    legend('nass and atr');
elseif h17(1) == 0 && h17(2) == 0
    legend(h17([3 4]), 'nass and atr', 'nass and natr');
elseif h17(1) == 0 && h17(3) == 0 
    legend(h17([2 4]), 'ass and natr', 'nass and natr');
elseif h17(1) == 0 && h17(4) == 0 
    legend(h17([2 3]), 'ass and natr', 'nass and atr');   
elseif h17(2) == 0 && h17(3) == 0
    legend(h17([1 4]), 'ass and atr', 'nass and natr');
elseif h17(2) == 0 && h17(4) == 0
    legend(h17([1 3]), 'ass and atr', 'nass and atr');
elseif h17(3) == 0 && h17(4) == 0
    legend(h17([1 2]), 'ass and atr', 'ass and natr');
elseif h17(1) == 0
    legend(h17([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h17(2) == 0
    legend(h17([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h17(3) == 0
    legend(h17([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h17(4) == 0
    legend(h17([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h17, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(18)
hold all;
if h18(1) == 0 && h18(2) == 0 && h18(3) == 0
    legend('nass and natr');
elseif h18(1) == 0 && h18(3) == 0 && h18(4) == 0
    legend('ass and natr');
elseif h18(2) == 0 && h18(3) == 0 && h18(4) == 0
    legend('ass and atr');
elseif h18(1) == 0 && h18(2) == 0 && h18(4) == 0
    legend('nass and atr');
elseif h18(1) == 0 && h18(2) == 0
    legend(h18([3 4]), 'nass and atr', 'nass and natr');
elseif h18(1) == 0 && h18(3) == 0 
    legend(h18([2 4]), 'ass and natr', 'nass and natr');
elseif h18(1) == 0 && h18(4) == 0 
    legend(h18([2 3]), 'ass and natr', 'nass and atr');   
elseif h18(2) == 0 && h18(3) == 0
    legend(h18([1 4]), 'ass and atr', 'nass and natr');
elseif h18(2) == 0 && h18(4) == 0
    legend(h18([1 3]), 'ass and atr', 'nass and atr');
elseif h18(3) == 0 && h18(4) == 0
    legend(h18([1 2]), 'ass and atr', 'ass and natr');
elseif h18(1) == 0
    legend(h18([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h18(2) == 0
    legend(h18([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h18(3) == 0
    legend(h18([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h18(4) == 0
    legend(h18([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h18, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(19)
hold all;
if h19(1) == 0 && h19(2) == 0 && h19(3) == 0
    legend('nass and natr');
elseif h19(1) == 0 && h19(3) == 0 && h19(4) == 0
    legend('ass and natr');
elseif h19(2) == 0 && h19(3) == 0 && h19(4) == 0
    legend('ass and atr');
elseif h19(1) == 0 && h19(2) == 0 && h19(4) == 0
    legend('nass and atr');
elseif h19(1) == 0 && h19(2) == 0
    legend(h19([3 4]), 'nass and atr', 'nass and natr');
elseif h19(1) == 0 && h19(3) == 0 
    legend(h19([2 4]), 'ass and natr', 'nass and natr');
elseif h19(1) == 0 && h19(4) == 0 
    legend(h19([2 3]), 'ass and natr', 'nass and atr');   
elseif h19(2) == 0 && h19(3) == 0
    legend(h19([1 4]), 'ass and atr', 'nass and natr');
elseif h19(2) == 0 && h19(4) == 0
    legend(h19([1 3]), 'ass and atr', 'nass and atr');
elseif h19(3) == 0 && h19(4) == 0
    legend(h19([1 2]), 'ass and atr', 'ass and natr');
elseif h19(1) == 0
    legend(h19([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h19(2) == 0
    legend(h19([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h19(3) == 0
    legend(h19([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h19(4) == 0
    legend(h19([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h19, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end

figure(20)
hold all;
if h20(1) == 0 && h20(2) == 0 && h20(3) == 0
    legend('nass and natr');
elseif h20(1) == 0 && h20(3) == 0 && h20(4) == 0
    legend('ass and natr');
elseif h20(2) == 0 && h20(3) == 0 && h20(4) == 0
    legend('ass and atr');
elseif h20(1) == 0 && h20(2) == 0 && h20(4) == 0
    legend('nass and atr');
elseif h20(1) == 0 && h20(2) == 0
    legend(h20([3 4]), 'nass and atr', 'nass and natr');
elseif h20(1) == 0 && h20(3) == 0 
    legend(h20([2 4]), 'ass and natr', 'nass and natr');
elseif h20(1) == 0 && h20(4) == 0 
    legend(h20([2 3]), 'ass and natr', 'nass and atr');   
elseif h20(2) == 0 && h20(3) == 0
    legend(h20([1 4]), 'ass and atr', 'nass and natr');
elseif h20(2) == 0 && h20(4) == 0
    legend(h20([1 3]), 'ass and atr', 'nass and atr');
elseif h20(3) == 0 && h20(4) == 0
    legend(h20([1 2]), 'ass and atr', 'ass and natr');
elseif h20(1) == 0
    legend(h20([2 3 4]), 'ass and natr', 'nass and atr', 'nass and natr');
elseif h20(2) == 0
    legend(h20([1 3 4]), 'ass and atr', 'nass and atr', 'nass and natr'); 
elseif h20(3) == 0
    legend(h20([1 2 4]), 'ass and atr', 'ass and natr', 'nass and natr'); 
elseif h20(4) == 0
    legend(h20([1 2 3]), 'ass and atr', 'ass and natr', 'nass and atr'); 
else
    legend(h20, 'ass and atr', 'ass and natr', 'nass and atr', 'nass and natr') 
end