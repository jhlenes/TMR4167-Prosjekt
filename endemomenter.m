function [endemoment, moment_rotasjon] = endemomenter(stivheter, rot, fim, elem)
    % Denne funksjonene regner ut endemomenter for hver bjelke.
    % returnerer: endemoment - Matrise der hver rad representerer et element
    %           og er på formen: [Endemoment_ende_1, Endemoment_ende_2].

    [nElem, ~] = size(elem);
    endemoment = zeros(nElem, 2);
    moment_rotasjon = zeros(nElem, 2);
    for i = 1:nElem     % Itererer over hvert element
        
        % Bruker formelene: M1 = 4EI/L *(rot1 + 0.5rot2) + m12
        %                   M2 = 4EI7L *(0.5rot1 + rot2) + m21
        
        stivhet = stivheter(i); % E*I/L
        
        m12 = fim(i, 1);    % fastinnspenningsmoment ende 1
        m21 = fim(i, 2);    % fastinnspenningsmoment ende 2
        
        p1 = elem(i, 1);    % punkt ende 1
        p2 = elem(i, 2);    % punkt ende 2        
        rot1 = rot(p1);     % rotasjon ende 1
        rot2 = rot(p2);     % rotasjon ende 2
        
        % Moment fra roatasjoner
        m1rot = 4 * stivhet * (rot1 + 0.5*rot2);
        m2rot = 4 * stivhet * (0.5*rot1 + rot2);
        
        M1 = m1rot + m12; % Endemoment ende 1
        M2 = m2rot + m21; % Endemoment ende 2
        
        endemoment(i, :) = [M1 M2];
        moment_rotasjon(i, :) = [m1rot, m2rot]; % Brukes til å beregne skjærspenninger
    end

end