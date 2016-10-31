clc         % rydder kommandovinduet
clear all   % Sletter alle variabler

% -----Leser input-data-----
[matData, ror, iprof, punkt, elem, last] = lesinput('input_oppgave.txt');


% Regn ut treghetsmomenter for r�rtverrsnitt
rorData = treghetsmomentRor(ror);
% Regn ut treghetsmoment for I-profiler
iprofData = treghetsmomentIprof(iprof);
% Samle data fra r�rtverrsnitt og I-profil i 'geometri'. Format:
% [GeometriID, Treghetsmoment, y_global;...]
geometri = [rorData; iprofData];


% -----Regner lengder til elementene-----
% ElementID tilsvarer indeks i 'elementlengder'.
elementlengder = lengder(punkt, elem);


% -----Regner stivhet til alle elementer-----
% ElementID tilsvarer indeks i 'stivheter'.
% Stivhet = E*I/L
stivheter = elementstivhet(matData, geometri, elem, elementlengder);


% ------Fastinnspenningsmomentene------
% ElementID tilsvarer rad i 'fim'.
% Format 'fim': [m1, m2]
fim = fastinnspenningsmoment(elem, last, elementlengder);


% ------Setter opp lastvektor-------
% PunktID tilsvarer indeks i 'R'.
R = lastvektor(fim, punkt, elem);


% ------Setter opp systemstivhetsmatrisen-------
K = stivhetsmatrise(stivheter, elem, punkt);


% ------Innf�rer randbetingelser-------
[Kn, Rn] = randbetingelser(punkt, K, R);
     

% -----L�ser ligningssytemet -------
rot = Kn\Rn;


% -----Finner endemoment for hvert element -------
[endemoment, moment_rotasjon] = endemomenter(stivheter, rot, fim, elem);


% -----Finner moment under punktlaster, eller p� midten av bjelker med fordelte laster-----
midtmoment = midtmoment(last, endemoment, elementlengder, elem);


% -----Finner b�yespenninger i begge ender og under punktlast/p� midten av hver bjelke-----
boyespenning = boyespenning(endemoment, midtmoment, elem, geometri);


skjaerkraft = skjaerkraft(elem, moment_rotasjon, elementlengder, last);

fid = fopen('resultat.txt', 'w');

% ----Skriver ut hva rotasjonen ble i de forskjellige nodene-------
fprintf(fid, 'Rotasjonene i de ulike punktene i grader:\n\n');
for i = 1:length(rot)
    fprintf(fid, 'Punkt %2i: %10.4f\n', i, rot(i)*180/pi);
end
fprintf('\n\n');


% -----Skriver ut hva skj�rkreftene ble for de forskjellige elementene-------
fprintf(fid, 'Skj�rkraft for hvert element [kN] (positiv retning med urviser):\n\n');
fprintf(fid, '%12s%10s      %10s\n', ' ', 'Ende 1', 'Ende 2');
[nElem, ~] = size(elem);
for elemID = 1:nElem
   fprintf(fid, 'Element %2i: %10.1f      %10.1f\n', elemID, ...
       skjaerkraft(elemID, 1)*1e-03, skjaerkraft(elemID, 2)*1e-03); 
end
fprintf(fid, '\n\n');


% -----Skriver ut hva momentene ble for de forskjellige elementene-------
fprintf(fid, 'Momenter for hvert element [kNm]:\n\n');
fprintf(fid, '%12s%10s      %10s      %10s\n', ' ', 'Ende 1', 'Midten', 'Ende 2');
[nElem, ~] = size(elem);
for elemID = 1:nElem
   fprintf(fid, 'Element %2i: %10.1f      %10.1f      %10.1f\n', elemID, ...
       endemoment(elemID, 1)*1e-03, midtmoment(elemID)*1e-03, endemoment(elemID, 2)*1e-03); 
end
fprintf(fid, '\n\n');


%-----Skriver ut b�yespenninger
fprintf(fid, 'B�yespenninger for hvert element [MPa]:\n\n');
fprintf(fid, '%12s%10s      %10s      %10s\n', ' ', 'Ende 1', 'Midten', 'Ende 2');
for elemID = 1:nElem
    
    fprintf(fid, 'Element %2i: %10.1f      %10.1f      %10.1f\n', elemID, ...
        boyespenning(elemID, 1)*1e-06, boyespenning(elemID,2)*1e-06, boyespenning(elemID, 3)*1e-06);    
end
