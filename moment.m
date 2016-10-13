function fim = moment(punkt, elem, last, elementlengder)
    % Denne funksjonen beregner fastinnspenningsmomenter for alle
    % knutepunkt.
    
    [nPunkt, ~] = size(punkt);
    fim = zeros(nPunkt, 1);
    
    [nLast, ~] = size(last);
    for i=1:nLast
        elemID = last(i, 1);
        l = elementlengder(elemID);
        p1 = elem(elemID, 1);
        p2 = elem(elemID, 2);
        
        if last(i, 2) == 2 % hvis punktlast
            F = last(i, 5); % kraft
            a = last(i, 6); % avstand fra 1
            
            if punkt(p1, 3) == 1 && punkt(p2, 3) == 1  % fast innspent begge ender
                m1 = - F * a * (l-a)^2 / l^2;
                m2 =   F * a^2 * (l-a) / l^2;
            elseif punkt(p1, 3) == 1 % fast innspent venstre ende
                b = l-a; % avstand fra 2
                m1 = - F * b * (l^2 - b^2) / (2*l^2);
                m2 = 0;
            elseif punkt(p2, 3) == 1 % fast innspent høyre ende
                m1 = 0;
                m2 = F * a * (l^2 - a^2) / (2*l^2);
            else
                m1 = 0;
                m2 = 0;
            end
            
            
        elseif last(i, 2) == 1 % hvis fordelt last
            q1 = last(i, 3); % verdi fordelt last i ende 1
            q2 = last(i, 4); % verdi fordelt last i ende 2
            
            % Splitter fordelt last i to trekanter
            if punkt(p1, 3) == 1 && punkt(p2, 3) == 1  % fast innspent begge ender
                m1 = - q2 * l^2 / 30 - q1 * l^2 / 20;
                m2 = q2 * l^2 / 20 + q1 * l^2 / 30;
            elseif punkt(p1, 3) == 1 % fast innspent venstre ende
                m1 = - q1 * l^2 / 15 - 7 * q2 * l^2 / 120;
                m2 = 0;
            elseif punkt(p2, 3) == 1 % fast innspent høyre ende
                m1 = 0;
                m2 = q2 * l^2 / 15 + 7 * q1 * l^2 / 120;
            else
                m1 = 0;
                m2 = 0;
            end
        else
            error('Ikke gyldig lasttype for last %i', i);
        end
                    
        fim(p1) = fim(p1) + m1;
        fim(p2) = fim(p2) + m2;
    end
end