function lowestEdgeY = findLowerEdges(CannyI, mittelpunkte, pixelAreaYAxis)
% findLowerEdge findet die unterste Kante entlang des Mittelpunktes eines Glases im Canny-Bild.

[height, width] = size(CannyI);
numGlasses = numel(mittelpunkte);
lowestEdgeY = zeros(1, numGlasses); % Speicher reservieren

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
        regionBelow = CannyI(i+1:pixelAreaYAxis(end), j-2:j+2);

        if any(regionAbove == 1) && all(regionBelow(:) == 0)
            lowestEdgeY(glas) = i;
            break;
        end
    end
end
end
