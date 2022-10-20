function  [L] = PathLoss(d,f)
%PathLoss - Description
%
% Syntax:  [] = PathLoss(input)
%
% Long description
    for i=1: length(f)
        L(i,:) = 32.4 + 20*log10(d) + 20*log10(f(i));
    end

    
end