function [Kn, Bn] = randbetingelser(punkt, K, b)
    % Denne funksjonen innfører grensebetingelser ilagt knutepunktene til
    % systemstivhetsmatrisen.
    
    % Lag kopier
    Kn = K;
    Bn = b;
    
    [nPunkt, ~] = size(punkt);
    for i = 1:nPunkt
       if punkt(i, 3) == 1              % hvis fast innspent
           Kn(i, :) = zeros(1, nPunkt); % Null ut rad i
           Kn(:, i) = zeros(nPunkt, 1); % Null ut kolonne i
           Kn(i, i) = 1;                % Sett diagonalelement lik 1
           Bn(i) = 0;                   % Null ut lastvektorelementet
       end        
    end
end