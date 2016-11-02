function endemoment = endemomenter(stivheter, rot, fim, elem)
    % Denne funksjonene regner ut endemomenter for hver bjelke.

    [nElem, ~] = size(elem);            % antall elementer
    endemoment = zeros(nElem, 2);       % preallokering
    for elemID = 1:nElem
        
        stivhet = stivheter(elemID); % E*I/L
        
        m12 = fim(elemID, 1);   % fastinnspenningsmoment ende 1
        m21 = fim(elemID, 2);   % fastinnspenningsmoment ende 2
        
        p1 = elem(elemID, 1);   % knutepunkt ende 1
        p2 = elem(elemID, 2);   % knutepunkt ende 2        
        rot1 = rot(p1);         % rotasjon ende 1
        rot2 = rot(p2);         % rotasjon ende 2
        
        % Bruker formelene: M1 = 4EI/L *(rot1 + 0.5rot2) + m12
        %                   M2 = 4EI7L *(0.5rot1 + rot2) + m21
        
        M1 = 4 * stivhet * (rot1 + 0.5*rot2) + m12;   % Endemoment ende 1
        M2 = 4 * stivhet * (0.5*rot1 + rot2) + m21;   % Endemoment ende 2
        
        endemoment(elemID, :) = [M1 M2];
    end

end