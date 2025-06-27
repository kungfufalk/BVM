function K = segmentEggs(I)

K = 255-I;

n = countEggs(K);
[hatchedEggs, num_parasite_eggs] = countParasitedEggsAndHatched(K, I);

hatchedEggs
num_parasite_eggs
n
end
