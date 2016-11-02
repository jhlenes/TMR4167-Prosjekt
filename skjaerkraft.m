function skjaerkraft = skjaerkraft(elem, endemoment, elementlengder, last)
    % Denne funksjonen beregner skjærkrefter i begge ender for alle
    % elementer. Positiv retning med urviser.
    
    [nElem, ~] = size(elem);        % antall elementer
    skjaerkraft = zeros(nElem, 2);  % preallokering
    
    % Regner ut skjærkrefter for elementer uten laster, dette blir
    % overskrevet for elementer med fordelte laster.
    for elemID = 1:nElem 
        %Regner ut -(Mij+Mji)/L for hvert element
        Q_1 = -(endemoment(elemID, 1) + endemoment(elemID, 2)) / elementlengder(elemID,1);
        
        skjaerkraft(elemID, :) = [Q_1, Q_1];
    end

    % Regner ut Q0 for elementer laster
    [nLast, ~] = size(last);    % antall laster    
    for i = 1:nLast
        
        elemID = last(i, 1);        % element
        L = elementlengder(elemID); % lengde
        
        if last(i, 2) == 2 % hvis punktlast
        
            P = last(i, 5); % kraft
            a = last(i, 6); % avstand ende 1
            b = L - a;      % avstand ende 2
            
            % Skjærkraft beregnes med momentlikevekt.
            Q_0 = [P*b/L, -P*a/L];
            
            skjaerkraft(elemID, :) = skjaerkraft(elemID, :) + Q_0;
            
        elseif last(i, 2) == 1 % hvis fordelt last
            
            q1 = last(i, 3);    % Fordelt last ende 1
            q2 = last(i, 4);    % Fordelt last ende 2
            
            % Skjærkraft fra endemomenter
            Q_1 = -(endemoment(elemID, 1) + endemoment(elemID, 2)) / elementlengder(elemID,1);
            
            % Skjærkraft beregnes med momentlikevekt. Splitter fordelt last
            % i firkant og trekant.
            [maksQ, index] = max([q1, q2]);
            minQ = min([q1, q2]);
            
            if index == 1   % hvis maks i ende 1
                Q_0(1) = Q_1 + minQ*L/2 + (maksQ-minQ)*L/3;
                Q_0(2) = -((minQ+maksQ)/2*L - Q_0(1));
            elseif index == 2  % maks i ende 2
                Q_0(1) = Q_1 + minQ*L/2 + (maksQ-minQ)*L/6;
                Q_0(2) = -((minQ+maksQ)/2*L - Q_0(1));   
            end
            
            skjaerkraft(elemID, :) = Q_0;
        end
        
    end

end