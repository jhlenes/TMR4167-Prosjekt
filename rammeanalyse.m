clc         % rydder kommandovinduet
clear all   % Sletter alle variabler

% ----- Leser input-data -----
[matData, ror, iprof, punkt, elem, last] = lesinput('input_oppgave.txt');


% ----- Beregner treghetsmomenter og avstander til n�ytralakser -----
% Regner ut treghetsmomenter for r�rtverrsnitt
rorData = treghetsmomentRor(ror);
% Regner ut treghetsmomenter for I-profiler
iprofData = treghetsmomentIprof(iprof);
% Samle data fra r�rtverrsnitt og I-profil i 'geometri'. Hver rad
% representerer et tverrsnitt p� formen [GeometriID, Treghetsmoment, y_maks]
geometri = [rorData; iprofData];


% ----- Beregner lengder til elementene -----
% ElementID tilsvarer indeks i 'elementlengder'.
elementlengder = lengder(punkt, elem);


% ----- Beregner stivheter (E*I/L) til alle elementer -----
% ElementID tilsvarer indeks i 'stivheter'.
stivheter = elementstivhet(matData, geometri, elem, elementlengder);


% ------ Beregner fastinnspenningsmomentene til alle elementer ------
% ElementID tilsvarer rad i 'fim'.
% fim - matrise der hver rad er p� formen [fastinnspeningsmoment_ende_1, fastinnspeningsmoment_ende_2]
fim = fastinnspenningsmoment(elem, last, elementlengder);


% ------ Setter opp lastvektor -------
% PunktID tilsvarer indeks i 'R'.
R = lastvektor(fim, punkt, elem);


% ------ Setter opp systemstivhetsmatrisen -------
K = stivhetsmatrise(stivheter, elem, punkt);


% ------ Innf�rer randbetingelser p� systemstivhetsmatrisen-------
[Kn, Rn] = randbetingelser(punkt, K, R);
     

% ----- L�ser ligningssytemet -------
rot = Kn\Rn;


% ----- Finner endemoment for hvert element -------
endemoment = endemomenter(stivheter, rot, fim, elem);


% ----- Finner moment under punktlaster, eller p� midten av bjelker med fordelte laster -----
midtmoment = midtmoment(last, endemoment, elementlengder, elem);


% ----- Finner b�yespenninger i begge ender og under punktlast/p� midten av hver bjelke -----
boyespenning = boyespenning(endemoment, midtmoment, elem, geometri);


skjaerkraft = skjaerkraft(elem, endemoment, elementlengder, last);


%----- Skriver ut resultat til 'resultat.txt' -----

% �pner filen
fid = fopen('resultat.txt', 'w');

% Skriver ut hva rotasjonen ble i de forskjellige nodene
fprintf(fid, 'Rotasjonene i de ulike punktene i grader:\n\n');
for i = 1:length(rot)
    fprintf(fid, 'Punkt %2i: %10.4f\n', i, rot(i)*180/pi);
end
fprintf(fid, '\n\n');


% Skriver ut hva skj�rkreftene ble for de forskjellige elementene
fprintf(fid, 'Skj�rkraft for hvert element [kN] (positiv retning med urviser):\n\n');
fprintf(fid, '%12s%10s      %10s\n', ' ', 'Ende 1', 'Ende 2');
[nElem, ~] = size(elem);
for elemID = 1:nElem
   fprintf(fid, 'Element %2i: %10.1f      %10.1f\n', elemID, ...
       skjaerkraft(elemID, 1)*1e-03, skjaerkraft(elemID, 2)*1e-03); 
end
fprintf(fid, '\n\n');


% Skriver ut hva momentene ble for de forskjellige elementene
fprintf(fid, 'Momenter for hvert element [kNm]:\n\n');
fprintf(fid, '%12s%10s      %10s      %10s\n', ' ', 'Ende 1', 'Midten', 'Ende 2');
[nElem, ~] = size(elem);
for elemID = 1:nElem
   fprintf(fid, 'Element %2i: %10.1f      %10.1f      %10.1f\n', elemID, ...
       endemoment(elemID, 1)*1e-03, midtmoment(elemID)*1e-03, endemoment(elemID, 2)*1e-03); 
end
fprintf(fid, '\n\n');


% Skriver ut b�yespenninger
fprintf(fid, 'B�yespenninger for hvert element [MPa]:\n\n');
fprintf(fid, '%12s%10s      %10s      %10s      %10s\n', ' ', 'Ende 1', 'Midten', 'Ende 2', '% av fy');
for elemID = 1:nElem
    matID = elem(elemID, 3);    % material
    fy = matData(matID, 3);     % flytespenning
    maksProsent = max(abs(boyespenning(elemID, :))) / fy * 100; % prosent av flytespenning
    
    fprintf(fid, 'Element %2i: %10.1f      %10.1f      %10.1f      %10.1f\n', elemID, ...
        boyespenning(elemID, 1)*1e-06, boyespenning(elemID,2)*1e-06, boyespenning(elemID, 3)*1e-06, maksProsent);    
end

% Lukk filen
fclose(fid);


% Skriv til command window
fprintf('Resultatet er lagret i ''resultat.txt''\n\n');
