function rorData = treghetsmomentRor(ror)
    % Denne funksjonen beregner treghetsmomentet for et rørtverrsnitt, og
    % største avstand til nøytralakse.
    % Parameter: ror - matrise med data for et rørtverrsnitt i hver
    %               rad på formen [ID, diameter, tykkelse]
    % Returnerer: rorData - matrise med data for et rørtverrsnitt i hver
    %               rad på formen [ID, treghetsmoment, yMaks]
    
    [nRor, ~] = size(ror);     % Antall treghetsmoment å beregne
    rorData = zeros(nRor, 3);  % Preallokering
    
    % For hver av de ulike rørtverrsnittene, beregn treghetsmoment og lengste
    % avstand fra nøytralakse.
    for i = 1:nRor    
        geomID = ror(i, 1);
        D = ror(i, 2);      % Diameter
        t = ror(i, 3);      % Tykkelse
        
        I = treghetsmoment(D, t);
        r = D/2;            % Lengste avstand fra nøytralakse er lik radius
        r = r * 10^(-3);    % Konvertere fra mm -> m
        
        rorData(i, :) = [geomID I r];   
    end
end

function I = treghetsmoment(D, t)
    % Formel: I = pi/64 * (ytre_diameter^4 - indre_diameter^4)
    I = pi/64 * ( D^4 - (D-2*t)^4 );
    I = I * 10^(-12);               % Konvertere fra mm^4 -> m^4
end