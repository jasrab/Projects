function P = findP(T, i_p, n)

%script searches Table A-6 Superheated Water for Pressure value 
%given user input for Temperature + additional thermodynamic property

% T is Temperature
% i_p is the value of the other intensive property being used
%the n argument is used to denote which property is being used in addition
%to Temperature

% n = 1 (v)
% n = 2 (u)
% n = 3 (h)
% n = 4 (s)

reference = ['v' 'u' 'h' 's'];

% Read correct sheet
if n == 1
Table=readtable('Table_A-6_Superheated_Water.xlsx', 'Sheet', reference(n), 'Range', 'A2:AI57', 'ReadVariableNames', false);    
else
Table=readtable('Table_A-6_Superheated_Water.xlsx', 'Sheet', reference(n), 'Range', 'A2:K29', 'ReadVariableNames', false);
end

%creates Array from Table import for easier access
Array = table2array(Table(:,:));
    
%find Temperature value if on table
%if not find above and below
    Ts=table2array(Table(:,1));
    T_index= find(Ts==T);
      if isempty(T_index)
        ii = 1;
        while isempty(T_index)
            if Ts(ii) > T
                T_index = [(ii-1),ii];
            end
            ii = ii+1;
        end  
      end
    
    %adjust Array boundaries for proper indexing
    Array = Array(:,2:end);
    
    %access necessary values from the table
    %Note: v is used as placeholder name but it could be u, h, or s values
    %being used
    vs = Array(T_index(:),:);
    
    %if 2 rows interpolate between them
    if length(T_index) == 2
    vs_new = [];
   
    b=10; %conditional for v sheet
    if n == 1
        b = 34;
    end
        for ii = 1:b
        vs_new(ii) = (vs(2,ii)-vs(1,ii))/(Ts(T_index(2))-Ts(T_index(1)))*(T-Ts(T_index(1)))+ vs(1,ii);
        end
    vs = vs_new;
    end
    
    % find intensive property value if possible
    % if not find above and below
    v_index = find(vs == i_p);
    if isempty(v_index)
        ii = 1;
        while isempty(v_index)
            if vs(ii) < i_p
                v_index = [(ii-1),ii];
            end
            ii = ii+1;
        end  
        if v_index(1) == 0
            v_index = [1];
        end
    end
    
    %conditionals to find P
    if length(v_index) == 2 % values above and below intensive property value were found
        P = ((Array(1,v_index(2))-Array(1,v_index(1)))/(vs(v_index(2))-vs(v_index(1)))*(i_p-vs(v_index(1)))+ Array(1,v_index(1)));
    end
    if length(v_index) == 1 % exact intensive property value was found
        P = Array(1, v_index);
    end
end

