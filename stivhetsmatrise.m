function K = stivhetsmatrise(stivheter, elem, punkt)
    % Denne funksjonene beregner stivhetsmatrisen for konstruksjonen.
    
    % Elementstivhetsmatriser
    kElem = [4 2; 2 4];
    
    % Stivhetsmatrisen har like mange rader og kolonner som det er punkter
    [nPunkt, ~] = size(punkt);
    K = zeros(nPunkt, nPunkt);
    
    [nElem, ~] = size(elem);
    for i = 1:nElem     % Iterer over hvert element
        p1 = elem(i, 1);
        p2 = elem(i, 2);
        stivhet = stivheter(i); % E*I/L
        
        K(p1, p1) = K(p1, p1) + stivhet * kElem(1,1);
        K(p1, p2) = K(p1, p2) + stivhet * kElem(1,2);
        K(p2, p1) = K(p2, p1) + stivhet * kElem(2,1);
        K(p2, p2) = K(p2, p2) + stivhet * kElem(2,2);
    end
end