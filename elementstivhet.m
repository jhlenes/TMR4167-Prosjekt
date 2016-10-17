function stivheter = elementstivhet(matData, geometri, elem, elementlengder)
    % Denne funksjonen regner ut stivheten, EI/L, for alle elementer. 
    
    [nElem, ~] = size(elem);
    stivheter = zeros(nElem, 1);
    for i = 1:nElem
        matID = elem(i, 3);
        E = matData(matID, 2);      % E-modul
        
        geomID = elem(i, 4);
        I = geometri(geomID, 2);    % Treghetsmoment
        
        L = elementlengder(i);      % Lengde
        
        stivheter(i) = E*I/L;
    end
end