function [matData, ror, iprof, punkt, elem, last] = lesinput(filnavn)
    % Denne funksjonen leser inn data om en konstruksjon fra en tekstfil.
    % Tekstfilen må være på riktig format som spesifisert i 'filformat.txt'
    % og i denne filen.

    % Åpner inputfilen
    filID = fopen(filnavn,'r');


    % Leser inn antall materialer
    nMat = fscanf(filID, '%i', [1 1]);
    % Leser inn data om materialer
    %   kol 1: MaterialID
    %   kol 2: E-modul
    %   kol 3: Flytespenning
    matData = fscanf(filID, '%i %f %f', [3 nMat])';


    % Leser inn antall rørtverrsnitt
    nRor = fscanf(filID, '%i', [1 1]);
    % Leser inn data om rørtverrsnitt
    %   kol 1: GeometriID
    %   kol 2: Diameter
    %   kol 3: Tykkelse
    ror = fscanf(filID, '%i %f %f', [3 nRor])';


    % Leser inn antall I-profiler
    nIprof = fscanf(filID, '%i', [1 1]);
    % Leser inn data om I-profil
    %   kol 1: GeometriID
    %   kol 2: Toppflens bredde
    %   kol 3: Toppflens tykkelse
    %   kol 4: Steg lengde
    %   kol 5: Steg tykkelse
    %   kol 6: Bunnflens bredde
    %   kol 7: Bunnflens tykkelse
    iprof = fscanf(filID, '%i %f %f %f %f %f %f', [7 nIprof])';


    % Leser inn antall knutepunkter
    nPunkt = fscanf(filID,'%i',[1 1]);
    % Leser inn data om knutepunkter
    % Linjenummer angir knutepunktnummer
    %   kol 1: X-koordinat
    %   kol 2: Y-koordinat
    %   kol 3: Grensebetingelse - Fri rotasjon=0, fast innspent=1
    punkt = fscanf(filID,'%f %f %i',[3 nPunkt])';


    % Leser inn antall elementer
    nElem = fscanf(filID,'%i',[1 1]);
    % Leser inn data om elementer
    % Linjenummer angir ElementID
    %   kol 1: Knutepunktnummer for lokal ende 1
    %   kol 2: Knutepunktnummer for lokal ende 2
    %   kol 3: MaterialID
    %   kol 4: GeometriID
    elem = fscanf(filID,'%i %i %i %i',[4 nElem])';


    % Leser inn antall laster 
    nLast = fscanf(filID,'%i',[1 1]);
    % Leser inn data om laster
    %   kol 1: ElementID
    %   kol 2: Load case - fordelt last=1, punktlast=2 
    %   kol 3: Hvis fordelt last så 'q_bunn' ellers 0
    %   kol 4: Hvis fordelt last så 'q_topp' ellers 0
    %   kol 5: Hvis punktlast så 'F' ellers 0
    %   kol 6: Hvis punktlast så 'avstand' ellers 0 
    last = fscanf(filID,'%i %i %f %f %f %f',[6 nLast])';

    
    % Lukker input-filen
    fclose(filID);

end
