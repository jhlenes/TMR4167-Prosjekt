% Sletter alle variabler
clear all


% -----Leser input-data-----
[npunkt punkt nelem elem nlast last] = lesinput();


% -----Regner lengder til elementene-----
elementlengder=lengder(punkt,elem,nelem)


% ------Fastinnspenningsmomentene------
% Lag funksjon selv
fim=moment(npunkt,punkt,nelem,elem,nlast,last,elementlengder);


% ------Setter opp lastvektor-------
% Lag funksjon selv
b=lastvektor(fim,npunkt,punkt,nelem,elem);


% ------Setter opp systemstivhetsmatrisen-------
% Lag funksjon selv
K=stivhet(nelem,elem,elementlengder,npunkt);


% ------Innfoerer randbetingelser-------
% Lag funksjon selv
[Kn Bn] = bc(npunkt, punkt, K, b);
     

% -----Løser ligningssytemet -------
% Lag funksjon selv
rot = Kn\Bn;


% -----Finner endemoment for hvert element -------
% Lag funksjon selv
endemoment=endeM(npunkt,punkt,nelem,elem,elementlengder,rot,fim);


% ----Skriver ut hva rotasjonen ble i de forskjellige nodene-------
disp('Rotasjonane i de ulike punkta:')
rot


% -----Skriver ut hva momentene ble for de forskjellige elementene-------
disp('Elementvis endemoment:')
endemoment
