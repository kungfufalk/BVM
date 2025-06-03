function lowestEdgeY = findLowerEdges(CannyI, mittelpunkte, pixelAreaYAxis)
% findLowerEdge findet die unterste Kante entlang des Mittelpunktes eines Glases im Canny-Bild.

[height, width] = size(CannyI);
anzGlaeser = numel(mittelpunkte);
lowestEdgeY = zeros(1, anzGlaeser); % Speicher reservieren

for glas = 1:anzGlaeser
    j = mittelpunkte(glas);  % j = x-Position des aktuellen Glases

    for i = pixelAreaYAxis  % i = y-Position
        if i + 1 > height  % Prüfe, ob Index über das Bild hinausgeht
            break;
        end

        regionHorizontal = CannyI(i, j-2:j+2);
        regionBelow = CannyI(i+1:pixelAreaYAxis(end), j-2:j+2);
        
        % bin ich auf einer linie und unter mir ist nur noch Schwarz?
        if any(regionHorizontal == 1) && all(regionBelow(:) == 0)
            lowestEdgeY(glas) = i;
            break;
        end
    end
end
end
