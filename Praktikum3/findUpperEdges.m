function topEdgeY = findUpperEdges(CannyI, mittelpunkte, pixelAreaYAxis)
% findUpperEdge findet die oberste Kante entlang des Mittelpunktes eines Glases im Canny-Bild.

[height, ~] = size(CannyI);
anzGlaeser = numel(mittelpunkte);
topEdgeY = zeros(1, anzGlaeser); % Speicher reservieren

for glas = 1:anzGlaeser
    j = mittelpunkte(glas);  % j = x-Position des aktuellen Glases

    for i = pixelAreaYAxis  % i = y-Position
        if i + 1 > height  % Prüfe, ob Index über das Bild hinausgeht
            break;
        end

        regionHorizontal = CannyI(i, j-2:j+2);

        if any(regionHorizontal == 1)
            topEdgeY(glas) = i;
            break;
        end
    end
end
end
