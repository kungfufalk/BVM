function fillPercentages = calculateFillPercentages(topEdges, middleEdges, lowerEdges)
maxHeight = topEdges - lowerEdges; % maximale Füllhöhe
fillHeight = middleEdges - lowerEdges; % Füllhöhe
fillPercentages = fillHeight ./ maxHeight; % Prozentuale Füllhöhe
end