function midtmoment = midtmoment(last, endemoment, elementlengder, elem)
    % Denne funksjonen regner ut momentet på midten av bjelker pålastet fordelte
    % laster, og under punktlasten for bjelker pålastet punktlaster.

    [nElem, ~] = size(elem);
    midtmoment = zeros(nElem, 1);   % Midtmoment lagres for hvert element
    
    % Regn ut momentet på midten for alle elementer som ikke har noen last
    for elemID = 1:nElem    % Iterer over hvert element  
        if midtmoment(elemID) == 0  % Hvis ingen last på dette elementet
            
            M1 = endemoment(elemID, 1); % Endemoment ende 1
            M2 = endemoment(elemID, 2); % Endemoment ende 2
            
            % Moment på midten pga endemomenter er eneste bidrag
            midtmoment(elemID) = M1/2 - M2/2;
        end
    end    
    
    % Hvis elementet er påsatt en last vil beregningene ovenfor overskrives
    [nLast, ~] = size(last);
    for i = 1:nLast     % Iterer over hver last
        
        elemID = last(i, 1);        % ElementID
        L = elementlengder(elemID); % Lengde av element
        
        M1 = endemoment(elemID, 1); % Endemoment ende 1
        M2 = endemoment(elemID, 2); % Endemoment ende 2
        
        if last(i, 2) == 2 % hvis punktlast
            F = last(i, 5); % Kraft
            a = last(i, 6); % Avstand ende 1
            b = L-a;        % Avstand ende 2
            
            % Moment under punktlast pga punktlast
            m1 = F*a*b/L;
        
            % Moment under punktlast pga endemomenter
            m2 = M1/L * b - M2/L * a;
            
            % Totalt midtmoment er summen av m1 og m2
            midtmoment(elemID) = m1 + m2;   
            
        elseif last(i, 2) == 1  % hvis fordelt last
            % Fordelte laster er delt opp i to trekanter:
            q1 = last(i, 3);    % Fordelt last ende 1
            q2 = last(i, 4);    % Fordelt last ende 2
            
            % Moment på midten pga fordelt last
            m1 = q1*L^2/16 + q2*L^2/16;
            
            % Moment på midten pga endemomenter
            m2 = M1/2 - M2/2;
            
            % Totalt midtmoment er summen av m1 og m2
            midtmoment(elemID) = m1 + m2; 
            
        end
       
    end
    
    
    
end

