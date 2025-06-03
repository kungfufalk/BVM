function topEdgeY = findUpperEdges(CannyI, mittelpunkte, pixelAreaYAxis)
% findUpperEdge findet die oberste Kante entlang des Mittelpunktes eines Glases im Canny-Bild.

[height, width] = size(CannyI);
numGlasses = numel(mittelpunkte);
topEdgeY = zeros(1, numGlasses); % Speicher reservieren

for glas = 1:numGlasses
    j = mittelpunkte(glas);  % j = x-Position des aktuellen Glases
    
    % Prüfe, ob j-2:j+2 innerhalb des Bildbereichs liegt
    if j - 2 < 1 || j + 2 > width
        warning('Mittelpunkt %d zu nah am Bildrand. Übersprungen.', j);
        continue;
    end

    for i = pixelAreaYAxis  % i = y-Position
        if i + 1 > height  % Prüfe, ob Index über das Bild hinausgeht
            break;
        end

        regionAbove = CannyI(i, j-2:j+2);

        if any(regionAbove == 1)
            topEdgeY(glas) = i;
            break;
        end
    end
end
end
