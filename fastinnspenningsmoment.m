function fim = fastinnspenningsmoment(elem, last, elementlengder)
    % Denne funksjonen beregner fastinnspenningsmomenter for alle elementer
    % i begge endepunkt. Fungerer kun for fordelte laster og punktlaster.
    
    [nElem, ~] = size(elem);
    fim = zeros(nElem, 2);
    
    [nLast, ~] = size(last);
    for i=1:nLast
        elemID = last(i, 1);
        l = elementlengder(elemID);
        
        if last(i, 2) == 2 % hvis punktlast
            F = last(i, 5); % kraft
            a = last(i, 6); % avstand fra 1
            
            m1 = - F * a * (l-a)^2 / l^2;
            m2 =   F * a^2 * (l-a) / l^2;
            
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