function [Kn, Rn] = randbetingelser(punkt, K, R)
    % Denne funksjonen innfører grensebetingelser ilagt knutepunktene på
    % systemstivhetsmatrisen.
    
    % Lag kopier
    Kn = K;
    Rn = R;
    
    [nPunkt, ~] = size(punkt);  % antall punkt
    for i = 1:nPunkt
       if punkt(i, 3) == 1              % hvis fast innspent
           Kn(i, :) = zeros(1, nPunkt); % Null ut rad i
           Kn(:, i) = zeros(nPunkt, 1); % Null ut kolonne i
           Kn(i, i) = 1;                % Sett diagonalelement lik 1
           Rn(i) = 0;                   % Null ut lastvektorelementet
       end        
    end
end