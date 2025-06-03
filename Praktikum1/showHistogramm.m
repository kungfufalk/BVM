% Anzeige des Histogramms und des kummulierten Histogramms
%
% K=showHistogramm(I)   I=Eingangsbildmatrix
%                       [H, KH]=invertierte Bildmatrix

function [H, KH]=showHistogramm(I)

H = zeros(256,1, 'double');
KH = zeros(256,1, 'double');

[hoehe, breite] = size(I);

for i=1:hoehe
    for j=1:breite
        grauwert = I(i,j);
        grauwertIndex = grauwert + 1;
	    H(grauwertIndex,1) = H(grauwertIndex,1) + 1;
    end
end

H = H / (hoehe*breite);

for i=1:256
    KH(i,1) = sum(H(1:i, 1));
end

x=[0:1:255];

figure;
h = stem(x,H);
set(h, 'Marker', 'none');
title('Histogramm');
xlabel('Grauwert');
ylabel('Anzahl');

figure;
kh = stem(x,KH);
set(kh, 'Marker', 'none');
title('kummuliertes Histogramm');
xlabel('Grauwert');
ylabel('kummulierte Anzahl');
% falls das invertierte Bild K sofort hier angezeigt werden soll 
% figure,imshow(K),