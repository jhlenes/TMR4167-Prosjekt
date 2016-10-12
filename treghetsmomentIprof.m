function iprofData = treghetsmomentIprof(iprof)
    % Denne funksjonen beregner treghetsmomentet for I-profiler.
    % Parameter: iprof - matrise med data for et I-profil i hver
    %               kolonne på formen [ID, b_topp, t_topp, l_steg, t_steg, b_bunn, t_bunn]
    % Returnerer: iprofData - matrise med data for et I-profil i hver
    %               kolonne på formen [ID, treghetsmoment, yMaks]

    [n_iprof, ~] = size(iprof); % antall treghetsmoment å beregne
    
    iprofData = zeros(n_iprof, 3); % preallokering
    
    % For hver av de ulike I-profilene, beregn treghetsmoment og lengste
    % avstand fra nøytralakse, y_maks.
    for i=1:n_iprof
       geomID = iprof(i,1);
       
       b_topp = iprof(i,2);
       t_topp = iprof(i,3);
       l_steg = iprof(i,4);
       t_steg = iprof(i,5);
       b_bunn = iprof(i,6);
       t_bunn = iprof(i,7);
       
       [I, y_maks] = treghetsmoment(b_topp, t_topp, l_steg, t_steg, b_bunn, t_bunn);
       
       iprofData(i, :) = [geomID, I, y_maks];     
    end
end

function [I, y_maks] = treghetsmoment(b_topp, t_topp, l_steg, t_steg, b_bunn, t_bunn)
    %Regner ut treghetsmoment for et I-profil
    
    % Arealer av toppflens, steg og bunnflens.
    a_topp = b_topp * t_topp;
    a_steg = l_steg * t_steg;
    a_bunn = b_bunn * t_bunn;

    % Avstander fra arealsenter av toppflens, steg og bunnflens til bunnen.
    y_topp = t_bunn + l_steg + t_topp/2;
    y_steg = t_bunn + l_steg/2;
    y_bunn = t_bunn/2;

    % Totalt areal
    a_tot = a_topp + a_bunn + a_steg;

    % Nøytralakseposisjon: y_c = sum(a_i*y_i)/a_tot
    y_c = (a_topp * y_topp + a_steg * y_steg + a_bunn * y_bunn) / (a_tot);
    
    
    % Lokale treghetsmoment: I = 1/12*b*h^3 for rektangel
    I_topp = 1/12 * b_topp * t_topp^3;
    I_steg = 1/12 * t_steg * l_steg^3;
    I_bunn = 1/12 * b_bunn * t_bunn^3;
    
    % Avstander fra nøytralaksen
    d_topp = y_topp - y_c;
    d_steg = y_steg - y_c;
    d_bunn = y_bunn - y_c;
    
    % Treghetsmoment er gitt av steiners teorem: I = sum(I_i+A_i*d_i^2)
    I = I_topp+a_topp*d_topp^2 + I_steg+a_steg*d_steg^2 + I_bunn+a_bunn*d_bunn^2;
    
    
    % Finner yMaks for beregning av bøyespenninger
    y_maks = max( [t_topp+l_steg+t_bunn - y_c, y_c]);
end
