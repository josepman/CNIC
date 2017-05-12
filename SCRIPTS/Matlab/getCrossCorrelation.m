%% NORMALIZED CROSS-CORRELATION FUNCTION

% Esta funcion calcula la correlación cruzada entre dos vectores dados
% (Sample y Ref), a partir de su definición (por energias).

% Codigo de DANI *.

function r = getCrossCorrelation(Sample, Ref)
    c = zeros(size(Sample)); 
    correlation = 0;
    sampleEnergy = 0;
    refEnergy = 0;

    for i = 1:size(Sample,1)
        for j = 1:size(Sample,2)
            correlation = correlation + Sample(i,j)*Ref(1,j);
            sampleEnergy = sampleEnergy + Sample(i,j)^2;
            refEnergy = refEnergy + Ref(1,j)^2;
            c(i,j) = correlation/(sqrt(sampleEnergy*refEnergy));
        end
    end
    r = max(c);
end

%function r = getCrossCorrelation(Sample, Ref)
%    c = zeros(size(Sample)); 
%    correlation = 0;
%    sampleEnergy = 0;
%    refEnergy = 0;

%    for i = 1:size(Sample,1)
%        for j = 1:size(Sample,2)
%            correlation = correlation + Sample(i,j)*Ref(1,j));
%            sampleEnergy = (sampleEnergy + Sample(i,j)^2) - mean (sampleEnergy);
%            refEnergy = (refEnergy + Ref(1,j)^2) - mean(refEnergy);
%            c(i,j) = (sampleEnergy*refEnergy)/j*(var(sampleEnergy)*var(ref);
%        end
%    end
%    r = max(c);
%end