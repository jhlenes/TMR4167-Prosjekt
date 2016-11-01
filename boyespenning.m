function boyespenning = boyespenning(endemoment, midtmoment, elem, geometri)
    % Denne funksjonen beregner bøyespenningen i begge ender og under
    % punktlast/på midten av elementet.
    
    [nElem, ~] = size(elem);            % antall elementer
    boyespenning = zeros(nElem, 3);     % preallokering
    
    for elemID = 1:nElem
        
        geomID = elem(elemID, 4);   % Geometritype
        
        I = geometri(geomID, 2);    % Treghetsmoment
        y = geometri(geomID, 3);    % Maks avstand til nøytralakse
        
        m1 = endemoment(elemID, 1); % Moment ende 1
        mm = midtmoment(elemID);    % Moment midten/under punktlast
        m2 = endemoment(elemID, 2); % Moment ende 2
        
 
        boyespenning(elemID, 1) = m1*y/I;   % Ende 1
        boyespenning(elemID, 2) = mm*y/I;   % Midten/under punktlast
        boyespenning(elemID, 3) = m2*y/I;   % Ende 2
    end
end

