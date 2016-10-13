function svar = lengder(knutepunkt, element)
    % Denne funksjonen beregner lengder for elementer ved hjelp av
    % pytagoras setning.
    
    [nElem, ~] = size(element);
    svar=zeros(nElem,1);
    for i=1:nElem
       p1 = element(i, 1);
       p2 = element(i, 2);

       dx = knutepunkt(p1, 1) - knutepunkt(p2, 1); % x1 - x2
       dy = knutepunkt(p1, 2) - knutepunkt(p2, 2); % y1 - y2

       svar(i) = sqrt(dx*dx + dy*dy);
    end
end
