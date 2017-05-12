
function [r,p] = Xcorr_w(x1,x2)
    for i=1:length(x2)-length(x1)
        [r(1,i), p(1,i)] = corr(x1',x2(i:i+length(x1)-1)');
    end
end
