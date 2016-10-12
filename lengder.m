function svar=lengder(knutepunkt,element,nelem)


svar=zeros(nelem,1);

% Beregner elementlengder
for i=1:nelem
   dx = knutepunkt(element(i,1),1)-knutepunkt(element(i,2),1);
   dy = knutepunkt(element(i,1),2)-knutepunkt(element(i,2),2);
   svar(i) = sqrt(dx*dx + dy*dy);
end


end
