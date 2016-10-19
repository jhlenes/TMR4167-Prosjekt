function endemoment = endemomenter(stivheter, rot, fim, elem)
    % Denne funksjonene regner ut endemomenter for hver bjelke.
    % returnerer: endemoment - Matrise der hver rad representerer et element
    %           og er på formen: [Endemoment_ende_1, Endemoment_ende_2].

    [nElem, ~] = size(elem);
    endemoment = zeros(nElem, 2);
    for i = 1:nElem     % Itererer over hvert element
        
        stivhet = stivheter(i); % E*I/L
        
        m12 = fim(i, 1);    % fastinnspenningsmoment ende 1
        m21 = fim(i, 2);    % fastinnspenningsmoment ende 2
        
        p1 = elem(i, 1);    % punkt ende 1
        p2 = elem(i, 2);    % punkt ende 2        
        rot1 = rot(p1);     % rotasjon ende 1
        rot2 = rot(p2);     % rotasjon ende 2
        
        % Bruker formelen: M1 = 4EI/L *(rot1 + 0.5rot2) + m12
        %                  M2 = 4EI7L *(0.5rot1 + rot2) + m21
        M1 = 4 * stivhet * (rot1 + 0.5*rot2) + m12; % Endemoment ende 1
        M2 = 4 * stivhet * (0.5*rot1 + rot2) + m21; % Endemoment ende 2
        
        endemoment(i, :) = [M1 M2];
    end

end