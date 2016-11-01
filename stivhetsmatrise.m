function K = stivhetsmatrise(stivheter, elem, punkt)
    % Denne funksjonene setter opp stivhetsmatrisen for konstruksjonen.
    
    % Elementstivhetsmatriser
    kElem = [4 2; 2 4];
    
    % Stivhetsmatrisen har like mange rader og kolonner som det er punkter
    [nPunkt, ~] = size(punkt);  % antall punkter
    K = zeros(nPunkt, nPunkt);  % preallokering
    
    [nElem, ~] = size(elem);    % antall elementer
    for elemID = 1:nElem
        p1 = elem(elemID, 1);   % knutepunkt ende 1
        p2 = elem(elemID, 2);   % knutepunkt ende 2
        stivhet = stivheter(elemID);    % Bjelkestivheten: E*I/L
        
        % Elementene i den lokale stivhetsmatrisen adderes til den globale
        K(p1, p1) = K(p1, p1) + stivhet * kElem(1,1);
        K(p1, p2) = K(p1, p2) + stivhet * kElem(1,2);
        K(p2, p1) = K(p2, p1) + stivhet * kElem(2,1);
        K(p2, p2) = K(p2, p2) + stivhet * kElem(2,2);
    end
end