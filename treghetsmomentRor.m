function rorData = treghetsmomentRor(ror)
    % Denne funksjonen beregner treghetsmomentet for r�rtverrsnitt.
    % Parameter: ror - matrise med data for et r�rtverrsnitt i hver
    %               kolonne p� formen [ID, diameter, tykkelse]
    % Returnerer: rorData - matrise med data for et r�rtverrsnitt i hver
    %               kolonne p� formen [ID, treghetsmoment, radius]
    
    [n_ror, ~] = size(ror); % antall treghetsmoment � beregne

    rorData = zeros(n_ror, 3); % preallokering
    
    % For hver av de ulike r�rtverrsnittene, beregn treghetsmoment og lengste
    % avstand fra n�ytralakse, r.
    for i = 1:n_ror    
        geomID = ror(i, 1);
        D = ror(i, 2);
        t = ror(i, 3);
        
        I = treghetsmoment(D, t);
        r = D/2;                    % Trengs for � beregne b�yespenning
        
        rorData(i, :) = [geomID I r];   
    end
end

function I = treghetsmoment(D, t)
    % Formel: I = pi/64 * (ytre_diameter^4 - indre_diameter^4)
    I = pi/64 * ( D^4 - (D-2*t)^4 );
    I = I * 10^(-12);               % Konvertere fra mm^4 -> m^4
end