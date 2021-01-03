clc; clear;

%Rudder Span & Chord Calculations
%Equations from "Aircraft Design: A Systems Engineering Approach" Chapter 12
%http://www.aero.us.es/adesign/Slides/Extra/Stability/Design_Control_Surface/Chapter%2012.%20Desig%20of%20Control%20Surfaces%20(Rudder).pdf.

ft_m = 0.3048;                  %feet to meter conversion
U1 = ft_m*52.935;               %approach airspeed, m/s
Vw = ft_m*8.4;                  %crosswind speed, m/s
Vt = ft_m*sqrt(U1^2 + Vw^2);    %Vt a/c total airspeed, m/s, eqn. 12.106 pg. 13

rho= 1.1405;                    %air density, kg/m^3
in2_m2 = 0.00064516;            %in^2 to m^2 conversion
Sv = in2_m2*43.2;               %planform area, vertical tail surface area, m^2
Sf = in2_m2*48;                 %fuselage area, m^2
S = in2_m2*759.6;               %wing surface area, m^2          
Ss = 1.02*(Sf + Sv);            %aircraft side area, m^2
Cd_y= 0.6;                      %aircraft side drag coefficient 

Fw = 1/2*rho*Vw^2*Ss*Cd_y;      %aircraft side force, N, eqn. 12.113

bv = ft_m*0.8;                  %tail span, m
br_bv = 1;                      %rudder span to vertical tail span ratio
br = bv*br_bv;                  %rudder span, m

Cv = ft_m*0.45;                 %tail root chord, m
Cr_Cv = 0.42;                   %rudder to vertical tail chord ratio, of root chord
                                %based on table 12.1 A/Cs & last year Cr_Cv choice 
Cr = Cv*Cr_Cv;                  %rudder chord, m 

beta = atan(Vw/U1);             %sideslip angle, eqn. 12.105

K_f1 = 0.75;                    %contribution of fuselage to aircraft Cn_b, based on example pg. 37
K_f2 = 1.35;                    %fuselage contribution coeff., typically between 1.3 and 1.4
Cl_aV = 0.0963;                 %vertical tail lift curve slope, NACA0012 Xflr5, 0-10 alpha 
eta_V = 0.94;                   %dynamic pressure ratio at vertical tail, typical range 0.92-0.96
sigma_beta = 0;                 %vertical tail sidewash gradient, based on book example pg. 37
l_Vt = ft_m*2.625;              %vertical tail moment arm, from xflr5 file, m
Sv_S = Sv/S;                    %vertical tail area/wing reference area 

%static stability  deriviatives eqn. 12.116 & 12.117 pg.15
Cn_b = K_f1*Cl_aV*(1- sigma_beta)*eta_V*l_Vt*Sv_S*(1/bv); 
Cy_b = -K_f2*Cl_aV*(1- sigma_beta)*eta_V*Sv_S;

tau = 0.61;                     %rudder angle of attack effectiveness, function of Cr/Cv
                                %https://www.ripublication.com/ijaer18/ijaerv13n10_85.pdf,
                                %figure 1
V_v = l_Vt*Sv_S*(1/bv) ;        %vertical tail volume coeff. 

%aircraft control derivative Cy_r & Cn_r eqn 12.118 & 12.100
Cy_r = Cl_aV*eta_V*tau*br_bv*Sv_S; 
Cn_r = -Cl_aV*V_v*eta_V*tau*br_bv;

dc = 0.2539;                    %distance betwen CG and center of AC side area, centroid eqn. 
Cn_o = 0.1;                     % based on book example, pg. 16    
sigma = 0.488511;               %crab angle, solving 12.114 & 12.115 simultaneously
delta_r = 28.28 - 2.25*sigma;   %rudder deflection

%Verifying rudder dimensions are feasible 
if delta_r > 30                 %greater than 30 degrees
    Cr_Cv = 1;
    Cr = Cv*Cr_Cv;
end
if tau >1
    error("Rudder AoA effectiveness is > 1. Reduce or redesign vertical tail.");
end

m_ft = 3.28084;                  %meters to feet conversion
br_ft = m_ft*br;                 %rudder span, ft
Cr_ft = m_ft*Cr;                 %rudder chord, ft
Sr_ft = br_ft*Cr_ft;             % rudder area, ft^2

fprintf("Rudder span (br) = %f ft\nRudder chord (Cr) = %f ft\nRudder area (Sr) = %f ft^2 ", br_ft, Cr_ft, Sr_ft);
