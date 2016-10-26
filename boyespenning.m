function boyespenning = boyespenning(endemoment, midtmoment, elem, geometri, matData)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    [nElem, ~] = size(elem);
    boyespenning = zeros(nElem, 3); % Inneholder bøyespenning: [ende 1, midten/under punktlast, ende 2]
    
    for elemID = 1:nElem
        
        matID = elem(elemID, 3);    % Materialtype
        geomID = elem(elemID, 4);   % Geometritype
        
        fy = matData(matID, 3);     % Flytespenning
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

