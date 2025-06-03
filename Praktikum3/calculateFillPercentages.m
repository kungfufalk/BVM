function fillPercentages = calculateFillPercentages(topEdges, middleEdges, lowerEdges)
maxHeight = topEdges - lowerEdges;
fillHeight = middleEdges - lowerEdges;
fillPercentages = fillHeight / maxHeight;
end