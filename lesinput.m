function [matData, geometri, punkt, elem, last] = lesinput(filnavn)

% Denne funksjonen leser inn data om en konstruksjon fra en tekstfil.
% Tekstfilen m� v�re p� formatet spesifisert nedenfor.

% �pner inputfilen
filID = fopen(filnavn,'r');


% Leser inn antall materialer
nMat = fscanf(filID, '%i', [1 1]);

% Leser inn data om materialer
%   kol 1: MaterialID
%   kol 2: E-modul
%   kol 3: flytespenning
matData = fscanf(filID, '%i %f %f', [3 nMat])';


% Leser inn antall r�rtverrsnitt
nRor = fscanf(filID, '%i', [1 1]);

% Leser inn data om r�rtverrsnitt
%   kol 1: GeometriID
%   kol 2: Diameter
%   kol 3: Tykkelse
ror = fscanf(filID, '%i %f %f', [3 nRor])';

% Regn ut treghetsmoment for r�r
rorData = treghetsmomentRor(ror);


% Leser inn antall I-profiler
nIprof = fscanf(filID, '%i', [1 1]);

% Leser inn data om I-profil
%   kol 1: GeometriId
%   kol 2: Toppflens bredde
%   kol 3: Toppflens tykkelse
%   kol 4: Steg lengde
%   kol 5: Steg tykkelse
%   kol 6: Bunnflens bredde
%   kol 7: Bunnflens tykkelse

iprof = fscanf(filID, '%i %f %f %f %f %f %f', [7 nIprof])';

% Regn ut treghetsmoment for I-profil
iprofData = treghetsmomentIprof(iprof);

% Samle data fra r�rtverrsnitt og I-profil
geometri = [rorData; iprofData];


% Leser inn antall knutepunkter
npunkt = fscanf(filID,'%i',[1 1]);

% Leser inn data om knutepunkter
% Nodenummer tilsvarer radnummer i "punkt-variabelen"
%   kol 1: X-koordinat
%   kol 2: Y-koordinat
%   kol 3: Grensebetingelse. fri rotasjon=0 og fast innspent=1
punkt = fscanf(filID,'%f %f %i',[3 npunkt])';


% Leser inn antall elementer
nelem = fscanf(filID,'%i',[1 1]);

% Leser inn data om elementer: Konnektivitet og materialdata.
% Elementnummer tilsvarer radnummer i "elem-variabelen"
%   kol 1: Knutepunktnummer for lokal ende 1
%   kol 2: Knutepunktnummer for lokal ende 2
%   kol 3: MaterialID.
%   kol 4: GeometriID.
elem = fscanf(filID,'%i %i %i %i',[4 nelem])';


% Leser inn antall laster 
nlast = fscanf(filID,'%i',[1 1]);

% Les inn data om laster

% Bestem selv hvilke verdiene som er n�dvendig � lese inn, og hva verdiene som leses inn
%skal representere

%   kol 1: Elementnummer
%   kol 2: Load case, 1=fordelt last 2=punktlast 
%   kol 3: Hvis 1 s� 'q_bunn' ellers 0
%   kol 4: Hvis 1 s� 'q_topp' ellers 0
%   kol 5: Hvis 2 s� 'F' ellers 0
%   kol 6: Hvis 2 s� 'avstand' ellers
last = fscanf(filID,'%i %i %f %f %f %f',[6 nlast])';

% LUKKER INPUT-FILEN
fclose(filID);

end
