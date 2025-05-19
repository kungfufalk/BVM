function L = findEyes(I)
%findEyes berechnet die Augenhöhe unter der Annahme, dass in der Pixelhöhe
%die meisten senkrechten Kanten gefunden werden

[hoehe, breite] = size(I);

S_x = double((1/8)*[-1 0 1; -2 0 2; -1 0 1]);

G_x = double(faltung(I, S_x));

G_x_abs = abs(G_x);

L = zeros(hoehe);

for m=1:hoehe
    L(m) = sum(G_x_abs(m, :));
end

figure;gesichtGrafik(I, L);

end