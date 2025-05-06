% Verkleinerung eines Bildes um die Hälfte oder ein Viertel
%
% K=resizeimage(I)  I=Eingangsbildmatrix
%                   K=invertierte Bildmatrix
%
% diese ersten Kommentarzeilen vor der eigentlichen Funktion werden von
% 'help resizeimage' angezeigt

function K=resizeimage(I)

% einlesen einer Variable
stepsize=input('Verkleinerungsfaktor = ');

if mod(stepsize, 2) == 0 % Prüfung auf geraden Teilungsfaktor
    
    % liefert die Groesse des Bildes
    [hoehe,breite]=size(I);
    anz=hoehe*breite;
    
    % Bild von uint8 in double konvertieren
    I=double(I);
    
    K = zeros(hoehe/stepsize, breite/stepsize);
    
    % Verkleinerung des Bildes I in das Bild K
    for i=1:stepsize:hoehe-stepsize % Sprünge durch das Bild von der Größe stepsize
        for j=1:stepsize:breite-stepsize
            mittelwert = sum(sum(I(i:i+stepsize-1, j:j+stepsize-1)))/(stepsize*stepsize);
            n = (i + stepsize-1)/stepsize;
            m = (j + stepsize -1) / stepsize;
            K(n,m) = mittelwert;
        end
    end
    
    % Ergebnisbild von double in uint8 konvertieren
    K=uint8(K);

else
    K = I;
    disp("Verkleinerungsfaktor ist ungerade!");
end
% falls das invertierte Bild K sofort hier angezeigt werden soll 
% figure,imshow(K),