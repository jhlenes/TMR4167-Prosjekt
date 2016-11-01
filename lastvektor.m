function R = lastvektor(fim, punkt, elem)
    % Denne funksjonen regner ut lastvektoren for konstruksjonen. Vi har
    % ingen konsentrerte knutepunktmomenter, slik at lastvektoren består kun
    % av fastinnspenningskrefter.
    
    [nPunkt, ~] = size(punkt);  % antall punkter
    R = zeros(nPunkt, 1);       % preallokering
    
    [nElem, ~] = size(elem);    % antall elementer
    for elemID = 1:nElem     
       p1 = elem(elemID, 1);    % knutepunkt ende 1
       p2 = elem(elemID, 2);    % knutepunkt ende 2
       
       % Fastinnspenningsmomentet med motsatt fortegn legges til verdien
       % i begge knutepunkter.
       R(p1) = R(p1) - fim(elemID, 1);   
       R(p2) = R(p2) - fim(elemID, 2);
    end
end