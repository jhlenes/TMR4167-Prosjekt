clc         % rydder kommandovinduet
clear all   % Sletter alle variabler

% -----Leser input-data-----
[matData, ror, iprof, punkt, elem, last] = lesinput('input.txt');


% Regn ut treghetsmomenter for rørtverrsnitt
rorData = treghetsmomentRor(ror);
% Regn ut treghetsmoment for I-profiler
iprofData = treghetsmomentIprof(iprof);
% Samle data fra rørtverrsnitt og I-profil i 'geometri'. Format:
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
fim = fastinnspenningsmoment(punkt, elem, last, elementlengder);


% ------Setter opp lastvektor-------
% PunktID tilsvarer indeks i 'R'.
R = lastvektor(fim, punkt, elem);


% ------Setter opp systemstivhetsmatrisen-------
K = stivhetsmatrise(stivheter, elem, punkt);


% ------Innfører randbetingelser-------
[Kn, Rn] = randbetingelser(punkt, K, R);
     

% -----Løser ligningssytemet -------
rot = Kn\Rn;


% -----Finner endemoment for hvert element -------
% Lag funksjon selv
%endemoment = endeM(npunkt,punkt,nelem,elem,elementlengder,rot,fim);


% ----Skriver ut hva rotasjonen ble i de forskjellige nodene-------
disp('Rotasjonene i de ulike punktene:')
disp(rot);


% -----Skriver ut hva momentene ble for de forskjellige elementene-------
disp('Elementvis endemoment:')
%endemoment
