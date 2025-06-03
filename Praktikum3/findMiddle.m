function V = findMiddle(I, minWidth, lineScan_Row)
%findMiddle findet die Mittlepunkte der Gefäße über die Binarisierung des
%Bildes mit Otsu

level = graythresh(I);
BW = imbinarize(I,level);

[~, breite] = size(BW);

V = [];

glas = 0;

%minWidth = 125;

%lineScan_Row = 540;

i = 1;
while i < breite
    glasbreite = 0;
    if (i+minWidth) <= breite
        if BW(lineScan_Row, i:i+minWidth) == 1 %minimales weißes Fenster
            glas = glas + 1;
            j = 0;
            while BW(lineScan_Row, i+j+minWidth) == 1 %Breite der Flüssigkeit ermitteln für den Mittelpunkt
                j = j + 1;
                if (i+j+minWidth) > breite
                    break
                end
            end
            glasbreite = minWidth+j-1;
            halbe_glasbreite = round(glasbreite/2);
            V(glas) = halbe_glasbreite + i;
        end
    end
    i = i + glasbreite + 1;
end

end

