function [v u h s] = findVal(T, P)  

%function searches Table A-6 Superheated Water for thermodynamic property values 
%using constants T (Temperature) & P (Pressure)

reference = ['v' 'u' 'h' 's'];
vals = [0 0 0 0];

% for loop to cycle through sheets
for jj = 1:4
    
    % v sheet is larger than others
    if jj == 1
Table=readtable('Table_A-6_Superheated_Water.xlsx', 'Sheet', reference(jj), 'Range', 'A2:AI57', 'ReadVariableNames', false);    
else
Table=readtable('Table_A-6_Superheated_Water.xlsx', 'Sheet', reference(jj), 'Range', 'A2:K29', 'ReadVariableNames', false);
    end

    %creates Array from Table import for easier access
    Array = table2array(Table(:,:));
    Ts=table2array(Table(:,1)); % Temperature values
    Ps=table2array(Table(1,:)); % Pressure values
    
    %find Temperature and Pressure values if on table
    %if not find above and below
    T_index= find(Ts==T);
    P_index=find(Ps==P);
    if isempty(T_index)
        ii = 1;
        while isempty(T_index)
            if Ts(ii) > T
                T_index = [(ii-1),ii];
            end
            ii = ii+1;
        end
    end
    if isempty(P_index)
            ii = 1;
            while isempty(P_index)
            if Ps(ii) > P
                P_index = [(ii-1),ii];
            end
            ii = ii+1;
            end    
    end
    
    %conditionals based on whether linear interpolation will be necessary
    if (length(T_index) == 1) && (length(P_index) == 1)
        v = Array(T_index,P_index);
        vals(jj) = v;
    elseif (length(T_index) == 1) && (length(P_index) == 2)
        v1 = Array(T_index, P_index(1));
        v2 = Array(T_index, P_index(2));
        v = (v2-v1)/(Ps(P_index(2))-Ps(P_index(1)))*(P-Ps(P_index(1)))+ v1;
        vals(jj) = v;
    elseif (length(T_index) == 2) && (length(P_index) == 1)
        v1 = Array(T_index(1), P_index);
        v2 = Array(T_index(2), P_index);
        v = (v2-v1)/(Ts(T_index(2))-Ts(T_index(1)))*(T-Ts(T_index(1)))+ v1;
        vals(jj) = v;
    elseif (length(T_index) == 2) && (length(P_index) == 2)
        v1a = Array(T_index(1), P_index(1));
        v2a = Array(T_index(2), P_index(1));
        va = (v2a-v1a)/(Ts(T_index(2))-Ts(T_index(1)))*(T-Ts(T_index(1)))+ v1a;
        v1b = Array(T_index(1), P_index(2));
        if isnan(v1b)
            v1b = v1a;
        end
        v2b = Array(T_index(2), P_index(2));
        if isnan(v2b)
            v2b = v2a;
        end
        vb = (v2b-v1b)/(Ts(T_index(2))-Ts(T_index(1)))*(T-Ts(T_index(1)))+ v1b;
        v = (vb-va)/(Ps(P_index(2))-Ps(P_index(1)))*(P-Ps(P_index(1)))+ va;
            vals(jj) = v;
    end
end

% properties are accessed from the array that they were stored in
    v = vals(1);
    u = vals(2);
    h = vals(3);
    s = vals(4);
end
