function [npunkt punkt nelem elem nlast last]=lesinput()


%       %i = heltall (integer)       %f : desimaltall (flyt-tall)


%åpner inputfila
filid = fopen('input.txt','r');


%Leser hvor mange punkt det er
npunkt = fscanf(filid,'%i',[1 1])


% LESER INN XY-KOORDINATER TIL KNUTEPUNKTENE
% Nodenummer tilsvarer radnummer i "Node-variabel"
% x-koordinat lagres i første kolonne, y-koordinat i 2.kolonne
% Grensebetingelse lagres i kolonne 3, fast innspent=1 og fri rotasjon=0
punkt = fscanf(filid,'%f %f %i',[3 npunkt])'


%Leser hvor mange element det er
nelem = fscanf(filid,'%i',[1 1])


%Leser konnektivitet: sammenheng elementender og knutepunktnummer. Og EI for elementene
% Elementnummer tilsvarer radnummer i "Elem-variabel"
% Knutepunktnummer for lokal ende 1 lagres i kolonne 1
% Knutepunktnummer for lokal ende 2 lagres i kolonne 2
% E-modul for materiale lagres i kolonne 3
% Tverrsnittstype lagres i kolonne 4, I-profil=1 og rørprofil=2  
elem = fscanf(filid,'%i %i %f %i',[4 nelem])'


%Les hvor mange laster som virker. 
nlast = fscanf(filid,'%i',[1 1])


%Les lastdata
% Bestem selv hvilke verdiene som er nødvendig å lese inn, og hva verdiene som leses inn
%skal representere
last = fscanf(filid,'%i %f %f %f',[4 nlast])'



% LUKKER INPUT-FILEN
fclose(filid);




end
