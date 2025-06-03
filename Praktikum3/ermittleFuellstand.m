function K = ermittleFuellstand(I)
%ermittleFuellstand

% zu lösende Probleme:
% 0. Region Labeling, um einzelne Gefäße anzusprechen (altes Bild muss
% erhalten bleiben)
% 1. obere Kante des unteren Kreises vom Gel
% 2. obere Kante des Farbübergangs vom Gel
% 3. untere Kante des Gefäßdeckels

% Mustererkennung:
% Histogrammbasiert -> einfach und könnte gut funktionieren
% Anhand von Canny -> optimale Kanten, komplexer, wie soll die
% anschließende Zuordnung geschehen?
% Anhand von Region Labeling -> Objektsegmentierung über Farbwerte

K = I;
%imgaussfilt(K);
%K = histeq(K);
%K = edge(K, 'Canny', [], 4);
%K = grayconnected(K, 1, 1);
level = graythresh(I);
BW = imbinarize(I,level);

figure;
imshow(BW);
axis on;

[hoehe, breite] = size(BW);

glas = 0;

minWidth = 125;

lineScan_Row = 540;

mittelpunkte = findMiddle(I, minWidth, lineScan_Row);

figure;
imshow(I);
axis on;
hold on; 

for i = 1:numel(mittelpunkte)
    x = repmat(mittelpunkte(i), hoehe, 1); % vertikale Linie an x-Position
    y = (1:hoehe)';                        % von oben bis unten
    plot(x, y, 'r', 'LineWidth', 1.5);     % rote Linie
end

K = edge(I, 'Canny');

C = edge(I, 'Canny', [], 2);

figure;
imshow(C);

topEdges = findlowerEdges(K, mittelpunkte, 250:350);

middleEdges = findUpperEdges(K, mittelpunkte, 450:550);

lowerEdges = findUpperEdges(C, mittelpunkte, 550:600);

fillPercentages = calculateFillPercentages(topEdges, middleEdges, lowerEdges);

topEdges

middleEdges

lowerEdges

fillPercentages;

figure; imshow(K);
axis on;
hold on;
plot(mittelpunkte,topEdges,'ro', 'MarkerSize', 5, 'LineWidth', 2);
plot(mittelpunkte,middleEdges,'bo', 'MarkerSize', 5, 'LineWidth', 2);
plot(mittelpunkte,lowerEdges,'go', 'MarkerSize', 5, 'LineWidth', 2);

end

