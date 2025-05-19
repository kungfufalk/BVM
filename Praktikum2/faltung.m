% Faltung eines Bildes I mit Faltungskern H zu K, die Ränder werden abgeschnitten
%
% K=faltung(I, H)  I=Eingangsbildmatrix
%                  H=Faltungskern
%                  K=gefaltete Bildmatrix
%

function K=faltung(I, H)

[faltung_hoehe, faltung_breite]=size(H);

if mod(faltung_hoehe, 2) ~= 0 && mod(faltung_breite, 2) ~= 0 % Prüfung auf ungeraden Faltungskern

    % liefert die Groesse des Bildes
    [hoehe,breite]=size(I);

    
    % Abstand von dem mittleren Element des Faltungskerns zu dem Rand des
    % Faltungskerns (exklusive des mittleren Elements)
    b = (faltung_breite - 1)/2;

    % Abstand von dem mittleren Element des Faltungskerns zu dem Rand des
    % Faltungskerns (inklusive des mittleren Elements)
    delta_h = b + 1;
    
    % Bild von uint8 in double konvertieren
    I=double(I);
    H=double(H);
    
    % Ränder werden oben, unten, links und rechts bei Faltung abgeschnitten
    % z.B. Faltungskern ist 5x5 -> es werden JEWEILS oben und unten zwei
    % Elemente abgeschnitten
    % K = double(zeros(hoehe-(2*b), breite-(2*b)));
    K = double(zeros(hoehe, breite));
    
    % Startindex in dem Eingabebild ab überschneidungsfreiem Pixel mit 
    % Faltungskern und Rand
    start_index = 1 + b;
    stop_index_breite = breite - b;
    stop_index_hoehe = hoehe - b;

    % Faltung des Bildes I in das Bild K
    for m=start_index:stop_index_hoehe
        for n=start_index:stop_index_breite
            g_tilde = 0;
            for i=-b:b
                for j=-b:b
                    g_tilde = g_tilde + (H(-i + delta_h, -j + delta_h) * I(m + i, n + j));
                end
            end
            K(m-b, n-b) = g_tilde;
        end
    end

else
    K = I;
    disp("Faltungsmatrix hat keine ungerade Höhe und Breite!");
end
% falls das invertierte Bild K sofort hier angezeigt werden soll 
% figure,imshow(K),