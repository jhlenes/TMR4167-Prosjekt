% Sletter alle variabler
clear all


% -----Leser input-data-----
[matData, geometri, punkt, elem, last] = lesinput();


% -----Regner lengder til elementene-----
elementlengder = lengder(punkt, elem);


% ------Fastinnspenningsmomentene------
% Lag funksjon selv: DONE!
fim = moment(punkt, elem, last, elementlengder);


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
