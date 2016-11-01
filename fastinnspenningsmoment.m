function fim = fastinnspenningsmoment(elem, last, elementlengder)
    % Denne funksjonen beregner fastinnspenningsmomenter for alle elementer
    % i begge endepunkt.
    
    [nElem, ~] = size(elem);    % antall elementer
    fim = zeros(nElem, 2);      % preallokering
    
    [nLast, ~] = size(last);    % antall laster
    for i=1:nLast
        elemID = last(i, 1);    % elementet lasten virker p�
        l = elementlengder(elemID); % lengde av element
        
        if last(i, 2) == 2 % hvis punktlast
            F = last(i, 5); % kraft
            a = last(i, 6); % avstand fra ende 1
            b = l - a;      % avstand fra ende 2
            
            m1 = - F * a * b^2 / l^2;
            m2 =   F * a^2 * b / l^2;
            
        elseif last(i, 2) == 1 % hvis fordelt last
            q1 = last(i, 3); % verdi fordelt last i ende 1
            q2 = last(i, 4); % verdi fordelt last i ende 2
            
            % Splitter fordelt last i to trekanter
            m1 = - q2 * l^2 / 30 - q1 * l^2 / 20;
            m2 = q2 * l^2 / 20 + q1 * l^2 / 30;

        end
        
        fim(elemID, :) = [m1, m2];
    end
end