function lengder = lengder(knutepunkt, element)
    % Denne funksjonen beregner lengder for elementer ved hjelp av
    % pytagoras setning.
    % returnerer: lengder - vektor med lengder for elementer
    
    [nElem, ~] = size(element); % antall elementer
    lengder = zeros(nElem,1);   % preallokering
    for i = 1:nElem
       p1 = element(i, 1);      % knutepunkt ende 1
       p2 = element(i, 2);      % knutepunkt ende 2

       % Bruker pythagoras
       dx = knutepunkt(p1, 1) - knutepunkt(p2, 1);
       dy = knutepunkt(p1, 2) - knutepunkt(p2, 2);
       lengder(i) = sqrt(dx*dx + dy*dy);
    end
end
