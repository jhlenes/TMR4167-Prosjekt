function skjaerkraft = skjaerkraft(elem, moment_rotasjon, elementlengder, last)
    % Denne funksjonen beregner skjærkrefter i begge ender for alle
    % elementer. Positiv retning med urviser.
    
    [nElem, ~] = size(elem);        % antall elementer
    skjaerkraft = zeros(nElem, 2);  % preallokering
    
    for elemID = 1:nElem 
        %Regner ut -(Mij+Mji)/L for hvert element
        Q_1 = -(moment_rotasjon(elemID, 1) + moment_rotasjon(elemID, 2)) / elementlengder(elemID,1);
        
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
            
            % Skjærkraft beregnes med momentlikevekt.
            Q_0 = [q1*L/3 + q2*L/6, -q1*L/6 - q2*L/3];
            
            skjaerkraft(elemID, :) = skjaerkraft(elemID, :) + Q_0;
        end
        
    end

end