clc; clear; 

%Script commands FindP, Find T, and FindVal scripts to search for desired termodynamic properties based on user input.

fprintf('Welcome! This program will help you find state properties for the analysis of a Thermodynamic system.\n\n');
fprintf('Table A-6 Superheated Water\n\n');
fprintf('Two properties must be known: Temperature(T) AND Pressure(P),\nOR\nTemperature(T) OR Pressure(P) AND\nspecific volume(v), specific internal energy(u), specific enthalpy(h), OR specific entropy(s)\n');
fprintf('\nPlease follow the prompts below to get started.\n\n');
%input: pressure OR temperature + one other property
%2nd property list: pressure, temperature, specific volume, specific...
%enthalpy, specific entropy, specific interal energy

%initialize properties
T = 0;
P = 0;
v = 0;
u = 0;
h = 0; 
s = 0;

%first property: temperature or pressure
first_property = input('Is the first property Temperature(T) or Pressure(P)? ', 's');
temp = 'T';
pressure = 'P';
first_temp = strcmp(first_property, temp);
first_pressure = strcmp(first_property, pressure);
if first_temp == 1
    T = input('What is the temperature in °C? ');
    %check if temperature value is within acceptible range
    if (T>1300 || T<45.81)
        error('%g°C is outside the range of possible temperatures for a superheated vapor.', second_value);
    end
elseif first_pressure  == 1
         P = input('What is the pressure in MPa? ');
%check if pressure value is within acceptible range
if P>1.0 || P<0.01
        error('%gMPa is outside the accepted range 0.01MPa-1.0MPa.', P);    
end
end

%second property
second_property=input('What is the second property? ', 's');

%check if second property is P, v, h, s, or u
specvol= 'v';
specenthal= 'h';
specentro= 's';
specinten= 'u';
second_temp= strcmp(second_property,temp);
second_pressure= strcmp(second_property, pressure);
second_specvol= strcmp(second_property,specvol);
second_specenthal= strcmp(second_property,specenthal);
second_specentro= strcmp(second_property,specentro);
second_specinten= strcmp(second_property,specinten);

%input second property value w/ correct units
if second_temp == 1
    T =input('What is the temperature in °C? ');
elseif second_specvol == 1
         v =input('What is the specific volume in m^3/kg? ');
elseif second_specenthal == 1
         h = input('What is the specific enthalpy in kJ/kg? ');
elseif second_specentro == 1
         s =input('What is the specific entropy in kJ/kg? ');
elseif second_pressure == 1
         P =input('What is the pressure in MPa? ');
elseif second_specinten == 1
         u =input('What is the specific internal energy in kJ/kg*K? ');
elseif  second_pressure == 0 && second_temp == 0 && second_specvol == 0 && second_specenthal == 0 && second_specentro == 0 && second_specinten == 0
        error('The second intensive property is invalid. ');
end

%check if second value is within acceptable range
if second_temp == 1 && (T>1300 || T<45.81)
        error('%g°C is outside the range of possible temperatures for a superheated vapor.', second_value);
elseif second_specvol == 1 && (v>72.604 || v<0.19437)
        error('%gm^3/kg is outside the range of possible specific volumes for a superheated vapor.', second_value);
elseif second_specenthal == 1 && (h<2583.9 || h>5413.4)
        error('%gkJ/kg is outside the range of possible specific enthalpies for a superheated vapor.', second_value);   
elseif second_specentro == 1 && (s<6.5850 || s>11.5857)
        error('%gkJ/kg is outside the range of possible specific entropies for a superheated vapor.', second_value);          
elseif second_specinten == 1 && (u<2437.2 || u>4687.4)
        error('%gkJ/kg*K is outside the range of possible specific internal energies for a superheated vapor.', second_value);
elseif second_pressure == 1 && (P>1.0 || P<0.01)      
        error('%gMPa is outside the accepted range 0.01MPa-1.0MPa.', P);    
end


%find values

%if Temperature is first property
if first_temp == 1
    if second_specvol == 1
        i_p= v;
        P= findP(T, i_p, 1);
        [v u h s] = findVal(T,P);
        values= [P u h s]; 
         values_string= 'Puhs';
    elseif second_specinten == 1
        i_p= u;
        P= findP(T, i_p, 2);
        [v u h s] = findVal(T,P);
        values= [P v h s];
         values_string= 'Pvhs';
    elseif second_specenthal == 1 
        i_p= h;
        P= findP(T, i_p, 3);
        [v u h s] = findVal(T,P);
        values= [P v u s];
        values_string= 'Pvus';
    elseif second_specentro == 1
        i_p= s;
        P= findP(T, i_p, 4);
        [v u h s] = findVal(T,P);
        values= [P v u h];
        values_string= 'Pvuh';
    elseif second_pressure == 1
        [v u h s] = findVal(T, P);
        values= [v u h s];
        values_string= 'vuhs';
    end
end

%if Pressure is the first property
if first_pressure == 1
    if second_temp == 1 
     [v u h s] = findVal(T, P);
     values= [v u h s];
     values_string= 'vuhs';
    elseif second_specvol == 1
        i_p= v;
        T= findT(P, i_p, 1);
        [v u h s] = findVal(T,P);
        values= [T u h s]; 
        values_string= 'Tuhs';
    elseif second_specinten == 1
        i_p= u;
        T= findT(P, i_p, 2);
        [v u h s] = findVal(T,P);
        values= [T v h s];
        values_string= 'Tvhs';
    elseif second_specenthal == 1 
        i_p= h;
        T= findT(P, i_p, 3);
        [v u h s] = findVal(T,P);
        values= [T v u s];  
        values_string= 'Tvus';
    elseif second_specentro == 1
        i_p= s;
        T= findT(P, i_p, 4);
        [v u h s] = findVal(T,P);
        values= [T v u h];
        values_string= 'Tvuh';
    end
end

% display rest of the properties
fprintf('\nThe rest of the properties are:\n\n');
answers= array2table(values, 'VariableNames',{values_string(1), values_string(2), values_string(3), values_string(4)});
disp(answers);
