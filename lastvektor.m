function b = lastvektor(fim, punkt, elem)
    % Denne funksjonen regner ut lastvektoren for konstruksjonen. Vi har
    % ingen konsentrerte knutepunktmomenter, slik at lastvektoren består kun
    % av fastinnspenningskrefter.
    
    % Lastvektoren har like mange elementer som det er punkter i
    % konstruksjonen
    [nPunkt, ~] = size(punkt);
    b = zeros(nPunkt, 1);
    
    [nElem, ~] = size(elem);
    for i = 1:nElem     % Iterer over hvert element
       p1 = elem(i, 1);
       p2 = elem(i, 2);
       
       % Fastinnspenningsmomentet med motsatt fortegn legges til verdien
       % i begge knutepunkter.
       b(p1) = b(p1) - fim(i, 1);   
       b(p2) = b(p2) - fim(i, 2);
    end
end